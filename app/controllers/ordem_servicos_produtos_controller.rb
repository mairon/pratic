class OrdemServicosProdutosController < ApplicationController

  def index             #
    @ordem_servicos_produtos = OrdemServicosProduto.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ordem_servicos_produtos }
    end
  end

  def show              #
    @ordem_servicos_produto = OrdemServicosProduto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ordem_servicos_produto }
    end
  end

  def new               #
    @ordem_servicos_produto = OrdemServicosProduto.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ordem_servicos_produto }
    end
  end

  def edit              #
    @ordem_servicos_produto = OrdemServicosProduto.find(params[:id])
  end

  def create            #
    @ordem_servicos_produto = OrdemServicosProduto.new(params[:ordem_servicos_produto])

    respond_to do |format|
      if @ordem_servicos_produto.save
        flash[:notice] = 'Grabaco Con Sucesso'
        format.html { redirect_to "/ordem_servicos/show/#{@ordem_servicos_produto.ordem_servico_id}" }
        format.xml  { render :xml => @ordem_servicos_produto, :status => :created, :location => @ordem_servicos_produto }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ordem_servicos_produto.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update            #
    @ordem_servicos_produto = OrdemServicosProduto.find(params[:id])

    respond_to do |format|
      if @ordem_servicos_produto.update_attributes(params[:ordem_servicos_produto])
        flash[:notice] = 'Actualizado con Sucesso'
        format.html { redirect_to "/ordem_servicos/show/#{@ordem_servicos_produto.ordem_servico_id}" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ordem_servicos_produto.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy           #
    @ordem_servicos_produto = OrdemServicosProduto.find(params[:id])
    @ordem_servicos_produto.destroy

    respond_to do |format|
      format.html { redirect_to "/ordem_servicos/show/#{@ordem_servicos_produto.ordem_servico_id}" }
      format.xml  { head :ok }
    end
  end
end
