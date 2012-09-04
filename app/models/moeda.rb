class Moeda < ActiveRecord::Base

  #USUARIO
    def before_create
    self.usuario_created = $log_usuario_id
  end
  def before_update
    self.usuario_updated = $log_usuario_id
  end

end
