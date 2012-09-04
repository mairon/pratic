class ManifestacaoDeBen < ActiveRecord::Base

  def before_save        #
     @persona = Persona.find_by_id(self.persona_id);
      self.persona_nome = @persona.nome.to_s;
  end
  #USUARIO
  def before_create      #
    self.usuario_created = $log_usuario_id
  end

  def before_update      #
    self.usuario_updated = $log_usuario_id
  end



end
