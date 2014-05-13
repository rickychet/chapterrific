class StoriesController < ApplicationController
  before_action :signed_in_user

  def new
    @story = Story.new
  end
  
  def create
    @story = current_user.stories.build(story_params)
    unless @story.upper_limit.nil? or @story.lower_limit.nil?
      if @story.upper_limit < @story.lower_limit
        flash.now[:error] = 'Upper limit must be greater than the lower limit'
        render 'new'
        return
      end
    end
    if @story.save
        redirect_to user_path(current_user)
    else
        flash.now[:error] = "Something went wrong. Make sure to enter a title,
        put some content in the body, and make sure that limit values are integers."
        render 'new'
    end
  end
  
  def edit
    @story = Story.find(params[:id])
  end
  
  def update
    @story = Story.find(params[:id]) 
    @addition = story_params[:addition]

    if @story.lower_limit.nil? or @story.lower_limit == 0
      if @story.upper_limit.nil? or @story.upper_limit == 0
        if @addition.length>0
          @newbody = @story[:body] + "\n\n" + current_user.username + ":\n" + @addition
          @story.update_attributes(body: @newbody)
          redirect_to @story
        else
          flash.now[:error] = 'Please add some content.'
          render 'edit'
        end
      else #upper limit set
        if @addition.length > @story.upper_limit
          flash.now[:error] = 'You tried to add too much'
          render 'edit'
        else
          @newbody = @story[:body] + "\n\n" + current_user.username + ":\n" + @addition
          @story.update_attributes(body: @newbody)
          redirect_to @story
        end
      end
    else
      if @addition.length < @story.lower_limit
        flash.now[:error] = "You must add " + (@story.lower_limit -  @addition.length).to_s + " more characters" 
        render 'edit'
      elsif @addition.length >@story.upper_limit
        flash.now[:error] = "You must remove " + (@addition.length - @story.upper_limit).to_s + " characters"
        render 'edit'
      else
         if @addition.length < @story.lower_limit
            flash.now[:error] = 'You did not add enough' 
            render 'edit'
         elsif @addition.length >@story.upper_limit
            flash.now[:error] = 'You tried to add too much'
            render 'edit'
         else
            @newbody = @story[:body] + "\n\n" + current_user.username + ":\n" + @addition
            @story.update_attributes(body: @newbody)
            redirect_to @story
         end
      end
    end
  end
  
  def show
    @story = Story.find(params[:id])
  end
  
  private 
  
  def story_params
    params.require(:story).permit(:title, :genre, :body, :addition, :lower_limit, :upper_limit)
  end
end
