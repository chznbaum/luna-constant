class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  access all: [], user: { except: [:edit, :update, :destroy] }, helper: :all, site_admin: :all

  # GET /photos
  # GET /photos.json
  def index
    if current_user.has_role?(:site_admin, :helper)
      @photos = Photo.by_recent.page(params[:page]).per(6)
    else
      @photos = Photo.where(:status => "Approved").by_recent.page(params[:page]).per(6)
    end
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    @user = current_user
    @photo = Photo.new(photo_params)
    @photo.set_user!(current_user)

    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url, notice: 'Photo was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:photo_upload, :caption, :user_id, :status, :created_at)
    end
end
