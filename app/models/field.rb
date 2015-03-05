class Field < ActiveRecord::Base
  include Featurable
  
  set_rgeo_factory_for_column(:shape, RGeo::Geographic.spherical_factory(:srid => 4326))

  featurable :shape, [:name]
  validates_presence_of :name
  validate :is_valid_shape

  # def is_valid_shape
  #   errors.add( :shape, "Geometry is not well formed") if self.shape.as_json == "MULTIPOLYGON EMPTY"
  # end

  def is_valid_shape
  	errors.add( :shape, "- geometry is not well formed") unless self.state
  end

end
