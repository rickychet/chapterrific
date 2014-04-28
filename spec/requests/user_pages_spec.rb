require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }

    it { should have_content(user.username) }
    it { should have_content(user.email) }
    it { should have_content(user.bio) }
    it { should have_link("Create New Story", href: new_story_path) }
    
    describe "stories" do
      describe "when no stories have been created" do
        it { should have_content("No Stories Yet") }
      end
      
      describe "when a story has been created" do
      let!(:story) { FactoryGirl.create(:story, user: user) }
      before { visit user_path(user)}
      
      it { should have_content("1 Story") }
      it { should have_link(story.title, href: story_path(story)) }
      it { should have_content(story.body[0..49] + "...") }
    end
    end
   # it { should have_title(user.name) }
  end
  
  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Register') }
  #  it { should have_title('Register') }
  end
  
  describe "signup" do

      before { visit signup_path }

      let(:submit) { "Create my account" }

      describe "with invalid information" do
        it "should not create a user" do
          expect { click_button submit }.not_to change(User, :count)
        end
      end

      describe "with valid information" do
        before do
          fill_in "Username",     with: "Example User"
          fill_in "Email",        with: "user@example.com"
          fill_in "Password",     with: "foobar"
          fill_in "Confirmation", with: "foobar"
        end

        it "should create a user" do
          expect { click_button submit }.to change(User, :count).by(1)
        end
      end
    end
end