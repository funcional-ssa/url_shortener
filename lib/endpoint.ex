defmodule UrlShortener.Endpoint do
  use Plug.Router

  plug(Plug.Logger)

  plug(:match)

  plug(Plug.Parsers, parsers: [:json], json_decoder: Poison)

  plug(:dispatch)

  post "/" do
    {status, body} =
      case conn.body_params do
        %{"url" => url} ->
          post_url(url)

        _ ->
          {422, missing_url()}
      end

      send_resp(conn, status, body)
  end

  get "/ping" do
    send_resp(conn, 200, Poison.encode!(%{ok: "ok"}))
  end

  get "/*key" do
    case UrlShortener.get_url(key) do
      {:ok, nil} -> conn |> send_resp(404, "<html><head><title>Página não encontrada</title></head><body><h1>A página que você tentou acessar é corna</h1></body></body></html>") |> halt()
      {:ok, url} -> conn |> put_resp_header("location", url) |> send_resp(301, url)
      _ -> send_resp(conn, 500, "")
    end
  end

  defp missing_url do
    Poison.encode!(%{response: "Url not received"})
  end

  defp post_url(url) do
    valid? = fn url ->
      uri = URI.parse(url)
      uri.scheme != nil && uri.host =~ "."
      end

    cond do
      valid?.(url) ->
        case UrlShortener.insert(url) do
          {:ok, short_url} -> {200, Poison.encode!(%{url: short_url})}
          {:error, reason} -> {500, Poison.encode!(%{reason: reason})}
        end
      true -> {406, Poison.encode!(%{error: "URL Inválida"})}
    end
  end
end
