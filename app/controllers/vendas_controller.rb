class VendasController < ApplicationController
  before_filter :authenticate

  def get_codigo                                #
    
    paramentro = 'chapa'
    @persona =  Persona.find(:first, :conditions =>  [ "#{paramentro} = ?", params[:codigo]])
    return render :text => "<script type='text/javascript'>
                              document.getElementById('vendas_financa_persona_id').value           = '#{@persona.id.to_i}';
                              document.getElementById('vendas_financa_persona_nome').value         = '#{@persona.nome.to_s}';
                              document.getElementById('vendas_financa_cidade_id').value            = '#{@persona.cidade_id.to_i}';
                              document.getElementById('vendas_financa_ruc').value                  = '#{@persona.ruc.to_s}';
                              document.getElementById('vendas_financa_direcao').value              = '#{@persona.direcao.to_s}';
                              document.getElementById('vendas_financa_bairro').value               = '#{@persona.bairro.to_s}';
                            </script>"
  end

  def get_codigo_barra_produto                  #
    @produto =  Produto.find(:first, :conditions =>  [ "barra = ?", params[:codigo]]) 
    
    return render :text => "<script type='text/javascript'>
                              document.getElementById('venda_produto_produto_busca_').value             = '#{@produto.nome.to_s}';
                              document.getElementById('vendas_produto_produto_nome').value             = '#{@produto.nome.to_s}';
                              document.getElementById('vendas_produto_produto_id').value               = '#{@produto.id.to_i}';
                              document.getElementById('vendas_produto_clase_id').value                 = '#{@produto.clase_id.to_i}';
                              document.getElementById('vendas_produto_grupo_id').value                 = '#{@produto.grupo_id.to_i}';
                              document.getElementById('vendas_produto_tipo').value                     = '#{@produto.tipo.to_i}';
                              document.getElementById('vendas_produto_unitario_dolar').value           = '#{format("%.2f",@produto.preco_venda_dolar.to_f)}';
                              document.getElementById('vendas_produto_unitario_guarani').value         = '#{@produto.preco_venda_guarani.to_s}';
                              document.getElementById('vendas_produto_total_dolar').value           = '#{format("%.2f",@produto.preco_venda_dolar.to_f)}';
                              document.getElementById('vendas_produto_total_guarani').value         = '#{@produto.preco_venda_guarani.to_s}';
                              document.getElementById('vendas_produto_taxa').value                     = '#{@produto.taxa.to_f}';
                              document.getElementById('red').innerHTML                                   =  '<span>'+'#{@produto.preco_venda_guarani.to_s}'+'</span>' ;
                           </script>"
  end

  def get_produto                               #
    @produto =  Produto.find(:first, :conditions =>  [ "nome = ?", params[:produto_busca]])
    
    
    return render :text => "<script type='text/javascript'>

                              document.getElementById('vendas_produto_produto_nome').value             = '#{@produto.nome.to_s}';
                              document.getElementById('vendas_produto_produto_id').value               = '#{@produto.id.to_i}';
                              document.getElementById('vendas_produto_codigo').value                   = '#{@produto.barra.to_i}';
                              document.getElementById('vendas_produto_clase_id').value                 = '#{@produto.clase_id.to_i}';
                              document.getElementById('vendas_produto_grupo_id').value                 = '#{@produto.grupo_id.to_i}';
                              document.getElementById('vendas_produto_tipo').value                     = '#{@produto.tipo.to_i}';
                              document.getElementById('vendas_produto_unitario_dolar').value           = '#{format("%.2f",@produto.preco_venda_dolar.to_f)}';
                              document.getElementById('vendas_produto_unitario_guarani').value         = '#{@produto.preco_venda_guarani.to_s}';
                              document.getElementById('vendas_produto_total_dolar').value           = '#{format("%.2f",@produto.preco_venda_dolar.to_f)}';
                              document.getElementById('vendas_produto_total_guarani').value         = '#{@produto.preco_venda_guarani.to_s}';
                              document.getElementById('red').innerHTML                                   =  '<span>'+'#{@produto.preco_venda_guarani.to_s}'+'</span>' ;

                            </script>"
  end

  def get_moeda                                 #
    @moeda =  Moeda.find(:first, :conditions =>  [ "data = ?", params[:key]])
    return render :text => "<script type='text/javascript'>
                              document.getElementById('venda_cotacao').value       = '#{format("%.2f",@moeda.dolar_venda.to_f)}';
                            </script>"
  end

  def get_cliente                               #
    @cliente =  Persona.find(:first, :conditions =>  [ "nome = ?", params[:persona_busca]])
    return render :text => "<script type='text/javascript'>
                              document.getElementById('vendas_financa_persona_nome').value       = '#{@cliente.nome.to_s}';
                              document.getElementById('vendas_financa_persona_id').value         = '#{@cliente.id.to_i}';
                              document.getElementById('vendas_financa_ruc').value                = '#{@cliente.ruc.to_s}';                              
                              document.getElementById('vendas_financa_direcao').value            = '#{@cliente.direcao.to_s}';
                              document.getElementById('vendas_financa_cidade_id').value          = '#{@cliente.cidade_id.to_i}';
                              document.getElementById('vendas_financa_bairro').value             = '#{@cliente.bairro.to_s}';
                            </script>"
  end

  def novo_produto                              #
    @venda = Venda.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @venda }
    end
  end

  def vendas_financa                            #
    @venda = Venda.find(params[:id])
    @produto_count       = VendasProduto.sum(:quantidade,:conditions => ['venda_id = ?',params[:id]] )
    @produto_sum_dolar   = VendasProduto.sum(:total_dolar,:conditions => ['venda_id = ?',params[:id]] )
    @produto_sum_guarani = VendasProduto.sum(:total_guarani,:conditions => ['venda_id = ?',params[:id]] )
    @produto_iva_guarani = VendasProduto.sum(:iva_guarani,:conditions => ['venda_id = ?',params[:id]] )
    @cota_count          = VendasFinanca.count(:id,:conditions => ['venda_id = ?',params[:id]] )
    @cota_total          = @cota_count +1
    render :layout => 'vendas'
  end

  def vendas_financa_final                      #
    @venda = Venda.find(params[:id])
    @produto_count       = VendasProduto.sum(:quantidade,:conditions => ['venda_id = ?',params[:id]] )
    @produto_sum_dolar   = VendasProduto.sum(:total_dolar,:conditions => ['venda_id = ?',params[:id]] )
    @produto_sum_guarani = VendasProduto.sum(:total_guarani,:conditions => ['venda_id = ?',params[:id]] )
    @produto_iva_guarani = VendasProduto.sum(:iva_guarani,:conditions => ['venda_id = ?',params[:id]] )
    @cota_count          = VendasFinanca.count(:id,:conditions => ['venda_id = ?',params[:id]] )
    @cota_total          = @cota_count +1
    render :layout => 'vendas'
  end
 
  def novo_financa                              #
    @venda = Venda.find(params[:id])
    @cota_count          = VendasFinanca.count(:id,:conditions => ['venda_id = ?',params[:id]] )
    @cota_total          = @cota_count +1   
  end

 # FATURAS PENDENTES-------------------------------------------------------
 def faturas_pendentes                          #
    @vendas = Venda.all(:conditions => ["fatura = 0"])
    render :layout => 'application'
 end

 def filtro_faturas_pendentes                   #
     @vendas = Venda.find(params[:venda_ids])
     render :layout => 'application'
 end

 def update_faturas_pendentes                   #
     @vendas          = Venda.find(params[:venda_ids])

     @vendas.each do |venda|
      venda.update_attributes!(params[:venda].reject { |k,v| v.blank? })
     end
   flash[:notice] = 'Productos Facturados'
   redirect_to  :action => 'filtro_faturas_pendentes_comprovante', :paras =>  params[:venda_ids]
 end

  def filtro_faturas_pendentes_comprovante      #
     @vendas = Venda.find(params[:paras])
     render :layout => 'application'
 end

  def detalhes_produto                          #

    @produtos   = VendasProduto.all(:conditions => ['venda_id = ?',params[:id]] )
    render :layout => 'consulta'
  end

  def comprovante                               #
    @venda           = Venda.find(params[:id])
    @venda_produto   = VendasProduto.all(:total_dolar,:conditions => ['venda_id = ?',params[:id]] )
    @produto_sum_gs  = VendasProduto.sum(:total_guarani,:conditions => ['venda_id = ?',params[:id]] )
    render :layout => false
  end

  def comprovante_fatura_pendentes #
    @vendas = Venda.find(params[:paras])
    @venda_produto      = VendasProduto.all(:total_dolar,:conditions => ['venda_id = ?',params[:id]] )
    @produto_sum_gs     = VendasProduto.sum(:total_guarani,:conditions => ['venda_id = ?',params[:id]] )
    @produto_sum_iva5   = VendasProduto.sum(:iva_guarani,:conditions => ['taxa = 5  and venda_id = ?',params[:id]] )
    @produto_sum_iva10  = VendasProduto.sum(:iva_guarani,:conditions => ['taxa = 10 and venda_id = ?',params[:id]] )
    @produto_total_iva  = @produto_sum_iva5 + @produto_sum_iva10
    render :layout => false
  end

  def fatura                 #
    @venda              = Venda.find(params[:id])
    @venda_produto      = VendasProduto.all(:conditions => ['venda_id = ?',params[:id]] )
    @venda_produto      = VendasProduto.all(:conditions => ['venda_id = ?',params[:id]] )
    @produto_sum_iva10  = VendasProduto.sum(:iva_guarani,:conditions => ['taxa = 10 AND venda_id = ?',params[:id]] )
    @produto_sum_iva5   = VendasProduto.sum(:iva_guarani,:conditions => ['taxa = 5 AND venda_id = ?',params[:id]] )
    @produto_total_iva   = @produto_sum_iva10 + @produto_sum_iva10
    render :layout => false
  end

  def index                  #
    respond_to do |format|
      format.html { render :layout => 'application'}
      format.pdf  { render :action => "venda", :layout => false }
    end
  end

  def busca_vendas           #
    @vendas = Venda.filtro_vendas(params)
    respond_to do |format|
      format.html { render :layout => false}
    end
  end

  def show                   #
    @venda = Venda.find(params[:id])
    @total_produto     =  VendasProduto.sum(:quantidade,    :conditions => ['venda_id = ?',params[:id]])
    @total_dolar       =  VendasProduto.sum(:total_dolar,   :conditions => ['venda_id = ?',params[:id]])
    @total_guarani     =  VendasProduto.sum(:total_guarani, :conditions => ['venda_id = ?',params[:id]])
    @venda_financa     =  VendasFinanca.count(:conditions => ['venda_id = ?',params[:id]] )

    render :layout => 'vendas'
  end

  def new                    #
    @venda = Venda.new
    render :layout => 'vendas'
  end

  def edit                   #
    @venda = Venda.find(params[:id])
    render :layout => 'vendas'
  end

  def create                 #
    @venda = Venda.new(params[:venda])

    respond_to do |format|
      if @venda.save
         @venda.usuario_created = current_user.usuario_nome
         @venda.unidade_created = current_unidade.unidade_nome
         @venda.turno_created   = current_turno.nome
         @venda.conta_created   = current_conta.nome
        flash[:notice] = 'Insira los Productos'
        format.html { redirect_to(@venda) }
        format.xml  { render :xml => @venda, :status => :created, :location => @venda }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @venda.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update                 #
    @venda = Venda.find(params[:id])

    respond_to do |format|
      if @venda.update_attributes(params[:venda])
         @venda.usuario_updated = current_user.usuario_nome
         @venda.unidade_updated = current_unidade.unidade_nome
         @venda.turno_updated   = current_turno.nome
         @venda.conta_updated   = current_conta.nome

        flash[:notice] = 'Insira los Productos'
        format.html { redirect_to(@venda) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @venda.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy                #
    @venda = Venda.find(params[:id])
    @venda.destroy

    respond_to do |format|
      format.html { redirect_to(vendas_url) }
      format.xml  { head :ok }
    end
  end

end
