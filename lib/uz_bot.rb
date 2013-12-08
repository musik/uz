class UzBot
  class << self
    def tp999
      Anemone.crawl('http://uz.tp999.net/') do |anemone|
        anemone.on_every_page do |page|
          pp page.url
        end
      end
    end
  end
end
