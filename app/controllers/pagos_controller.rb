class PagosController < ApplicationController
before_filter :authenticate

  def get_moeda            #
    @moeda =  Moeda.find(:first, :conditions =>  [ "data = ?", params[:key]])
    return render :text => "<script type='text/javascript'>
                              document.getElementById('pago_cotacao').value       = '#{format("%.2f",@moeda.dolar_venda.to_f)}';
                            </script>"
  end

  def nova_cota            #
    @pago = Pago.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pago }
    end
  end

  def busca_proveedor      #
    @pago    = Pago.find(params[:id])
    @cliente  = Proveedore.all(:conditions => ["persona_id = ? AND liquidacao = 0 AND tipo = 1 AND divida_guarani > 0 ",params[:busca]],:order => 'data,documento_numero,cota')

  end

  def get_cliente          #
    @cliente =  Persona.find(:first, :conditions =>  [ "nome = ?", params[:persona_busca]])
    return render :text => "<script type='text/javascript'>
                              document.getElementById('pago_ruc').value                = '#{@cliente.ruc.to_s}';
                              document.getElementById('pago_persona_id').value         = '#{@cliente.id.to_s}';
                              document.getElementById('pago_persona_nome').value       = '#{@cliente.nome.to_s}';
                            </script>"
  end

  def pago_final          #
    @pago       = Pago.find(params[:id])
    @total_pago_dolar   = PagosDetalhe.sum(:pago_dolar, :conditions => ['pago_id = ?',params[:id]])
    @total_pago_guarani = PagosDetalhe.sum(:pago_guarani, :conditions => ['pago_id = ?',params[:id]])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pago }
    end
    session[:pagina] = ''
  end

  def comprovante_print   #
    @pago = Pago.find(params[:id])
    render :layout => false
  end



  #METHOD BASE------------------------------------------------------------------

  def index                #
    @pagos = Pago.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pagos }
    end
  end

  def show                 #
    @pago       = Pago.find(params[:id])
    @total_pago_dolar   = PagosDetalhe.sum(:pago_dolar, :conditions => ['pago_id = ?',params[:id]])
    @total_pago_guarani = PagosDetalhe.sum(:pago_guarani, :conditions => ['pago_id = ?',params[:id]])
    @count              = PagosDetalhe.count(:id, :conditions => ['pago_id = ?',params[:id]])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pago }
    end
  end

  def new                  #
    @pago = Pago.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pago }
    end
  end

  def edit                 #
    @pago = Pago.find(params[:id])
    session[:pagina] = '1'
  end

  def create               #
    @pago = Pago.new(params[:pago])
    @pago.usuario_created = current_user.id
    @pago.unidade_created = current_unidade.id


    respond_to do |format|
      if @pago.save
        flash[:notice] = 'Grabaco con Sucesso!'
        format.html { redirect_to(@pago) }
        format.xml  { render :xml => @pago, :status => :created, :location => @pago }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pago.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update               #
    @pago = Pago.find(params[:id])
    @pago.usuario_updated = current_user.id
    @pago.unidade_updated = current_unidade.id

    respond_to do |format|

      if @pago.update_attributes(params[:pago])
        flash[:notice] = 'Actualizado con Sucesso.'
        
        if session[:pagina] == '1'
          format.html { redirect_to(@pago) }
          format.xml  { head :ok }
        else 
          format.html { redirect_to(pagos_url) }
          format.xml  { head :ok }
        end

      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pago.errors, :status => :unprocessable_entity }
                
      end

    end
  end

  def destroy              #
    @pago = Pago.find(params[:id])
    @pago.destroy

    respond_to do |format|
      format.html { redirect_to(pagos_url) }
      format.xml  { head :ok }
    end
  end
end

