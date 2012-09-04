class SobrantesFaltantesController < ApplicationController
  before_filter :authenticate

  def get_moeda           #
    @moeda =  Moeda.find(:first,:select => 'dolar_venda', :conditions =>  [ "data = ?", params[:key]])
    return render :text => "<script type='text/javascript'>
                               document.getElementById('sobrantes_faltante_cotacao').value       = '#{format("%.2f",@moeda.dolar_venda.to_f)}';
                            </script>"
  end

  def index               #
    @sobrantes_faltantes = SobrantesFaltante.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sobrantes_faltantes }
    end
  end

  def show                #
    @sobrantes_faltante = SobrantesFaltante.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sobrantes_faltante }
    end
  end

  def new                 #
    @sobrantes_faltante = SobrantesFaltante.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sobrantes_faltante }
    end
  end

  def edit                #
    @sobrantes_faltante = SobrantesFaltante.find(params[:id])
  end

  def create              #
    @sobrantes_faltante = SobrantesFaltante.new(params[:sobrantes_faltante])
    @sobrantes_faltante.usuario_created = current_user.id
    @sobrantes_faltante.unidade_created = current_unidade.id

    respond_to do |format|
      if @sobrantes_faltante.save
        format.html { redirect_to(sobrantes_faltantes_url, :notice => 'Grabado con Sucesso') }
        format.xml  { render :xml => @sobrantes_faltante, :status => :created, :location => @sobrantes_faltante }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sobrantes_faltante.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update              #
    @sobrantes_faltante = SobrantesFaltante.find(params[:id])
    @sobrantes_faltante.usuario_updated = current_user.id
    @sobrantes_faltante.unidade_updated = current_unidade.id

    respond_to do |format|
      if @sobrantes_faltante.update_attributes(params[:sobrantes_faltante])
        format.html { redirect_to(sobrantes_faltantes_url, :notice => 'Actualizado con Sucesso') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sobrantes_faltante.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy             #
    @sobrantes_faltante = SobrantesFaltante.find(params[:id])
    @sobrantes_faltante.destroy

    respond_to do |format|
      format.html { redirect_to(sobrantes_faltantes_url) }
      format.xml  { head :ok }
    end
  end
end
