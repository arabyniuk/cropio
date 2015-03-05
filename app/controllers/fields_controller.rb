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
    state = get_state(params[:field][:shape])
    shape = RGeo::GeoJSON.decode(params[:field][:shape], json_parser: :json)

    @field = Field.new(name: params[:field][:name], shape: shape.geometry.as_text, state: state)
    if @field.save
      redirect_to @field, notice: 'Field was successfully created.'
    else
      flash[:error] = @field.errors.full_messages.map { |m| "<span>"+ m + "</span>" }.join("<br>")
      render :new
    end

  end

  def edit
    @field = Field.find(params[:id])
  end

  def update
    state = get_state(params[:field][:shape])
    shape = RGeo::GeoJSON.decode(params[:field][:shape], json_parser: :json)

    @field = Field.find(params[:id])
    if @field.update(name: params[:field][:name], shape: shape.geometry.as_text, state: state)
      redirect_to @field, notice: 'Field was successfully updated.'
    else
      flash[:error] = @field.errors.full_messages.map { |m| "<span>"+ m + "</span>" }.join("<br>")
      render :edit
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

  private

  def get_state(shape)
    state = (ActiveRecord::Base.connection.execute "SELECT ST_IsValid(ST_GeomFromText(ST_AsText(ST_GeomFromGeoJSON('#{((JSON.parse shape)["geometry"]).to_json}'))))").getvalue(0, 0)
    if state == "t" then state = true else state = false end
    state
  end
end
