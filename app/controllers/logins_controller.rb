class LoginsController < ApplicationController

    def get_unidade                     #
        @unidade =  Unidade.find(:first, :select => 'id',:conditions =>  [ "id = ?", params[:campo_unidade]])
        return render :text =>
        "<script type='text/javascript'>
         document.getElementById('busca_01_unidade_id').value    = '#{@unidade.id.to_i}';
       </script>"
    end

    def get_conta                       #
        @conta =  Conta.find(:first, :select => 'id',:conditions =>  [ "id = ?", params[:campo_conta]])
        return render :text =>
        "<script type='text/javascript'>
         document.getElementById('busca_02_conta_id').value    = '#{@conta.id.to_i}';
       </script>"
    end

    def get_turno                       #
        @turno =  Turno.find(:first, :select => 'id',:conditions =>  [ "id = ?", params[:campo_turno]])
        return render :text =>
        "<script type='text/javascript'>
         document.getElementById('busca_03_turno_id').value    = '#{@turno.id.to_i}';
       </script>"
    end

    def get_usuario                     #
        @usuario =  Usuario.find(:first,:select => 'id', :conditions =>  [ "id = ?", params[:campo_usuario]])
        return render :text =>
        "<script type='text/javascript'>
         document.getElementById('busca_04_usuario_id').value    = '#{@usuario.id.to_i}';
       </script>"
    end

    def new                             #
        @login = Login.new

    end

    def create                          #
        if session[:logged] and session[:unidade]
            redirect_to menus_path
        else
              
            @unidade = Unidade.find(:first,:select =>'id',:conditions   => ['id = ?',params[:busca_01]["unidade_id"]])
            @conta   = Conta.find(:first,  :select =>'id',:conditions   => ['id = ?',params[:busca_02]["conta_id"]])
            @turno   = Turno.find(:first,  :select =>'id',:conditions   => ['id = ?',params[:busca_03]["turno_id"]])
            @login   = Usuario.find(:first,:select =>'id,usuario_senha',:conditions => ['id = ? and usuario_senha = ?',params[:busca_04]["usuario_id"],params[:usuario_senha]])

            if @unidade and @conta and @turno and @login

                session[:unidade]   = params[:busca_01]["unidade_id"]
                session[:conta]     = params[:busca_02]["conta_id"]
                session[:turno]     = params[:busca_03]["turno_id"]
                session[:logged]    = params[:busca_04]["usuario_id"]
                flash[:notice]      = 'Logado con Sucesso!'
                redirect_to menus_path
            else
                flash[:notice] = 'Compruebe la contraseña!'
                render :action => "new"
            end
        end
    end

    def destroy                         #
        session[:logged] = false
        redirect_to new_login_path
        flash[:notice] = 'Ingresse la Contra-Senha!'
    end

end



