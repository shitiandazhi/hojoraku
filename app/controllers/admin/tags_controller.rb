class Admin::TagsController < ApplicationController

   def index
    @tags = Tag.all
    @tag = Tag.new

   end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
       @tags = Tag.all
       render :index
    else
      @tags = Tag.all
       redirect_back(fallback_location: root_path)
    end
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      redirect_to admin_tags_path
    else
      redirect_back(fallback_location: root_path)
    end

  end

  private
  def tag_params
    params.require(:tag).permit(:name)
  end

end