defmodule Sequra.DisburseTest do
  use ExUnit.Case
  doctest Sequra.Disburse

  setup_all do
    orders = Sequra.Order.list()
    {:ok, orders: orders}
  end

  test "should generate weekly reports", %{orders: orders} do    
    date = "01/06/2022"
    report = Sequra.Disburse.generate_report(orders, date)
    assert is_map(report) == true
    assert length(report[:orders]) == 2
  end

  test "should generate weekly reports with no data", %{orders: orders} do    
    date = "01/06/2021" 
    report = Sequra.Disburse.generate_report(orders, date)
    assert length(report[:orders]) == 0
  end

  test "should check fee in generated report", %{orders: orders} do
    date = "01/06/2022" 
    report = Sequra.Disburse.generate_report(orders, date)
    first_order = report[:orders] |> List.first()
    sequra_fee  =  Sequra.order_fee(first_order.amount)
    assert first_order.fee != 0
    assert sequra_fee == first_order.fee
  end
  
end
