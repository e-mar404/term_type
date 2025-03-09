defmodule TermType.MixProject do
  use Mix.Project

  def project do
    [
      app: :term_type,
      version: "0.1.0",
      elixir: "~> 1.18",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  def application do
    [
      mod: {TermType.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:phoenix, "~> 1.7.20"},
      {:finch, "~> 0.13"},
      {:jason, "~> 1.2"},
      {:bandit, "~> 1.5"},
      {:plug_cowboy, "~> 2.0"}
    ]
  end
  
  defp aliases do
    [
      setup: ["deps.get"],
      run: ["phx.server"]
    ]
  end
end
