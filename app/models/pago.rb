class Pago < ActiveRecord::Base
  has_many :pagos_detalhes,   :order => 1
  has_many :pagos_financas,   :order => 1
  belongs_to :persona

  validates_presence_of :cotacao,
                        :persona_nome


  def before_update       #
      @conta = Conta.find_by_id(self.conta_id);
      self.conta_nome = @conta.nome.to_s unless self.conta_id.blank?

      @documento = Documento.find_by_id(self.documento_id);
      self.documento_nome = @documento.nome.to_s unless self.documento_id.blank?
  end


end
