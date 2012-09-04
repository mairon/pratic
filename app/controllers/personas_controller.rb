class PersonasController < ApplicationController
  before_filter :authenticate

  def persona_compra             #
  end


  def busca_persona_compra       #

      @personas = Persona.paginate(:select => 'id,nome,classificacao,telefone,ruc,tipo,estado',
                                  :conditions => ['nome LIKE ?', "%#{params[:busca]}%"],
                                  :page     => params[:page],
                                  :per_page => 100,
                                  :order => "nome"
                               )

  render :layout => false
  end

  def persona_venda              #
  end

  def busca_persona_venda        #

      @personas = Persona.paginate(:select => 'id,nome,classificacao,telefone,ruc,tipo,estado',
                                  :conditions => ['nome LIKE ?', "%#{params[:busca]}%"],
                                  :page     => params[:page],
                                  :per_page => 100,
                                  :order => "nome"
                                 )

      render :layout => false

  end

  def persona_nota_credito           #
      render :layout => 'consulta'
  end

  def busca_persona_nota_credito       #

      @personas = Persona.paginate(:select => 'id,nome,classificacao,telefone,ruc,tipo,estado,cidade,cidade_id,direcao',
                                  :conditions => ['nome LIKE ?', "%#{params[:busca]}%"],
                                  :page     => params[:page],
                                  :per_page => 100,
                                  :order => "nome"
                                 )

      render :layout => false

  end

  def persona_venda_financa           #
      render :layout => 'consulta'
  end

  def busca_persona_venda_financa       #

      @personas = Persona.paginate(:select => 'id,nome,classificacao,bairro,ruc,tipo,estado,cidade,cidade_id,direcao',
                                  :conditions => ['nome LIKE ?', "%#{params[:busca]}%"],
                                  :page     => params[:page],
                                  :per_page => 100,
                                  :order => "nome"
                                 )

      render :layout => false

  end


  def persona_ordem              #
  end

  def busca_persona_ordem        #

      @personas = Persona.paginate(:select => 'id,nome,classificacao,telefone,ruc,tipo,estado',
                                 :conditions => ['nome LIKE ?', "%#{params[:busca]}%"],
                                 :page     => params[:page],
                                 :per_page => 100,
                                 :order => "nome"
                               )

      render :layout => false

  end

  def persona_cobro              #
  end

  def busca_persona_cobro        #

      @personas = Persona.paginate(:select => 'id,nome,classificacao,telefone,ruc,tipo,estado',
                                  :conditions => ['nome LIKE ?', "%#{params[:busca]}%"],
                                  :page     => params[:page],
                                  :per_page => 100,
                                  :order => "nome"
                                 )

      render :layout => false

  end

  def persona_pago               #
  end

  def busca_persona_pago         #

      @personas = Persona.paginate(:select => 'id,nome,classificacao,telefone,ruc,tipo,estado',
                                  :conditions => ['nome LIKE ?', "%#{params[:busca]}%"],
                                  :page     => params[:page],
                                  :per_page => 100,
                                  :order => "nome"
                                 )

      render :layout => false

  end

  def busca                      #

      @personas = Persona.paginate(:select => 'id,nome,classificacao,ruc,tipo,estado',
                                  :conditions => ['nome LIKE ?', "%#{params[:busca]}%"],
                                  :page     => params[:page],
                                  :per_page => 100,
                                  :order => "nome"
                                 )
   respond_to do |format|
      format.html {render :layout => false}
      format.js { render :layout => false }
    end

      

  end

#METHOD BASE--------------------------------------------------------------------

  def index         #

  end

  def show          #

      @persona = Persona.find(params[:id])

  end

  def new           #
    @persona = Persona.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @persona }
    end
  end

  def edit          #
    @persona = Persona.find(params[:id])
  end

  def create        #
    @persona = Persona.new(params[:persona])



    respond_to do |format|
      if @persona.save
        flash[:notice] = 'Grabado con Sucesso !'
        format.html { redirect_to(personas_url) }
        format.xml  { render :xml => @persona, :status => :created, :location => @persona }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @persona.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update        #
    @persona = Persona.find(params[:id])
    @persona.usuario_updated = current_user.usuario_nome
    @persona.unidade_updated = current_unidade.unidade_nome

    respond_to do |format|
      if @persona.update_attributes(params[:persona])
        flash[:notice] = 'Actualizado con Sucesso'
        format.html { redirect_to(personas_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @persona.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy       #
    @persona = Persona.find(params[:id])
    @persona.destroy

    respond_to do |format|
      format.html { redirect_to(personas_url) }
      format.xml  { head :ok }
    end
  end
end
