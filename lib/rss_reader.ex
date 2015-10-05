defmodule RSSReader do
  def main(argv) do
    run
  end

  import SweetXml

  def run do
    import SweetXml

    HTTPoison.start

    urls = ["http://yle.fi/uutiset/rss/uutiset.rss"]

    KafkaWorker.start_link

    do_work(urls)
  end

  defp do_work(urls) do
    Enum.each(urls, fn url -> make_request(url) |> parse_response |> KafkaWorker.push_news end)
    :timer.sleep(30000)
    do_work(urls)
  end

  defp make_request(url) do
    HTTPoison.get(url)
  end

  defp parse_response({:ok, %HTTPoison.Response{body: body}}) do
    content = body |> xpath(~x"//rss/channel/item/content:encoded/text()")
    guid = body |> xpath(~x"//rss/channel/item/guid/text()")
    %News{content: to_string(content), guid: to_string guid}
  end
end
