class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  before_filter :check_public_access

  # GET /photos
  # GET /photos.json
  def index
    @album = Album.find(params[:album_id])
    @photos = @album.photos.all
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
    @album = Album.find(params[:album_id])
    puts "Album ID: " + @album.id.to_s
    @photo = Photo.new(photo_params)
    @photo.user = current_user
    
    if(params[:key]) 
      @photo.update_attribute :key, params[:key]
    else
      @photo.image_file = params[:file]
    end

    #respond_to do |format|
      if @photo.save_and_process_image_file
        puts "User being created"
        redirect_to :action => :index
        #format.html { render :text => "FILEID:" + @photo.image_file.thumb.url }
        #format.xml  { render :nothing => true }
      else
        render :text => "ERRORS:" + @photo.errors.full_messages.join(" "), :status => 500 
        #format.xml  { render :xml => @photo.errors, :status => 500 }
      end
      #if @photo.save
      #  format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
      #  format.json { render :show, status: :created, location: @photo }
      #else
      #  format.html { render :new }
      #  format.json { render json: @photo.errors, status: :unprocessable_entity }
      #end
      #end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url, notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:title, :description, :album_id, :capture_time, :longitude, :latitude)
    end
end
