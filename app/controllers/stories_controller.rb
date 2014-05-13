class StoriesController < ApplicationController
  before_action :signed_in_user
  before_action :correct_user, only: :destroy

  def new
    @story = Story.new
  end
  
  def create
    @story = current_user.stories.build(story_params)
    if @story.genre.empty?
      @story.update_attributes(genre: "None")
    end
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

    if @story.lower_limit.nil? or @story.lower_limit == 0 #lower limit not set
      if @story.upper_limit.nil? or @story.upper_limit == 0 #both limits are not set
        if @addition.length>0
          @newbody = @story[:body] + "\n\n" + current_user.username + ":\n" + @addition
          @story.update_attributes(body: @newbody)
          redirect_to @story
        else
          flash.now[:error] = 'Please add some content.'
          render 'edit'
        end
      else #upper limit set and lower limit not set
        if @addition.length > @story.upper_limit
          flash.now[:error] = 'You tried to add too much'
          render 'edit'
        else
          @newbody = @story[:body] + "\n\n" + current_user.username + ":\n" + @addition
          @story.update_attributes(body: @newbody)
          redirect_to @story
        end
      end
    else #lower limit is set
      if @addition.length < @story.lower_limit
        flash.now[:error] = "You must add " + (@story.lower_limit -  @addition.length).to_s + " more characters" 
        render 'edit'
      else
        if @story.upper_limit.nil? #upper limit not set and lower limit set
          @newbody = @story[:body] + "\n\n" + current_user.username + ":\n" + @addition
          @story.update_attributes(body: @newbody)
          redirect_to @story
        else #upper and lower limit are set
          if @addition.length > @story.upper_limit
            flash.now[:error] = "You must remove " + (@addition.length - @story.upper_limit).to_s + " characters"
            render 'edit'
          else
            @newbody = @story[:body] + "\n\n" + current_user.username + ":\n" + @addition
            @story.update_attributes(body: @newbody)
            redirect_to @story
          end
        end
      end
    end
  end
  
  def show
    @story = Story.find(params[:id])
  end
  
  def destroy
    @story.destroy
    redirect_to user_path(current_user)
  end
  
  private 
  
  def story_params
    params.require(:story).permit(:title, :genre, :body, :addition, :lower_limit, :upper_limit)
  end
  
  def correct_user
    @story = current_user.stories.find_by(id: params[:id])
    redirect_to root_url if @story.nil?
  end
end
