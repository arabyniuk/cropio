class FieldsController < ApplicationController
  def index
    @fields = Field.all
    
    respond_to do |format|
      format.json do
        feature_collection = Field.to_feature_collection @fields
        render json: RGeo::GeoJSON.encode(feature_collection)
      end
      format.html
    end
  end

  def show
    @field = Field.find(params[:id])
    respond_to do |format|
      format.json do 
        feature = @field.to_feature
        render json: RGeo::GeoJSON.encode(feature)
      end  
      format.html 
    end
  end

  def new
    @field = Field.new
  end

  def create
    params[:field] = JSON.parse params[:field] if params[:page].is_a? String
    shape = RGeo::GeoJSON.decode(params[:field], json_parser: :json)
    @field = Field.new(name: params[:name], shape: shape.geometry.as_text)
    respond_to do |format|
      if @field.save
        format.json { head :ok }
      end
    end

  end

  def edit
    @field = Field.find(params[:id])
  end

  def update
    params[:field] = JSON.parse params[:field] if params[:page].is_a? String
    shape = RGeo::GeoJSON.decode(params[:field], json_parser: :json)
    @field = Field.find(params[:id])
    respond_to do |format|
      if @field.update(shape: shape.geometry.as_text)
        format.json { head :ok }
      end
    end
  end 

  def destroy
    @field = Field.find(params[:id])
    respond_to do |format|
      if @field.destroy
        format.html { redirect_to root_url } 
        format.js { render layout: false }
      end
    end
  end

end
