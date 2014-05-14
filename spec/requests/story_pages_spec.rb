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
  
  describe "view/edit story" do
    
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
          fill_in "Addition", with: "New content New content New content"
          click_button "Add to Story"
        end
        it { should have_content(story.title) }
        it { should have_content(story.body) }
        it { should have_content(oldbody) }
        it { should have_content('New content New content New content') }
      end
    end

    describe "change story content with limits" do
      let(:newuser) { FactoryGirl.create(:user) }
      let(:limit_story) { FactoryGirl.create(:story, user: newuser) } #limits: lower-20 upper-50
      let(:old_body) { limit_story.body }
      before do
        sign_in user
        visit edit_story_path(limit_story)
      end

      #subject { limit_story.body }

      describe "addition too short" do
        before do
          visit edit_story_path(limit_story)
          fill_in "Addition", with: "Too short"
          click_button "Add to Story"
        end

        it { should_not have_content("Too short") }
      end

      describe "addition too long" do
        before do
          visit edit_story_path(limit_story)
          fill_in "Addition", with: "This string is too long, which means it shouldn't be added to the story"
          click_button "Add to Story"
        end

        it { should_not have_content("This string is too long, which means it shouldn't be added to the story") }
      end

      describe "addition just right" do
        before do
          visit edit_story_path(limit_story)
          fill_in "Addition", with: "This string is the perfect length"
          click_button "Add to Story"
        end

        it { should have_content("This string is the perfect length") }
      end
    end

    describe "two people trying to edit" do
      let(:first_user)   { FactoryGirl.create(:user) }
      let(:story)        { FactoryGirl.create(:story, user: first_user) }
      before do
        sign_in first_user
        visit edit_story_path(story)
        sign_out first_user
      end

      let(:second_user) { FactoryGirl.create(:user) }
      before do
        sign_in second_user
        visit edit_story_path(story)
      end

      it { should have_link(edit_story_path(story)) }

      before do
        sign_out second_user
        sign_in first_user
        visit edit_story_path(story)
      end

      it { should have_content("Addition") }

      before do
        fill_in "Addition", with: "This string is the perfect length"
        click_button "Add to Story"
        sign_out first_user
        sign_in second_user
        visit edit_story_path(story)
      end

      it { should have_content("Addition") }
    end
  end
end
