class Field < ActiveRecord::Base
  include Featurable

  featurable :shape, [:name]
  set_rgeo_factory_for_column(:shape, RGeo::Geographic.spherical_factory(:srid => 4326))
end
