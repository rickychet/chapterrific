require 'spec_helper'

describe "Story pages" do
  
  subject { page }
  
  let(:user) { FactoryGirl.create(:user) }
  
  describe "story creation" do
    before do
      sign_in user
      visit new_story_path
    end
    
    describe "with invalid information" do
      it "should not create a story" do
        expect { click_button "Create Story"}.not_to change(Story, :count)
      end
    end
    
    describe "with valid information" do
    before do
      fill_in "Title",    with: "The Raven"
      fill_in "Body", with: "Once upon a midnight dreary, while I pondered weak and weary"
    end
    it "should create a story" do
      expect { click_button "Create Story" }.to change(Story, :count).by(1)
    end 
  end
end
  
  describe "view story" do
    
    let(:story) { FactoryGirl.create(:story, user: user) }
    before do
      sign_in user
      visit story_path(story)
    end
    
    it { should have_content(story.title) }
    it { should have_content(story.body) }
    
    describe "change story content" do
      let(:oldbody) { story.body }
      describe "before submitting edits" do
        it { should have_content(story.title) }
        it { should have_content(story.body) }
      end
      
      describe "after submitting edits" do
      before do
        visit edit_story_path(story)
        fill_in "Addition", with: "New content"
        click_button "Add to Story"
      end
      it { should have_content(story.title) }
      it { should have_content(story.body) }
      it { should have_content(oldbody) }
    end
      
    end
  end
end
    