class CreateTransferenciaDepositoProdutos < ActiveRecord::Migration
  def self.up
    create_table :transferencia_deposito_produtos do |t|
      t.date :data
      t.integer :transferencia_deposito_id
      t.integer :produto_id
      t.string :produto_nome
      t.decimal :quantidade, :decimal,:scale => 2,:precision => 15
      t.decimal :unitario_dolar, :decimal,:scale => 2,:precision => 15
      t.decimal :unitario_guarani, :decimal,:scale => 2,:precision => 15
      t.integer :deposito_origem_id
      t.string :deposito_origem_nome
      t.integer :deposito_destino_id
      t.string :deposito_destino_nome

      t.timestamps
    end
  end

  def self.down
    drop_table :transferencia_deposito_produtos
  end
end
