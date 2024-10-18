defmodule KafkaProducerBrod do
  @moduledoc """
  Kafka producer using Brod to send brand data to a Kafka topic.
  """
  
  require Logger
  alias CsvLoader.Brand
  
  # Kafka configuration
  @kafka_brokers [{"localhost", 9092}]   # Adjust the Kafka broker as needed
  @topic "brands_topic"                  # The Kafka topic name

  # Function to send a Brand struct to Kafka
  def send_brand_to_kafka(%Brand{} = brand) do
    # Serialize the Brand struct to JSON
    brand_json = serialize_brand(brand)

    # Produce the message to Kafka
    case :brod.produce_sync(@kafka_brokers, @topic, 0, "", brand_json) do
      :ok ->
        Logger.info("Successfully sent brand to Kafka: #{inspect(brand)}")
        :ok
      {:error, reason} ->
        Logger.error("Failed to send brand to Kafka: #{reason}")
        {:error, reason}
    end
  end

  # Helper function to serialize the Brand struct to JSON
  defp serialize_brand(brand) do
    Jason.encode!(brand)
  end
end
