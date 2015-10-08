defmodule RSSReader.Mixfile do
  use Mix.Project

  def project do
    [app: :rss_reader,
     version: "0.0.1",
     elixir: "~> 1.1",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     escript: [main_module: RSSReader],
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison, :sweet_xml, :kafka_ex]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:httpoison, "~> 0.7.2"}, {:sweet_xml, "0.4.0"}, {:kafka_ex, "~> 0.2.0"}, {:snappy,
       git: "https://github.com/ricecake/snappy-erlang-nif",
       tag: "270fa36bee692c97f00c3f18a5fb81c5275b83a3"}, {:poison, "~> 1.5"}]
  end
end
