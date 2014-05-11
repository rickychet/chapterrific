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
  
  def edit
    @story = Story.find(params[:id])
  end
  
  def update
    @story = Story.find(params[:id]) 
    @addition = story_params[:addition]
    if @addition.length>0
      @newbody = @story[:body] + "\n\n" + current_user.username + ":\n" + @addition
      @story.update_attributes(body: @newbody)
      redirect_to @story
    else
      flash.now[:error] = 'Please add some content.'
      render 'edit'
    end
    
  end
  
  def show
    @story = Story.find(params[:id])
  end
  
  private 
  
  def story_params
    params.require(:story).permit(:title, :body, :addition)
  end
end
