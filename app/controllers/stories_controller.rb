class StoriesController < ApplicationController
  before_action :signed_in_user

  def new
    @story = Story.new
  end
  
  def create
    @story = current_user.stories.build(story_params)
    unless @story.upper_limit.nil? && @story.lower_limit.nil?
      if @story.upper_limit < @story.lower_limit
        flash.now[:error] = 'Upper limit must be greater than the lower limit'
        render 'new'
      else
        @story.save
        redirect_to user_path(current_user)
      end
    end
  end
  
  def edit
    @story = Story.find(params[:id])
  end
  
  def update
    @story = Story.find(params[:id]) 
    @addition = story_params[:addition]
    if @story.lower_limit.nil? && @story.upper_limit.nil?
      if @addition.length>0
        @newbody = @story[:body] + "\n\n" + current_user.username + ":\n" + @addition
        @story.update_attributes(body: @newbody)
        redirect_to @story
      else
        flash.now[:error] = 'Please add some content.'
        render 'edit'
      end
    else
      if @addition.length < @story.lower_limit
        flash.now[:error] = "You must add " + (@story.lower_limit -  @addition.length) + " more characters" 
        render 'edit'
      elsif @addition.length >@story.upper_limit
        flash.now[:error] = "You must remove " + (@story.upper_limit -  @addition.length) + " characters"
        render 'edit'
      else
        @newbody = @story[:body] + "\n\n" + current_user.username + ":\n" + @addition
        @story.update_attributes(body: @newbody)
        redirect_to @story
      end
    end
  end
  
  def show
    @story = Story.find(params[:id])
  end
  
  private 
  
  def story_params
    params.require(:story).permit(:title, :body, :addition, :lower_limit, :upper_limit)
  end
end
