class TransferenciaDepositoProduto < ActiveRecord::Base
  belongs_to :transferencia_deposito

  validates_presence_of :quantidade

  def validate      #
    saldo = Stock.sum('entrada - saida',:conditions => ["produto_id = ? AND data <=	 ? AND deposito_id = ?",self.produto_id,self.data,self.deposito_origem_id])
    if ( saldo.to_f <= 0   )
      errors.add_to_base( "No tiene saldo Disponible" )
    end
  end

  def before_save
   custo_produto = Stock.last(:conditions => ["produto_id = ? AND data < ?  AND STATUS = 0",self.produto_id,self.data])
    if custo_produto != nil
    @produto = Produto.find_by_id(self.produto_id);
    self.produto_nome = @produto.nome.to_s;
    self.unitario_dolar     = custo_produto.unitario_dolar.to_f;
    self.unitario_guarani     = custo_produto.unitario_guarani.to_f;
   end 
 end
  
end
