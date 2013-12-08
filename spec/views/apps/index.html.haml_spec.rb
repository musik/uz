require 'spec_helper'

describe "apps/index" do
  before(:each) do
    assign(:apps, [
      stub_model(App,
        :o_site_id => 1,
        :o_user_id => 2,
        :slug => "Slug",
        :name => "Name",
        :owner => "Owner",
        :pagetype => 3,
        :uv => 4,
        :punish => false,
        :keywords => "Keywords",
        :site_type => "Site Type",
        :description => "Description",
        :logo => "Logo"
      ),
      stub_model(App,
        :o_site_id => 1,
        :o_user_id => 2,
        :slug => "Slug",
        :name => "Name",
        :owner => "Owner",
        :pagetype => 3,
        :uv => 4,
        :punish => false,
        :keywords => "Keywords",
        :site_type => "Site Type",
        :description => "Description",
        :logo => "Logo"
      )
    ])
  end

  it "renders a list of apps" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Owner".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Keywords".to_s, :count => 2
    assert_select "tr>td", :text => "Site Type".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Logo".to_s, :count => 2
  end
end
