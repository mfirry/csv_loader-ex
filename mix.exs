defmodule CsvLoader.MixProject do
  use Mix.Project

  def project do
    [
      app: :csv_loader,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:nimble_csv, "~> 1.0"},
      {:brod, "~> 3.16"},    # Add Brod for Kafka
      {:jason, "~> 1.2"}     # Jason for JSON encoding
    ]
  end
end
