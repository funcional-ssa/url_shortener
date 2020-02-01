defmodule UrlShortener do
  def get_short_url(url) do
    case get_key(url) do
      nil -> insert(url)
      key -> key
    end
  end

  def insert(url) do
    key = Generator.generate_key()

    {key, url} |> DBConnector.insert_key()

    key
  end

  def get_url(key) do
    %{"url"=> url} = DBConnector.get_by_key(key)
    url
  end

  defp get_key(url) do
    case DBConnector.get_by_url(url) do
      %{"key" => key} -> key
      _ -> nil
    end
  end
end
