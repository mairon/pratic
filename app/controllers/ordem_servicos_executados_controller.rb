class OrdemServicosExecutadosController < ApplicationController
  # GET /ordem_servicos_executados
  # GET /ordem_servicos_executados.xml
  def index
    @ordem_servicos_executados = OrdemServicosExecutado.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ordem_servicos_executados }
    end
  end

  # GET /ordem_servicos_executados/1
  # GET /ordem_servicos_executados/1.xml
  def show
    @ordem_servicos_executado = OrdemServicosExecutado.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ordem_servicos_executado }
    end
  end

  # GET /ordem_servicos_executados/new
  # GET /ordem_servicos_executados/new.xml
  def new
    @ordem_servicos_executado = OrdemServicosExecutado.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ordem_servicos_executado }
    end
  end

  # GET /ordem_servicos_executados/1/edit
  def edit
    @ordem_servicos_executado = OrdemServicosExecutado.find(params[:id])
  end

  # POST /ordem_servicos_executados
  # POST /ordem_servicos_executados.xml
  def create
    @ordem_servicos_executado = OrdemServicosExecutado.new(params[:ordem_servicos_executado])

    respond_to do |format|
      if @ordem_servicos_executado.save
        flash[:notice] = 'OrdemServicosExecutado was successfully created.'
        format.html { redirect_to "/ordem_servicos/servico_executado/#{@ordem_servicos_executado.ordem_servico_id}" }
        format.xml  { render :xml => @ordem_servicos_executado, :status => :created, :location => @ordem_servicos_executado }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ordem_servicos_executado.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ordem_servicos_executados/1
  # PUT /ordem_servicos_executados/1.xml
  def update
    @ordem_servicos_executado = OrdemServicosExecutado.find(params[:id])

    respond_to do |format|
      if @ordem_servicos_executado.update_attributes(params[:ordem_servicos_executado])
        flash[:notice] = 'OrdemServicosExecutado was successfully updated.'
        format.html { redirect_to "/ordem_servicos/servico_executado/#{@ordem_servicos_executado.ordem_servico_id}" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ordem_servicos_executado.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ordem_servicos_executados/1
  # DELETE /ordem_servicos_executados/1.xml
  def destroy
    @ordem_servicos_executado = OrdemServicosExecutado.find(params[:id])
    @ordem_servicos_executado.destroy

    respond_to do |format|
      format.html { redirect_to "/ordem_servicos/servico_executado/#{@ordem_servicos_executado.ordem_servico_id}" }
      format.xml  { head :ok }
    end
  end
end
