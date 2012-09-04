class TransferenciaContasController < ApplicationController
  before_filter :authenticate

  def get_moeda           #
    @moeda =  Moeda.find(:first,:select => 'dolar_venda', :conditions =>  [ "data = ?", params[:key]])
    return render :text => "<script type='text/javascript'>
                               document.getElementById('transferencia_conta_cotacao').value       = '#{format("%.2f",@moeda.dolar_venda.to_f)}';
                            </script>"
  end

  def index
    @transferencia_contas = TransferenciaConta.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @transferencia_contas }
    end
  end

  def show
    @transferencia_conta = TransferenciaConta.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @transferencia_conta }
    end
  end

  def new
    @transferencia_conta = TransferenciaConta.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @transferencia_conta }
    end
  end

  def edit
    @transferencia_conta = TransferenciaConta.find(params[:id])
  end

  def create
    @transferencia_conta = TransferenciaConta.new(params[:transferencia_conta])
    @transferencia_conta.usuario_created = current_user.id
    @transferencia_conta.unidade_created = current_unidade.id

    respond_to do |format|
      if @transferencia_conta.save
        format.html { redirect_to(transferencia_contas_url) }
        format.xml  { render :xml => @transferencia_conta, :status => :created, :location => @transferencia_conta }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @transferencia_conta.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @transferencia_conta = TransferenciaConta.find(params[:id])
    @transferencia_conta.usuario_updated = current_user.id
    @transferencia_conta.unidade_updated = current_unidade.id

    respond_to do |format|
      if @transferencia_conta.update_attributes(params[:transferencia_conta])
        format.html { redirect_to(transferencia_contas_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @transferencia_conta.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @transferencia_conta = TransferenciaConta.find(params[:id])
    @transferencia_conta.destroy

    respond_to do |format|
      format.html { redirect_to(transferencia_contas_url) }
      format.xml  { head :ok }
    end
  end
end
