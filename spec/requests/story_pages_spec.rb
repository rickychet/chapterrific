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
      it "should not create a story with empty content" do
        expect { click_button "Create Story" }.not_to change(Story, :count)
      end
      it "should not create a story with invalid limits" do
        fill_in "Title",    with: "The Raven"
        fill_in "Body", with: "Once upon a midnight dreary, while I pondered weak and weary"
        fill_in "Lower limit", with: "20"
        fill_in "Upper limit", with: "10"
        expect { click_button "Create Story" }.not_to change(Story, :count)
      end
    end
    
    describe "with valid information" do
    before do
      fill_in "Title",    with: "The Raven"
      fill_in "Body", with: "Once upon a midnight dreary, while I pondered weak and weary" 
    end
    it "should create a story with no limits specified" do
      expect { click_button "Create Story" }.to change(Story, :count).by(1)
    end 
    it "should create a story with valid limits" do
        fill_in "Lower limit", with: "10"
        fill_in "Upper limit", with: "20"
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
    describe "delete link for correct user" do
    it { should have_link("Delete")}
    end
    
    describe "delete link for incorrect user" do
      let(:user2) { FactoryGirl.create(:user) }
      before do
        click_link("Sign out")
        sign_in user2
        visit story_path(story)
      end
      it {should_not have_link("Delete")}
    end
    
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
    