defmodule Sequra.Order do
  @moduledoc false
  defstruct [:id, :merchant_id, :shopper_id, :amount, :created_at, :completed_at]
  
  use Sequra.QueryHelpers
  alias Sequra.DataLoader

  @data_source Application.get_env(:sequra, __MODULE__)[:data_source]

  def list do
    DataLoader.load(data_source(), %__MODULE__{})
  end

  defp data_source(), do: @data_source

end

