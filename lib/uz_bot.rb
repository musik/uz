class UzBot
  class << self
    def tp999
      Anemone.crawl('http://uz.tp999.net/') do |anemone|
        slugs = []
        anemone.on_every_page do |page|
          uz_links(page).each do |str|
            next if slugs.include?(str)
            App.unscoped.find_or_create_by(slug: str) rescue next
            slugs << str
          end
        end
      end
    end
    def uz_links(page)
      @links =[]
      return @links if !page.doc
      page.doc.css("a").each do |a|
        u = a.attributes['href'].content rescue nil
        next if u.nil? or u.empty?
        if m = u.match(/http:\/\/(?:www)*([a-z0-9\-]+?).uz.taobao.com/i)
          @links << m[1]
        end
      end
      @links.uniq!
      @links
    end
  end
end
