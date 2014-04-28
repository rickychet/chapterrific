require 'spec_helper'

describe "Story pages" do
  
  subject { page }
  
  let(:user) { FactoryGirl.create(:user) }
  
  describe "view story" do
    
    let(:story) { FactoryGirl.create(:story, user: user) }
    before do
      sign_in user
      visit story_path(story)
    end
    
    it {  should have_content(story.title) }
    it { should have_content(story.body) }
  end
end
    