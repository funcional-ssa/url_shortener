defmodule UrlShortener.EndpointTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @opts UrlShortener.Endpoint.init([])

  test "it returns 404 when no route matches" do
    conn = conn(:get, "/fail")

    conn = UrlShortener.Endpoint.call(conn, @opts)

    assert conn.status == 404
  end
end
