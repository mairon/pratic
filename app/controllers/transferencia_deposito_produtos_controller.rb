class TransferenciaDepositoProdutosController < ApplicationController
  before_filter :authenticate

  def index
    @transferencia_deposito_produtos = TransferenciaDepositoProduto.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @transferencia_deposito_produtos }
    end
  end

  def show
    @transferencia_deposito_produto = TransferenciaDepositoProduto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @transferencia_deposito_produto }
    end
  end

  def new
    @transferencia_deposito_produto = TransferenciaDepositoProduto.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @transferencia_deposito_produto }
    end
  end

  def edit
    @transferencia_deposito_produto = TransferenciaDepositoProduto.find(params[:id])
  end

  def create
    @transferencia_deposito_produto = TransferenciaDepositoProduto.new(params[:transferencia_deposito_produto])

    respond_to do |format|
      if @transferencia_deposito_produto.save
        format.html { redirect_to "/transferencia_depositos/#{@transferencia_deposito_produto.transferencia_deposito_id}" }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @transferencia_deposito_produto = TransferenciaDepositoProduto.find(params[:id])

    respond_to do |format|
      if @transferencia_deposito_produto.update_attributes(params[:transferencia_deposito_produto])
        format.html { redirect_to "/transferencia_depositos/#{@transferencia_deposito_produto.transferencia_deposito_id}" }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @transferencia_deposito_produto = TransferenciaDepositoProduto.find(params[:id])
    @transferencia_deposito_produto.destroy

    respond_to do |format|
        format.html { redirect_to "/transferencia_depositos/#{@transferencia_deposito_produto.transferencia_deposito_id}" }
    end
  end
end
