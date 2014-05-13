require 'spec_helper'

describe "Static Pages" do

  subject { page }

  describe "Home page" do
    describe "for non-signed-in users" do
      before { visit root_path }
      it { should have_title('Home') }
      it { should have_content('Welcome to Chapterrific') }
      it {should have_link('Sign up now!', signup_path)}
    end

    describe "for signed-in users" do
    let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:story, user: user)
        sign_in user
        visit root_path
      end
  
      it { should have_title('Home') }
      it { should have_content('Welcome to Chapterrific') }
      it { should_not have_link('Sign up now!', signup_path) } 
    end
  end
end