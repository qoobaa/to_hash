require "test/unit"
require "shoulda"
require "ostruct"

require File.join(File.dirname(__FILE__), "..", "lib", "to_hash")

class ToHashTest < Test::Unit::TestCase
  context "project structures serialization" do
    setup do
      @project1 = OpenStruct.new(:title => "Project 1", :description => "Project 1 description")
      @project2 = OpenStruct.new(:title => "Project 2")
      @project3 = OpenStruct.new(:title => "Project 3")

      @project1.authors = []
      @project1.authors << OpenStruct.new(:first_name => "John", :last_name => "Doe", :projects => [@project1])
      @project1.authors << OpenStruct.new(:first_name => "Michael", :last_name => "Smith", :projects => [@project1, @project2])
      @project1.authors << OpenStruct.new(:first_name => "Jimmy", :last_name => "Parker", :projects => [@project1, @project2, @project3])
      @project1.company = OpenStruct.new(:name => "HAL")

      @project1.extend(ToHash)
    end

    should "return empty hash when no arguments given" do
      hash = @project1.to_hash
      assert_equal hash, {}
    end

    should "serialize data using title symbol" do
      hash = @project1.to_hash(:title)
      assert_equal hash, { :title => "Project 1" }
    end

    should "serialize data using title and description" do
      hash = @project1.to_hash(:title, :description)
      assert_equal hash, { :title => "Project 1", :description => "Project 1 description" }
    end

    should "allow to change one key in hash" do
      hash = @project1.to_hash(:myTitle => :title)
      assert_equal hash, { :myTitle => "Project 1" }
    end

    should "allow to change multiple keys in hash" do
      hash = @project1.to_hash(:myTitle => :title, :myDesc => :description)
      assert_equal hash, { :myTitle => "Project 1", :myDesc => "Project 1 description" }
    end

    # TODO: more test (no time right now)
  end
end

