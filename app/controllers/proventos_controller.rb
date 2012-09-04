class ProventosController < ApplicationController
  before_filter :authenticate

  def index
    @proventos = Provento.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @proventos }
    end
  end

  def show
    @provento = Provento.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @provento }
    end
  end

  def new
    @provento = Provento.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @provento }
    end
  end

  def edit
    @provento = Provento.find(params[:id])
  end

  def create
    @provento = Provento.new(params[:provento])
    @provento.usuario_created = current_user.usuario_nome
    @provento.unidade_created = current_unidade.unidade_nome

    respond_to do |format|
      if @provento.save
        format.html { redirect_to(proventos_url, :notice => 'Grabado con Sucesso') }
        format.xml  { render :xml => @provento, :status => :created, :location => @provento }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @provento.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @provento = Provento.find(params[:id])
    @provento.usuario_updated = current_user.usuario_nome
    @provento.unidade_updated = current_unidade.unidade_nome

    respond_to do |format|
      if @provento.update_attributes(params[:provento])
        format.html { redirect_to(proventos_url, :notice => 'Actualizado con Sucesso') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @provento.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @provento = Provento.find(params[:id])
    @provento.destroy

    respond_to do |format|
      format.html { redirect_to(proventos_url) }
      format.xml  { head :ok }
    end
  end
end
