defmodule Sequra.MerchantTest do
  use ExUnit.Case
  doctest Sequra.Merchant

  setup_all do
    merchants = Sequra.Merchant.list()
    {:ok, merchants: merchants}
  end

  test "should load and validate merchant struct", %{merchants: merchants} do    
    record  = List.first(merchants)
    %type{} = record
    assert type == Sequra.Merchant
  end

  test "should check merchant data", %{merchants: merchants} do    
    record  = List.first(merchants)
    assert record.name == "Flatley-Rowe"
  end

end
