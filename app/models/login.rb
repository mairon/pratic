class Login < ActiveRecord::Base
belongs_to :unidade
belongs_to :usuario
belongs_to :conta
belongs_to :turno

    def validate

     if self.unidade_nome = nil
        errors.add_to_base("Informe o nome da Unidade")
     end
     if self.usuario_nome = nil
       errors.add_to_base("Informe o nome do usuario")
     end
     if self.usuario_senha.to_s != usuario.usuario_senha.to_s
          errors.add_to_base("Senha incorreta")
     end

  end


   def before_save

     self.unidade_nome = unidade.unidade_nome.to_s
     self.usuario_nome = usuario.usuario_nome.to_s     
     self.conta_nome   = conta.nome.to_s
     self.turno_nome   = turno.nome.to_s

     $log_unidade_nome = self.unidade_nome
     $log_unidade_id   = self.unidade_id
     $log_usuario_nome = self.usuario_nome
     $log_usuario_id   = self.usuario_id     
     $log_conta_nome   = self.conta_nome
     $log_conta_id     = self.conta_id
     $log_turno_nome   = self.turno_nome
     $log_turno_id     = self.turno_id



   end

end

