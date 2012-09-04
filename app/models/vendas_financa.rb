class VendasFinanca < ActiveRecord::Base
  belongs_to :venda
  belongs_to :persona


  
  def before_save         #
        
      @trans = Persona.find_by_id(self.transportadora_id);
      self.transportadora_nome   = @trans.nome.to_s if $empresa == 'E01'
    
      @cidade = Cidade.find_by_id(self.cidade_id);
      self.cidade_nome   = @cidade.nome.to_s unless self.cidade_id.blank?

      @conta = Conta.find_by_id(self.conta_id);
      self.conta_nome   = @conta.nome.to_s if $empresa == 'E01';

      @produtos = VendasProduto.all(:conditions => ['venda_id = ?',self.venda_id])
      @produtos.each do |produto|
        produto.update_attribute :tipo,  self.tipo
        produto.update_attribute :moeda, self.moeda
        produto.update_attribute :numero_ordem, self.numero_ordem
        produto.update_attribute :tipo_ordem, self.tipo_ordem
    end
           
    if self.fatura == 0
      self.documento_nome   = 'COMPROBANTE VENTA'
      self.documento_id     = 10
      self.documento_numero = self.venda_id
    else
      self.documento_nome   = 'FACTURA VENTA'
      self.documento_id     =  9
      
    end
  end


end
