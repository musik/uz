require 'spec_helper'

describe "apps/show" do
  before(:each) do
    @app = assign(:app, stub_model(App,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Slug/)
    rendered.should match(/Name/)
    rendered.should match(/Owner/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/false/)
    rendered.should match(/Keywords/)
    rendered.should match(/Site Type/)
    rendered.should match(/Description/)
    rendered.should match(/Logo/)
  end
end
