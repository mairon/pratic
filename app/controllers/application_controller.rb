# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

#CONTROLE DE VERSION
  $version = '1.2.0.'

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  helper_method :current_user
  helper_method :current_unidade
  helper_method :current_conta
  helper_method :current_turno  
  
  def current_user          #
    @current_user ||= Usuario.find(session[:logged],:select => 'id,usuario_nome,tipo,vendedor_id')
  end

  def current_unidade       #
    @current_unidade ||= Unidade.find(session[:unidade],:select => 'id,unidade_nome')
  end

  def current_conta         #
    @current_conta ||= Conta.find(session[:conta],:select => 'id,nome')
  end

  def current_turno         #
    @current_turno ||= Turno.find(session[:turno],:select => 'id,nome')
  end
  private
  def authenticate          #
    if session[:logged]
      true

    else
      redirect_to new_login_path
    end

  end

  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
end
