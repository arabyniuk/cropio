class AddStateToFields < ActiveRecord::Migration
  def change
    add_column :fields, :state, :boolean
  end
end
