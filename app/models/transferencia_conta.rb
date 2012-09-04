class TransferenciaConta < ActiveRecord::Base

  validates_presence_of :cotacao,
                        :valor_dolar,
                        :valor_guarani

  def before_save
    @doc = Documento.find_by_id(self.documento_id);
    self.documento_nome = @doc.nome.to_s;

    @ingreso = Conta.find_by_id(self.ingreso_id);
    self.ingreso_nome = @ingreso.nome.to_s;

    @destino = Conta.find_by_id(self.destino_id);
    self.destino_nome = @destino.nome.to_s;
  end



end
