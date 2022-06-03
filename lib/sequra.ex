defmodule Sequra do
  @moduledoc """
  Documentation for `Sequra`.
  """

  @spec fees(number) :: number
  def fees(amount) when is_number(amount) do
    case amount do
      amount when amount < 50 -> 0.01
      amount when amount >= 50 and amount <= 300 -> 0.0095
      amount when amount > 300 -> 0.0085
    end
  end

  def fees(amount) when is_binary(amount) do 
    amount
    |> format()
    |> fees()
  end

  def order_fee(amount) do
    amount     = format(amount)
    sequra_fee = fees(amount)
    amount * sequra_fee
  end

  def order_amount(amount) do
    amount = format(amount)
    sequra_fee = order_fee(amount)
    Float.round(amount - sequra_fee, 2)
  end

  def format(amount) when is_binary(amount) do
    {amount, _} = Float.parse(amount)
    amount
  end

  def format(amount) when is_number(amount), do: amount
end
