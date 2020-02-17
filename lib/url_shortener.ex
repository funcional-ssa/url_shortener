defmodule UrlShortener do

  def insert(url) do
    key = Generator.generate_key()

    case DBConnector.insert_key({key, url}) do
      {:ok, _} -> key

      {:error, reason} -> IO.puts(reason)
    end
  end

  def get_url(key) do
    case DBConnector.get_by_key(key) do
      {:ok, result} ->

      {:error, reason} ->
    end
  end

end
