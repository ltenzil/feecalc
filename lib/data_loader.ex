defmodule Sequra.DataLoader do

  def load(file, struct_module \\ "") do
    try do
     data =  File.stream!(file)
      |> Enum.to_list()
      |> Poison.decode!(as: %{ "RECORDS" => [struct_module] })
      data["RECORDS"]    
    rescue
      _e -> [struct_module]
    end
  end
end
