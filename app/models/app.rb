#encoding: utf-8
class App < ActiveRecord::Base
  before_validation :parse_data
  #validates_presence_of :slug
  validates :slug, format: {with: /\A[a-z0-9\-]+\Z/,message: "仅由小写字母与数字组成"}
  default_scope ->{ where.not(name: nil)}
  scope :recent, ->{ order('found_at desc')}
  scope :top, ->{ order('uv desc')}
  scope :popular, ->{ order('fans_count desc')}
  acts_as_taggable
  def to_param
    slug
  end
  def url
    slug.present? ? "http://#{slug}.uz.taobao.com" : nil
  end
  def parse_data
    if m = slug.match(/http:\/\/(.+?).uz.taobao.com/)
      self.slug = m[1]
    end
    if name.nil?
      import_data
    end
  end
  def import_data
    if o_site_id.nil?
      @url = url + '/'
      page =Anemone::HTTP.new.fetch_page @url
      if page.fetched?
        txt = page.doc.css("script").collect{|s| s.text}.join
        self.o_site_id =  txt.match(/siteId: \"(.+?)\"/)[1]
        str = page.doc.css("meta").collect{|s| s.attr("content")}.join
        self.o_user_id = str.match(/userId=(\d+)/i)[1]
      end
    end
    @dataurl = "http://admin.uz.taobao.com/index.do?action=site/GetSiteCommonHeader&event_submit_do_getSiteInfo=true&userId=#{o_user_id}&siteId=#{o_site_id}&jsonp=jsonp75"
    page =Anemone::HTTP.new.fetch_page @dataurl
    if page.fetched?
      data = JSON.parse(page.body.match(/jsonp75\((.+)\)$/)[1])
      data["desc"] = HTMLEntities.new.decode(data["desc"])
      data.delete("cnzzSiteId")
      data.delete("url")
      data.delete("siteName")
      hash = {"desc"=> "description","siteType"=> "site_type",
        "gmtCreate"=> "found_at", "tag"=> "keywords"}
      data.each do |k,v|
        hash.key?(k) ? self[hash[k]] = v : self[k.downcase] = v
      end
      self.tag_list = keywords
    end
    @counturl = "http://count.tbcdn.cn/counter3?keys=ZAN_27_1100036:1_#{o_user_id}_#{o_site_id}&callback=jsonp49"
    page =Anemone::HTTP.new.fetch_page @counturl
    if page.fetched?
      self.fans_count = JSON.parse(page.body.match(/jsonp49\((.+)\);$/)[1]).values[0]
    end
    self
  end
  def self.tag_counts
    ActsAsTaggableOn::Tagging.
      select("tags.name,taggings.tag_id,count(taggings.tag_id) as count").
      group("taggings.tag_id").having("count > 0").
      joins("join tags on tags.id = taggings.tag_id")
  end
  def self.tag_counts_on str
    ActsAsTaggableOn::Tag.
    select("tags.*,taggings.count").
    joins("JOIN (SELECT taggings.tag_id,count(taggings.tag_id) as count FROM taggings GROUP BY taggings.tag_id HAVING count > 0) as taggings on taggings.tag_id = tags.id")
    #super str
  end
end
