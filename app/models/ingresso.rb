class Ingresso < ActiveRecord::Base

  validates_presence_of :cotacao,
                        :valor_dolar,
                        :valor_guarani

  def before_save
    @doc = Documento.find_by_id(self.documento_id);
    self.documento_nome = @doc.nome.to_s;
    
    @conta = Conta.find_by_id(self.conta_id);
    self.conta_nome = @conta.nome.to_s;

    @rubro = Rubro.find_by_id(self.rubro_id);
    self.rubro_nome   = @rubro.descricao.to_s;
    self.rubro_codigo = @rubro.codigo.to_s;

  end


end
