require 'spec_helper'

describe "Story pages" do
  
  subject { page }
  
  let(:user) { FactoryGirl.create(:user) }
  
  before { sign_in user }
  let(:story) { FactoryGirl.create(:story, user: user) }
  
  describe "view story" do
    before { visit story_path(story) }
    
    it should have_content(story.title)
    it should have_content(story.body)
  end
end
    