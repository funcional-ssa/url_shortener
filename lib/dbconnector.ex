defmodule DBConnector do
  def get_by_key(key) do
    Redix.command(connection(), ["GET", key])
  end

  def insert_key({key, original_url}) do
    Redix.command(connection(), ["SET", key, original_url])
  end

  defp connection do
    case Redix.start_link(host: "localhost", port: 6379) do
      {:ok, conn} ->
        conn
      {:error, reason} ->
        IO.puts(reason)
    end
  end
end
