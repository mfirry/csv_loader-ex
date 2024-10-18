use Mix.Config

config :kaffe,
  producer: [
    endpoints: [{"localhost", 9092}], # Adjust Kafka broker endpoint
    topics: ["brands_topic"],          # Kafka topic
    partition_strategy: :md5           # Partitioning strategy
  ]

