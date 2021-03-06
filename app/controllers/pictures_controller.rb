class PicturesController < ApplicationController
  before_action :set_picture, only: %i[ show edit update destroy ]
  skip_before_action :login_required, only: [:new, :create, :show, :edit, :confirm, :destroy]

  def index
    @pictures = Picture.all
  end
  def show
    @picture = Picture.find(params[:id])
    @comment = Comment.new
    @comments = @picture.comments
  end
  def new
    if params[:back]
    @picture = Picture.new(picture_params)
  else
    @picture = Picture.new
  end
 end
 def confirm
  @picture = current_user.pictures.build(picture_params)
  render :new if @picture.invalid?
 end
 def edit
   @picture = Picture.find(params[:id])
 end
  def create
    @picture = current_user.pictures.build(picture_params)
    @picture.user_id = current_user.id
    respond_to do |format|
      if @picture.save
        format.html { redirect_to @picture, notice: "Picture was successfully created." }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end
  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to @picture, notice: "Picture was successfully updated." }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end
  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url, notice: "Picture was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  private
  def set_picture
    @picture = Picture.find(params[:id])
  end
  def picture_params
    params.require(:picture).permit(:image, :image_cache, :post)
  end
  end
