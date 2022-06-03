defmodule Sequra.QueryHelpers do

  defmacro __using__(_opts) do
    quote do

      @date_format "{0D}/{0M}/{YYYY}"
      def date_format(), do: @date_format
      @time_format "{0D}/{0M}/{YYYY} {h24}:{m}:{s}"
      def time_format(), do: @time_format
      
      def find_by(records, name: name) do
        Enum.filter(records, fn(record) ->
          record.name == name
        end)
        |> List.first
      end

      def find_by(records, email: email) do
        Enum.filter(records, fn(record) ->
          record.email == email
        end)
        |> List.first
      end

      def completed_orders([]), do: []
      def completed_orders(orders) do
        Enum.filter(orders, fn(order) ->
          order.completed_at != ""
        end)
      end

      def orders_by(_, id) when not(is_list(id)), do: []
      def orders_by(orders, _) when not(is_list(orders)), do: []

      def orders_by(orders, merchant_id: merchant_id) do
        Enum.filter(orders, fn(order) ->
          order.merchant_id == merchant_id
        end)
      end

      def orders_by(orders, shopper_id: shopper_id) do
        Enum.filter(orders, fn(order) ->
          order.shopper_id == shopper_id
        end)
      end
      
      
      def weekly_orders(orders, %Date.Range{} = date_range, :completed) do        
        orders
        |> completed_orders()
        |> Enum.filter(fn(order) ->            
          Enum.member?(date_range, format_date(order.completed_at, time_format()))
        end)
      end

      def weekly_orders(orders, %Date.Range{} = date_range, :created) do
        Enum.filter(orders, fn(order) ->            
          Enum.member?(date_range, format_date(order.created_at, time_format()))
        end)       
      end

      def weekly_orders(orders, %Date.Range{} = date_range) do
        weekly_orders(orders, date_range, :created)
      end
      def weekly_orders(_, _), do: []
      def weekly_orders(_, _, _), do: []

      def format_date(date, format) do
        case Timex.parse(date, format) do
          {:ok, date} -> Timex.to_date(date)
           _ -> ""
        end
      end

      def get_range(date) do
        format_date(date, date_format()) 
        |> week_range()
      end

      defp week_range(""), do: week_range(Date.utc_today())
      defp week_range(date) do
        Date.range(Date.beginning_of_week(date), Date.end_of_week(date))
      end

    end
  end
end
