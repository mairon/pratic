class PagosFinanca < ActiveRecord::Base
  
  belongs_to :pago

  def before_save
      @conta = Conta.find_by_id(self.conta_id);
      self.conta_nome = @conta.nome.to_s unless self.conta_id.blank?

      @documento = Documento.find_by_id(self.documento_id);
      self.documento_nome = @documento.nome.to_s unless self.documento_id.blank?

        if pago.moeda == 0
           self.valor_guarani     = self.valor_dolar.to_f * pago.cotacao.to_f
        else
           self.valor_dolar       = self.valor_guarani.to_f / pago.cotacao.to_f
        end


  end

end
