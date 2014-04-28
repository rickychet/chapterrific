class StoriesController < ApplicationController
  before_action :signed_in_user

  def new
    @story = Story.new
  end
  
  def create
    @story = current_user.stories.build(story_params)
    @story.save
    redirect_to user_path(current_user)
  end
  
  def show
    @story = Story.find(params[:id])
  end
  
  private 
  
  def story_params
    params.require(:story).permit(:title, :body)
  end
end
