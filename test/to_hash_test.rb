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

    should "allow to include other objects in hash" do
      hash = @project1.to_hash([:authors, :first_name])
      assert_equal hash, { :authors => [{ :first_name => "John" }, { :first_name => "Michael" }, { :first_name => "Jimmy" }] }
    end

    should "allow to include other objects with multiple attributes in hash" do
      hash = @project1.to_hash([:authors, :first_name, :last_name])
      assert_equal hash, { :authors => [{ :first_name => "John", :last_name => "Doe" },
                                        { :first_name => "Michael", :last_name => "Smith" },
                                        { :first_name => "Jimmy", :last_name => "Parker" }] }
    end

    should "allow to include other objects with changed key" do
      hash = @project1.to_hash(:people => [:authors, :first_name])
      assert_equal hash, { :people => [{ :first_name => "John" }, { :first_name => "Michael" }, { :first_name => "Jimmy" }] }
    end

    should "allow to include other objects with inner keys changed" do
      hash = @project1.to_hash(:people => [:authors, { :firstName => :first_name }])
      assert_equal hash, { :people => [{ :firstName => "John" }, { :firstName => "Michael" }, { :firstName => "Jimmy" }] }
    end

    should "allow using different serialization methods described above" do
      hash = @project1.to_hash(:title, [:authors, { :firstName => :first_name }])
      assert_equal hash, { :title => "Project 1", :authors => [{ :firstName => "John" }, { :firstName => "Michael" }, { :firstName => "Jimmy" }]}
    end

    should "serialize singular nested object" do
      hash = @project1.to_hash(:title, [:company, :name])
      assert_equal hash, { :title => "Project 1", :company => { :name => "HAL" } }
    end
  end
end

