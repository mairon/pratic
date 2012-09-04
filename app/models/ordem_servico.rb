class OrdemServico < ActiveRecord::Base

 belongs_to :persona
 has_many :ordem_servicos_produtos, :order => 1
 has_many :ordem_servicos_executados, :order => 1

  def persona_busca       #
    persona.nome if persona_nome
  end

  def persona_busca=(nome)#
    self.persona_nome = Persona.find_or_create_by_nome(nome) unless nome.blank?
  end
  #USUARIO
  def before_create       #
    self.usuario_created = $log_usuario_id
  end

  def before_update       #
    self.usuario_updated = $log_usuario_id
  end

end
