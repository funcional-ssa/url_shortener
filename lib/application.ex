defmodule UrlShortener.Application do
    use Application

    def start(_type, _args) do
      children = [
        Plug.Cowboy.child_spec(
          scheme: :http,
          plug: UrlShortener.Endpoint,
          options: [port: Application.get_env(:url_shortener, :port)]
        )
      ]

      opts = [strategy: :one_for_one, name: UrlShortener.Supervisor]
      Supervisor.start_link(children, opts)
    end
end
