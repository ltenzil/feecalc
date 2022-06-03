defmodule Sequra.Shopper do
  defstruct [:id, :name, :email, :nif]
  
  alias Sequra.DataLoader

  @data_source Application.get_env(:sequra, __MODULE__)[:data_source]

  def list do
    DataLoader.load(data_source(), %__MODULE__{})
  end

  defp data_source(), do: @data_source
end
