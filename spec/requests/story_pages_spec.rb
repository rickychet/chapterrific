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
        expect { click_button "Create Story" }.not_to change(Story, :count)
      end

      describe "with a smaller upper limit" do
        before do
          visit new_story_path
          fill_in "Title",    with: "The Raven"
          fill_in "Body", with: "Once upon a midnight dreary, while I pondered weak and weary"
          fill_in "Upper limit", with: "10"
          fill_in "Lower limit", with: "100"
        end

        it "should not create a story" do
          expect { click_button "Create Story" }.not_to change(Story, :count)
        end
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
  
  describe "view/edit story" do
    
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
        it { should have_content('New content') }
      end
    end

    describe "change story content with limits" do
      let(:newuser) { FactoryGirl.create(:user) }
      let(:limit_story) { FactoryGirl.create(:story, user: user) } #limits: lower-20 upper-50
      let(:old_body) { limit_story.body }
      before do
        sign_in user
        visit edit_story_path(limit_story)
      end

      subject { limit_story.body }

      describe "addition too short" do
        before do
          fill_in "Addition", with: "Too short"
          click_button "Add to Story"
        end

        it { should_not have_content("Too short") }
      end

      describe "addition too long" do
        before do
          visit story_path(limit_story)
          fill_in "Addition", with: "This string is too long, which means it shouldn't be added to the story"
          click_button "Add to Story"
        end

        it { should_not have_content("This string is too long, which means it shouldn't be added to the story") }
      end

      describe "addition just right" do
        before do
          visit story_path(limit_story)
          fill_in "Addition", with: "This string is the perfect length"
          click_button "Add to Story"
        end

        it { should have_content("This string is the perfect length") }
      end
    end
  end
end
