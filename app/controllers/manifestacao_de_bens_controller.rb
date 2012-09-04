class ManifestacaoDeBensController < ApplicationController
  # GET /manifestacao_de_bens
  # GET /manifestacao_de_bens.xml
  def index
    @manifestacao_de_bens = ManifestacaoDeBen.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @manifestacao_de_bens }
    end
  end

  # GET /manifestacao_de_bens/1
  # GET /manifestacao_de_bens/1.xml
  def show
    @manifestacao_de_ben = ManifestacaoDeBen.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @manifestacao_de_ben }
    end
  end

  # GET /manifestacao_de_bens/new
  # GET /manifestacao_de_bens/new.xml
  def new
    @manifestacao_de_ben = ManifestacaoDeBen.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @manifestacao_de_ben }
    end
  end

  # GET /manifestacao_de_bens/1/edit
  def edit
    @manifestacao_de_ben = ManifestacaoDeBen.find(params[:id])
  end

  # POST /manifestacao_de_bens
  # POST /manifestacao_de_bens.xml
  def create
    @manifestacao_de_ben = ManifestacaoDeBen.new(params[:manifestacao_de_ben])

    respond_to do |format|
      if @manifestacao_de_ben.save
        flash[:notice] = 'Grabando con Sucesso'
        format.html { redirect_to(manifestacao_de_bens_url) }
        format.xml  { render :xml => @manifestacao_de_ben, :status => :created, :location => @manifestacao_de_ben }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @manifestacao_de_ben.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /manifestacao_de_bens/1
  # PUT /manifestacao_de_bens/1.xml
  def update
    @manifestacao_de_ben = ManifestacaoDeBen.find(params[:id])

    respond_to do |format|
      if @manifestacao_de_ben.update_attributes(params[:manifestacao_de_ben])
        flash[:notice] = 'Actualizado con Sucesso'
        format.html { redirect_to(manifestacao_de_bens_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @manifestacao_de_ben.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /manifestacao_de_bens/1
  # DELETE /manifestacao_de_bens/1.xml
  def destroy
    @manifestacao_de_ben = ManifestacaoDeBen.find(params[:id])
    @manifestacao_de_ben.destroy

    respond_to do |format|
      format.html { redirect_to(manifestacao_de_bens_url) }
      format.xml  { head :ok }
    end
  end
end
