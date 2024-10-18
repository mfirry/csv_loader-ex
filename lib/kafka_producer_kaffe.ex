defmodule KafkaProducerKaffe do
  alias CsvLoader.Brand
  require Logger

  def send_brand_to_kafka(%Brand{} = brand) do
    brand_json = serialize_brand(brand)

    case Kaffe.Producer.produce_sync("brands_topic", "", brand_json) do
      :ok ->
        Logger.info("Ok: #{inspect(brand)}")
        :ok
      {:error, reason} ->
        Logger.error("Ko: #{reason}")
        {:error, reason}
    end
  end

  defp serialize_brand(brand) do
    Jason.encode!(brand)
  end
end
