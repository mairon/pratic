class RelogioPonto < ActiveRecord::Base

    validates_presence_of :turno_id,:usuario_id,:usuario_senha
    
    def validate
        login =  Usuario.find(:first,:select =>'id,usuario_nome,usuario_senha',:conditions => ['id = ? and usuario_senha = ?',self.usuario_id,self.usuario_senha])

        errors.add_to_base("La Contra-Senha esta incorreta!") if login.nil?
    end

    def before_save
        @turno = Turno.find_by_id(self.turno_id);
        self.turno_nome = @turno.nome.to_s;

        @usuario = Usuario.find_by_id(self.usuario_id);
        self.usuario_nome = @usuario.usuario_nome.to_s;


        status = RelogioPonto.find(:first,:conditions => ["data = ? AND  turno_id = ? AND usuario_id =  ? AND status = 0",self.data,self.turno_id,self.usuario_id])

        if status.nil?
            self.status = 0
        else
            self.status = 1
        end
    end


end
