defmodule CsvLoader do
  alias KafkaProducerBrod

  defmodule Brand do
    defstruct category: nil, brand: nil

    # Implement the Jason encoder for the Brand struct
    defimpl Jason.Encoder do
      def encode(%CsvLoader.Brand{category: category, brand: brand}, opts) do
        # Convert the struct into a map for encoding
        Jason.Encode.map(%{category: category, brand: brand}, opts)
      end
    end
  end  

  NimbleCSV.define(MyParser, separator: ",", escape: "\"")

  def print_csv(file_path) do
    case File.read(file_path) do
      {:ok, content} ->
        content
        |> MyParser.parse_string()
        |> Enum.map(&row_to_struct/1)
        |> Enum.each(&send_to_kafka/1)

      {:error, reason} ->
        IO.puts("Failed to read file: #{reason}")
    end
  end

  defp row_to_struct([brand, category]) do
    %Brand{brand: brand, category: category}
  end

  defp send_to_kafka(brand) do
    KafkaProducerBrod.send_brand_to_kafka(brand)
  end
end
