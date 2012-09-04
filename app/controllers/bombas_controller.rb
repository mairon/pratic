class BombasController < ApplicationController
  def index
    @bombas = Bomba.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bombas }
    end
  end

  def show
    @bomba = Bomba.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bomba }
    end
  end

  def new
    @bomba = Bomba.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bomba }
    end
  end

  def edit
    @bomba = Bomba.find(params[:id])
  end

  def create
    @bomba = Bomba.new(params[:bomba])
    @bomba.usuario_created = current_user.id
    @bomba.unidade_created = current_unidade.id

    respond_to do |format|
      if @bomba.save
      flash[:notice] = 'Grabado con Sucesso.'
      format.html { redirect_to(bombas_url) }
        format.xml  { render :xml => @bomba, :status => :created, :location => @bomba }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bomba.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @bomba = Bomba.find(params[:id])
    @bomba.usuario_updated = current_user.id
    @bomba.unidade_updated = current_unidade.id


    respond_to do |format|
      if @bomba.update_attributes(params[:bomba])
      flash[:notice] = 'Actualizado con Sucesso.'
      format.html { redirect_to(bombas_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bomba.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @bomba = Bomba.find(params[:id])
    @bomba.destroy

    respond_to do |format|
      format.html { redirect_to(bombas_url) }
      format.xml  { head :ok }
    end
  end
end
