class PlanoDeContasController < ApplicationController
before_filter :authenticate
cache_sweeper :plano_de_conta_sweeper, :only => [:create, :update, :destroy]

  def index
    @plano_de_contas = PlanoDeConta.find_recent

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @plano_de_contas }
    end
  end

  def show
    @plano_de_conta = PlanoDeConta.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @plano_de_conta }
    end
  end

  def new
    @plano_de_conta = PlanoDeConta.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @plano_de_conta }
    end
  end

  def edit
    @plano_de_conta = PlanoDeConta.find(params[:id])
  end

  def create
    @plano_de_conta = PlanoDeConta.new(params[:plano_de_conta])
    @plano_de_conta.usuario_created = current_user.usuario_nome
    @plano_de_conta.unidade_created = current_unidade.unidade_nome


    respond_to do |format|
      if @plano_de_conta.save
        flash[:notice] = 'PlanoDeConta was successfully created.'
        format.html { redirect_to(plano_de_contas_url) }
        format.xml  { render :xml => @plano_de_conta, :status => :created, :location => @plano_de_conta }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @plano_de_conta.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @plano_de_conta = PlanoDeConta.find(params[:id])
    @plano_de_conta.usuario_updated = current_user.usuario_nome
    @plano_de_conta.unidade_updated = current_unidade.unidade_nome

    respond_to do |format|
      if @plano_de_conta.update_attributes(params[:plano_de_conta])
        flash[:notice] = 'PlanoDeConta was successfully updated.'
        format.html { redirect_to(plano_de_contas_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @plano_de_conta.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @plano_de_conta = PlanoDeConta.find(params[:id])
    @plano_de_conta.destroy

    respond_to do |format|
      format.html { redirect_to(plano_de_contas_url) }
      format.xml  { head :ok }
    end
  end
end
