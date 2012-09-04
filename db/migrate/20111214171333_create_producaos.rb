class CreateProducaos < ActiveRecord::Migration
  def self.up
    create_table :producaos do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :producaos
  end
end
