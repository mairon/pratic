class Diario < ActiveRecord::Base
  has_many :diario_debes
  has_many :diario_habers

  def before_save
    @doc = Documento.find_by_id(self.documento_id)
    self.documento_nome = @doc.nome.to_s unless self.documento_id.blank?
  end


end
