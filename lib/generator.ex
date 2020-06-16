defmodule Generator do
  def generate_key() do
    UUID.uuid4()
    |> String.slice(0,8)
  end
end
