defmodule Generator do
  def generate_key() do
    UUID.uuid4()
    |> get_unique_key()
  end

  defp get_unique_key(uuid) do
    key =
      uuid
      |> String.slice(0,8)

    case url_exists_on_db(key) do
      {:ok, false} -> key
      {:ok, true} -> get_unique_key(UUID.uuid4)
    end
  end

  defp url_exists_on_db(hash) do
    case DBConnector.get_by_key(hash) do
      nil -> {:ok, false}
      _ -> {:ok, true}
    end
  end
end
