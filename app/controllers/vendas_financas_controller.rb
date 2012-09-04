class VendasFinancasController < ApplicationController

  def index
    @vendas_financas = VendasFinanca.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @vendas_financas }
    end
  end

  def show
    @vendas_financa = VendasFinanca.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @vendas_financa }
    end
  end

  def new
    @vendas_financa = VendasFinanca.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @vendas_financa }
    end
  end

  def edit
    @vendas_financa = VendasFinanca.find(params[:id])
    @produto_count       = VendasProduto.sum(:quantidade,:conditions => ['venda_id = ?',@vendas_financa.venda_id] )
    @produto_sum_dolar   = VendasProduto.sum(:total_dolar,:conditions => ['venda_id = ?',@vendas_financa.venda_id] )
    @produto_sum_guarani = VendasProduto.sum(:total_guarani,:conditions => ['venda_id = ?',@vendas_financa.venda_id] )
    @cota_count          = VendasFinanca.count(:id,:conditions => ['venda_id = ?',@vendas_financa.venda_id] )
    @cota_total          = @cota_count +1

  end

  def create
    @vendas_financa = VendasFinanca.new(params[:vendas_financa])
    @vendas_financa.usuario_created      = current_user.id
    @vendas_financa.unidade_created      = current_unidade.id
    @vendas_financa.conta_created        = current_conta.id
    @vendas_financa.turno_created        = current_turno.id
    
    if $empresa == 'E01'
      @vendas_financa.conta_id             = current_conta.id
      @vendas_financa.conta_nome           = current_conta.nome
    end
    respond_to do |format|
      if @vendas_financa.save
        flash[:notice] = 'Grabado con Sucesso'        
          format.html { redirect_to "/vendas/vendas_financa_final/#{@vendas_financa.venda_id}" }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @vendas_financa = VendasFinanca.find(params[:id])
    @vendas_financa.usuario_updated      = current_user.id
    @vendas_financa.unidade_updated      = current_unidade.id
    @vendas_financa.conta_updated        = current_conta.id
    @vendas_financa.turno_updated        = current_turno.id
    
    if $empresa == 'E01'
      @vendas_financa.conta_id             = current_conta.id
      @vendas_financa.conta_nome           = current_conta.nome
    end
    respond_to do |format|
      if @vendas_financa.update_attributes(params[:vendas_financa])
        flash[:notice] = 'Actualizado con Sucesso'
        if @vendas_financa.tipo == 0
          format.html { redirect_to "/vendas/vendas_financa_contado/#{@vendas_financa.venda_id}" }
        else
          format.html { redirect_to "/vendas/vendas_financa/#{@vendas_financa.venda_id}" }
        end
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @vendas_financa.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @vendas_financa = VendasFinanca.find(params[:id])
    @vendas_financa.destroy

    respond_to do |format|
      format.html { redirect_to "/vendas/vendas_financa/#{@vendas_financa.venda_id}" }
      format.xml  { head :ok }
    end
  end
end
