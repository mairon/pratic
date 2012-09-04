class CreateProducaoProdutos < ActiveRecord::Migration
  def self.up
    create_table :producao_produtos do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :producao_produtos
  end
end
