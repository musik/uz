require 'spec_helper'

describe "apps/new" do
  before(:each) do
    assign(:app, stub_model(App,
      :o_site_id => 1,
      :o_user_id => 1,
      :slug => "MyString",
      :name => "MyString",
      :owner => "MyString",
      :pagetype => 1,
      :uv => 1,
      :punish => false,
      :keywords => "MyString",
      :site_type => "MyString",
      :description => "MyString",
      :logo => "MyString"
    ).as_new_record)
  end

  it "renders new app form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", apps_path, "post" do
      assert_select "input#app_o_site_id[name=?]", "app[o_site_id]"
      assert_select "input#app_o_user_id[name=?]", "app[o_user_id]"
      assert_select "input#app_slug[name=?]", "app[slug]"
      assert_select "input#app_name[name=?]", "app[name]"
      assert_select "input#app_owner[name=?]", "app[owner]"
      assert_select "input#app_pagetype[name=?]", "app[pagetype]"
      assert_select "input#app_uv[name=?]", "app[uv]"
      assert_select "input#app_punish[name=?]", "app[punish]"
      assert_select "input#app_keywords[name=?]", "app[keywords]"
      assert_select "input#app_site_type[name=?]", "app[site_type]"
      assert_select "input#app_description[name=?]", "app[description]"
      assert_select "input#app_logo[name=?]", "app[logo]"
    end
  end
end
