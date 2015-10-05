defmodule KafkaWorker do
  use GenServer

  @name Kafka

  #Client API
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, [], name: Kafka)
  end

  def push_news(news_item) do
    GenServer.cast(Kafka, {:push, news_item})
  end

  #Server Callbacks

  def handle_cast({:push, news_item}, news) do
    case Enum.member?(news, news_item) do
      true -> {:noreply, news}
      _    ->
              KafkaEx.produce("news", 0, Poison.encode!(news_item))
              {:noreply, [news_item]}
    end
  end
end
