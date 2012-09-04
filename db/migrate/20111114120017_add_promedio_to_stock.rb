class AddPromedioToStock < ActiveRecord::Migration
  def self.up
    add_column :stocks, :promedio_dolar, :decimal,:scale => 2,:precision => 15
    add_column :stocks, :promedio_guarani, :decimal,:scale => 2,:precision => 15
  end

  def self.down
    remove_column :stocks, :promedio_guarani
    remove_column :stocks, :promedio_dolar
  end
end
