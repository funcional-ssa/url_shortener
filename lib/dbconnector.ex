defmodule DBConnector do
  def get_by_key(key) do
    case Redix.command(connection(), ["GET", key]) do
      {:ok, result} -> {:ok, result}
      {:error, reason} -> {:error, reason}
    end
  end

  def insert_key({key, original_url}) do
    case Redix.command(connection(), ["SET", key, original_url]) do
      {:ok, _} -> {:ok, key}
      {:error, reason} -> {:error, reason}
    end
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
