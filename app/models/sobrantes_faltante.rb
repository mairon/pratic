class SobrantesFaltante < ActiveRecord::Base

  validates_presence_of :cotacao,
                        :quantidade

  def before_save
    @produto = Produto.find_by_id(self.produto_id);
    self.produto_nome = @produto.nome.to_s;
    self.codigo = @produto.codigo.to_s;

    @deposito = Deposito.find_by_id(self.deposito_id);
    self.deposito_nome = @deposito.nome.to_s;
  end



end
