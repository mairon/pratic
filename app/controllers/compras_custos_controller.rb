class ComprasCustosController < ApplicationController

  def relatorio_custo_produto  #
       if params[:busca]['produto'].to_s == ""
          cod  = "data >= '#{params[:inicio]}' AND data <= '#{params[:final]}' "
          prod = [cod]
       else
          cod  = "data >= '#{params[:inicio]}' AND data <= '#{params[:final]}' "
          prod = [cod + "AND produto_id = ?",params[:busca]['produto'] ]

       end          
          @custo   = ComprasCusto.all( :conditions => prod )

          respond_to do |format|
              format.html {render :layout => "consulta"}
          end

  end

  def index                    #
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show                     #
    @compras_custo = ComprasCusto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @compras_custo }
    end
  end

  def new                      #
    @compras_custo = ComprasCusto.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @compras_custo }
    end
  end

  def edit                     #
    @compras_custo = ComprasCusto.find(params[:id])
  end

  def create                   #
    @compras_custo = ComprasCusto.new(params[:compras_custo])

    respond_to do |format|
      if @compras_custo.save
        flash[:notice] = 'ComprasCusto was successfully created.'
        format.html { redirect_to(@compras_custo) }
        format.xml  { render :xml => @compras_custo, :status => :created, :location => @compras_custo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @compras_custo.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update                   #
    @compras_custo = ComprasCusto.find(params[:id])

    respond_to do |format|
      if @compras_custo.update_attributes(params[:compras_custo])
        flash[:notice] = 'ComprasCusto was successfully updated.'
        format.html { redirect_to(@compras_custo) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @compras_custo.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy                  #
    @compras_custo = ComprasCusto.find(params[:id])
    @compras_custo.destroy

    respond_to do |format|
      format.html { redirect_to(compras_custos_url) }
      format.xml  { head :ok }
    end
  end
end
