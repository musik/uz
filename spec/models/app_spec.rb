require 'spec_helper'

describe App do
  it "should parse_data " do
    App.create slug: "http://huiyuanjie.uz.taobao.com/"
    App.create slug: "womai"
  end
end
