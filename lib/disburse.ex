defmodule Sequra.Disburse do
  defstruct [:merchant_id, :shopper_id, :order_id, 
             :amount, :fee, :total_amount, :completed_at, :created_at]
  
  alias Sequra.{Disburse, Order}

  def generate_report(orders, date) do
    date_range = Order.get_range(date)
    records = orders
      |> Order.weekly_orders(date_range, :completed)
      |> apply_fees
    %{date_range: date_range, orders: records}
  end

  def apply_fees(orders) do
    Enum.map(orders, fn(order) -> 
      record       = struct(%Disburse{}, Map.from_struct(order))
      order_fee    = Sequra.order_fee(order.amount)
      order_amount = Sequra.order_amount(order.amount)
      %Disburse{record | fee: order_fee, total_amount: order_amount, order_id: order.id }      
    end)
  end
end
