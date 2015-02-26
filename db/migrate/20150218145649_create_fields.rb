class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|
      t.string :name
      t.multi_polygon :shape, geographic: true, srid: 4326

      t.timestamps
    end
  end
end
