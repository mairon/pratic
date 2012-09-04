class CobrosFinanca < ActiveRecord::Base
    belongs_to :cobro

  def before_save
      @conta = Conta.find_by_id(self.conta_id);
      self.conta_nome = @conta.nome.to_s unless self.conta_id.blank?

      @documento = Documento.find_by_id(self.documento_id);
      self.documento_nome = @documento.nome.to_s unless self.documento_id.blank?
  end


end
