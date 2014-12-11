require 'spec_helper'
require File.expand_path('../../../models/page', __FILE__)
describe Page do

  before(:each) do
    Page.destroy_all
  end

  # # Exercise should be deleted afterwards
  # it "should be exercisable" do
  #   page = Page.new
  #   page.should respond_to(:save)
  #   Page.should respond_to(:find)
  # end

  it "should be persistable" do
    count = Page.count
    page = Page.create
    expect( Page.count ).to  eq(count + 1)
  end

  it "should be findable" do
    page = Page.create
    expect( Page.find(page.id)).to eq(page)
  end

end
