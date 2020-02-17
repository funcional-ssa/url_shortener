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
          {200, post_url(url)}

        _ ->
          {422, missing_url()}
      end

      send_resp(conn, status, body)
  end

  defp post_url(url) do
    short_url = UrlShortener.insert(url)

    Poison.encode!(%{short_url: short_url})
  end

  defp missing_url do
    Poison.encode!(%{response: "Url not received"})
  end

  match _ do
    send_resp(conn, 404, "Nothing Here HeHe Xd :/")
  end
end
