class DiarioDebe < ActiveRecord::Base
belongs_to :diario

  validates_presence_of :valor_guarani,
                        :valor_dolar


  def before_save

    @rubro = Rubro.find_by_id(self.rubro_id)
    self.descricao = @rubro.descricao.to_s unless self.rubro_id.blank?

    @persona = Persona.find_by_id(self.persona_id);
    self.persona_nome = @persona.nome.to_s unless self.persona_id.blank?

    @produto = Produto.find_by_id(self.produto_id);
    self.produto_nome = @produto.nome.to_s unless self.produto_id.blank?

    @unidade = Unidade.find_by_id(self.unidade_id);
    self.unidade_nome = @produto.unidade_nome.to_s unless self.unidade_id.blank?

  end

end
