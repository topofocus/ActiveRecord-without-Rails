require 'spec_helper'

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
    Page.count.should eq(count + 1)
  end

  it "should be findable" do
    page = Page.create
    Page.find(page.id).should eq(page)
  end

end