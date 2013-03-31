require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # Shoulda macros
  should have_many(:sections)
  should validate_presence_of(:name)
  should validate_uniqueness_of(:name).case_insensitive
  should allow_value(true).for(:active)
  should allow_value(false).for(:active)
  should_not allow_value(nil).for(:active)
  
  # Context for rest of testing
  context "Creating three events" do
    setup do
      create_event_context
    end
    
    teardown do
      remove_event_context
    end
    
    should "have working factories" do
      assert_equal "Sparring", @sparring.name
      assert_equal "Breaking", @breaking.name
      deny @weapons.active
    end
    
    should "have a scope to alphabetize events" do
      assert_equal ["Breaking", "Sparring", "Weapons"], Event.alphabetical.map(&:name)
    end
    
    should "have a scope to select only active events" do
      assert_equal ["Breaking", "Sparring"], Event.active.alphabetical.map(&:name)
    end
    
    should "have a scope to select only inactive events" do
      assert_equal ["Weapons"], Event.inactive.alphabetical.map(&:name)
    end
    
    should "verify that name is unique, including case insensitivity" do
      @break = FactoryGirl.build(:event, :name => "breaking")
      deny @break.valid?
      @swords = FactoryGirl.build(:event, :name => "Weapons")
      deny @swords.valid?
    end
  end
end
