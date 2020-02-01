defmodule DBConnector do
  @collection "test"
  def get_by_key(key) do
    find_one(%{key: key})
  end

  def get_by_url(url) do
    find_one(%{url: url})
  end

  def insert_key({key, original_url}) do
    Mongo.insert_one(connection(), @collection, %{key: key, url: original_url})
  end

  defp connection do
    {:ok, conn} = Mongo.start_link(url: "mongodb://localhost:27017/url")
    conn
  end

  defp find_one(filter) do
    Mongo.find_one(connection(), @collection, filter)
  end
end
