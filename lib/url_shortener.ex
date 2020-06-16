defmodule UrlShortener do

  def insert(url) do
    key = Generator.generate_key()

    DBConnector.insert_key({key, url})
  end

  def get_url(key) do
    result = DBConnector.get_by_key(key)
    IO.inspect result
    result
  end
end

