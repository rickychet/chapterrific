require 'spec_helper'

describe Story do
  
  let(:user) { FactoryGirl.create(:user) }
  before { @story = user.stories.build(title: "Story Title", body: "This is a story.") }
    
    subject { @story }
  
  it { should respond_to(:title) }
  it { should respond_to(:body) }
  it { should respond_to(:genre) }
  it { should respond_to(:upper_limit) }
  it { should respond_to(:lower_limit) }
  its(:user) { should eq user }
  
  it { should be_valid }
  
  describe "when user_id is not present" do
    before { @story.user_id = nil }
    it { should_not be_valid }
  end
  
  describe "with blank title" do
      before { @story.title = "" }
      it { should_not be_valid }
    end
  
  describe "with blank body" do
      before { @story.body = "" }
      it { should_not be_valid }
    end
end
