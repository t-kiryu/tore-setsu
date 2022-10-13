class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @tag = Tag.new
    @tags = Tag.all
  end

  def create
    @tag = Tag.new(tag_params)
    @tag.save
    redirect_to admin_tags_path
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    @tag.update(tag_params)
    # 以下render用
    @tag = Tag.new
    @tags = Tag.all
    render :index
  end

  def destroy
    @tag = Tag.find(params[:id]).destroy
    @tag = Tag.new
    @tags = Tag.all
    render :index
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end

end
