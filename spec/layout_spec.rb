require 'spec_helper'

RSpec.describe "layout", type: :feature, js: true do
  before do
    visit '/'
  end

  it "has the page title" do
    expect(page.title).to eq('Mixlr Tech')
  end

  it "has our logo" do
    expect(page).to have_css('#header h1 a img[src="/images/mixlrtech_small.png"]')
  end
end
