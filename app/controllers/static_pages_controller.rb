class StaticPagesController < ApplicationController
  def home
    @stories = Story.paginate(page: params[:page])
  end

  def help
  end
end
