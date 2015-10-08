defmodule KafkaWorker do
  use GenServer

  @name Kafka

  #Client API
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, %{}, name: Kafka)
  end

  def push_news(news_item) do
    GenServer.cast(Kafka, {:push, news_item})
  end

  #Server Callbacks

  def handle_cast({:push, news_item}, news) do
    case Dict.has_key?(news, news_item.guid) do
      true -> {:noreply, news}
      _    ->
              KafkaEx.produce("news", 0, Poison.encode!(news_item))
              {:noreply, Dict.put(news, news_item.guid, news_item)}
    end
  end
end
