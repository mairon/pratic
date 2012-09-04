class ComprasController < ApplicationController
    before_filter :authenticate

    def get_moeda            #
    @moeda =  Moeda.find(:first,:select => 'dolar_venda', :conditions =>  [ "data = ?", params[:key]])
    return render :text => "<script type='text/javascript'>
                               document.getElementById('compra_cotacao').value       = '#{format("%.2f",@moeda.dolar_venda.to_f)}';
                            </script>"
    end

    def get_produto          #
        @produto =  Produto.find(:first, :conditions =>  [ "id = ?", params[:key]])
        return render :text => "<script type='text/javascript'>
                              document.getElementById('compras_produto_produto_nome').value       = '#{@produto.nome.to_s}';
                              document.getElementById('compras_produto_iva_taxa').value           = '#{@produto.taxa.to_i}';
                              document.getElementById('compras_produto_produto_id').value         = '#{@produto.id.to_i}';
                              document.getElementById('compras_produto_codigo').value             = '#{@produto.codigo.to_s}';
                              document.getElementById('compras_produto_clase_id').value           = '#{@produto.clase_id.to_i}';
                              document.getElementById('compras_produto_grupo_id').value           = '#{@produto.grupo_id.to_i}';
                              document.getElementById('compras_produto_fabricante_cod').value     = '#{@produto.fabricante_cod.to_s}';
                            </script>"
    end

    def compras_produto      #

        @compra  = Compra.find(params[:id])
        @produto = ComprasProduto.find(:all,:conditions => ['compra_id = ?',params[:id]] )
        @produto_count       = ComprasProduto.count(:all,:conditions => ['compra_id = ?',params[:id]] )
        @produto_sum_dolar   = ComprasProduto.sum(:total_dolar,:conditions => ['compra_id = ?',params[:id]] )
        @produto_sum_guarani = ComprasProduto.sum(:total_guarani,:conditions => ['compra_id = ?',params[:id]] )

        render :layout=>false


    end

    def get_proveedor        #
        @persona =  Persona.find(:first, :conditions =>  [ "id = ?", params[:key]])
        return render :text => "<script type='text/javascript'>
                              document.getElementById('compras_documento_persona_ruc').value       = '#{@persona.ruc.to_s}';
                              document.getElementById('compras_documento_persona_id').value        = '#{@persona.id.to_i}';
                              document.getElementById('compras_documento_persona_nome').value      = '#{@persona.nome.to_s}';
                            </script>"
    end

    def get_proveedor_financa#
        @persona =  Persona.find(:first, :conditions =>  [ "id = ?", params[:key]])
        return render :text => "<script type='text/javascript'>
                              document.getElementById('compras_financa_persona_ruc').value       = '#{@persona.ruc.to_s}';
                              document.getElementById('compras_financa_persona_id').value        = '#{@persona.id.to_i}';
                              document.getElementById('compras_financa_persona_nome').value      = '#{@persona.nome.to_s}';
                            </script>"
    end

    #IMPORTACAO---------------------------------------------------------------------

    def prorateo             #

        @compra          = Compra.find(params[:id])
        @compras_produto = ComprasProduto.all(:conditions => ['compra_id  =  ?',params[:id] ],:order => 1 )

        @compras_documento = ComprasDocumento.all( :conditions => ["compra_id  =  ?",params[:id] ] )



        respond_to do |format|
            format.html # show.html.erb
            format.xls  { render :action => "prorateo", :layout => false }
            format.pdf  { render :action => "prorateo", :layout => false }
        end
    end

    def compras_financa      #
        @compra = Compra.find(params[:id])
        @cota_count          = ComprasFinanca.count(:id,:conditions => ['compra_id = ?',params[:id]] )
        @cota_total          = @cota_count +1
        @produto_count       = ComprasProduto.sum(:quantidade,:conditions => ['compra_id = ?',params[:id]] )
        @produto_sum_dolar   = ComprasProduto.sum(:total_dolar,:conditions => ['compra_id = ?',params[:id]] )
        @produto_sum_guarani = ComprasProduto.sum(:total_guarani,:conditions => ['compra_id = ?',params[:id]] )
    end

    def compras_documento    #
        @compra = Compra.find(params[:id])
        @produto_count           = ComprasProduto.sum( :quantidade,            :conditions => ['compra_id = ?',params[:id]] )
        @produto_sum_dolar       = ComprasProduto.sum( :total_dolar,           :conditions => ['compra_id = ?',params[:id]] )
        @produto_sum_guarani     = ComprasProduto.sum( :total_guarani,         :conditions => ['compra_id = ?',params[:id]] )
        @total_dolar_documento   = ComprasDocumento.sum( :total_dolar,         :conditions => ['compra_id = ?',params[:id]] )
        @total_guarani_documento = ComprasDocumento.sum( :total_guarani,       :conditions => ['compra_id = ?',params[:id]] )
        @total_iva_dolar         = ComprasDocumento.sum( :imposto_10_dolar,    :conditions => ['compra_id = ?',params[:id]] )
        @total_iva_guarani       = ComprasDocumento.sum( :imposto_10_guarani,  :conditions => ['compra_id = ?',params[:id]] )
        #TOTAL DESPACHO--------------------------------------
        @total_invoice_dolar     = ComprasDocumento.sum( :total_dolar,         :conditions => ["compra_id = ? AND documento_nome = 'INVOICE' ",params[:id]] )
        @total_invoice_guarani   = ComprasDocumento.sum( :total_guarani,       :conditions => ["compra_id = ? AND documento_nome = 'INVOICE' ",params[:id]] )
        @valor_imponible_dolar   = ComprasDocumento.sum( :gravadas_10_dolar,   :conditions => ["compra_id = ? AND documento_nome = 'LIQUIDACION DE DESPACHO' ",params[:id]] )
        @valor_imponible_guarani = ComprasDocumento.sum( :gravadas_10_guarani, :conditions => ["compra_id = ? AND documento_nome = 'LIQUIDACION DE DESPACHO' ",params[:id]] )
        @iva_imponible_dolar     = ComprasDocumento.sum( :imposto_10_dolar,    :conditions => ["compra_id = ? AND documento_nome = 'LIQUIDACION DE DESPACHO' ",params[:id]] )
        @iva_imponible_guarani   = ComprasDocumento.sum( :imposto_10_guarani,  :conditions => ["compra_id = ? AND documento_nome = 'LIQUIDACION DE DESPACHO' ",params[:id]] )

        @total_liquidacao_dolar  = @total_dolar_documento - @total_invoice_dolar - @valor_imponible_dolar + @iva_imponible_dolar
        @total_liquidacao_guarani= @total_guarani_documento - @total_invoice_guarani - @valor_imponible_guarani + @iva_imponible_guarani

    end

    def novo_produto         #
        @compra = Compra.find(params[:id])


    end

    def novo_financa         #
        @compra = Compra.find(params[:id])
        @cota_count          = ComprasFinanca.count(:id,:conditions => ['compra_id = ?',params[:id]] )
        @cota_total          = @cota_count +1
        @compras_documento   = ComprasDocumento.find_by_compra_id(params[:id])
        @produto_count       = ComprasProduto.sum(:quantidade,:conditions => ['compra_id = ?',params[:id]] )
        @produto_sum_dolar   = ComprasProduto.sum(:total_dolar,:conditions => ['compra_id = ?',params[:id]] )
        @produto_sum_guarani = ComprasProduto.sum(:total_guarani,:conditions => ['compra_id = ?',params[:id]] )



    end

    def novo_documento       #
        @compra = Compra.find(params[:id])
        @produto_sum_dolar   = ComprasProduto.sum(:total_dolar,:conditions => ['compra_id = ?',params[:id]] )
        @produto_sum_guarani = ComprasProduto.sum(:total_guarani,:conditions => ['compra_id = ?',params[:id]] )



    end

    def total_documento      #
        @compra = Compra.find(params[:id])

        @produto_sum_dolar       = ComprasProduto.sum( :total_dolar,           :conditions => ['compra_id = ?',params[:id]] )
        @produto_sum_guarani     = ComprasProduto.sum( :total_guarani,         :conditions => ['compra_id = ?',params[:id]] )
        @total_dolar_documento   = ComprasDocumento.sum( :total_dolar,         :conditions => ['compra_id = ?',params[:id]] )
        @total_guarani_documento = ComprasDocumento.sum( :total_guarani,       :conditions => ['compra_id = ?',params[:id]] )
        @total_iva_dolar         = ComprasDocumento.sum( :imposto_10_dolar,    :conditions => ['compra_id = ?',params[:id]] )
        @total_iva_guarani       = ComprasDocumento.sum( :imposto_10_guarani,  :conditions => ['compra_id = ?',params[:id]] )
        @total_frete_dolar       = ComprasDocumento.sum( :total_dolar,         :conditions => ["compra_id = ? AND tipo_documento = 'FLETES' ",params[:id]] )
        @total_frete_guarani     = ComprasDocumento.sum( :total_guarani,       :conditions => ["compra_id = ? AND tipo_documento = 'FLETES' ",params[:id]] )
        @total_seguro_dolar      = ComprasDocumento.sum( :total_dolar,         :conditions => ["compra_id = ? AND tipo_documento = 'SEGUROS' ",params[:id]] )
        @total_seguro_guarani    = ComprasDocumento.sum( :total_guarani,       :conditions => ["compra_id = ? AND tipo_documento = 'SEGUROS' ",params[:id]] )
        @total_outros_dolar      = ComprasDocumento.sum( :total_dolar,         :conditions => ["compra_id = ? AND tipo_documento = 'OUTROS' ",params[:id]] )
        @total_outros_guarani    = ComprasDocumento.sum( :total_guarani,       :conditions => ["compra_id = ? AND tipo_documento = 'OUTROS' ",params[:id]] )


        #TOTAL DESPACHO--------------------------------------
        @total_invoice_dolar     = ComprasDocumento.sum( :total_dolar,         :conditions => ["compra_id = ? AND tipo_documento = 'MERCADERIAS' ",params[:id]] )
        @total_invoice_guarani   = ComprasDocumento.sum( :total_guarani,       :conditions => ["compra_id = ? AND tipo_documento = 'MERCADERIAS' ",params[:id]] )


        session[:prorateio] = "PRORATEIO"
    end

    #COMPRA-------------------------------------------------------------------------
    def index_compra         #

        respond_to do |format|
            format.html # index.html.erb
            format.xml  { render :xml => @compras }
        end
    end

    def busca_compra         #
        @compras = Compra.filtro_compra(params)

        render :layout => false
    end


    def new_compra           #
        @compra = Compra.new

        respond_to do |format|
            format.html # new.html.erb
            format.xml  { render :xml => @compra }
        end
    end

    def edit_compra          #
        @compra  = Compra.find(params[:id])
        $pagina = ""
    end

    #GASTO--------------------------------------------------------------------------
    def index_gasto          #
        @compras = Compra.all(:conditions => ['tipo_compra = 1'])
        respond_to do |format|
            format.html # index.html.erb
            format.xml  { render :xml => @compras }
        end
    end

    def new_gasto            #
        @compra = Compra.new

        respond_to do |format|
            format.html # new.html.erb
            format.xml  { render :xml => @compra }
        end
    end

    def edit_gasto           #
        @compra  = Compra.find(params[:id])
        $pagina = ""
    end


    #METHODS BASE-------------------------------------------------------------------
    def index                #
        @compras = Compra.all(:conditions => ['tipo_compra = 2'])
        respond_to do |format|
            format.html # index.html.erb
            format.xml  { render :xml => @compras }
        end
    end

    def show                 #
        @compra                       = Compra.find(params[:id])
        @count_produtos               = ComprasProduto.count( :id, :conditions => ['compra_id = ?', params[:id]])
        @sum_produtos_dolar           = ComprasProduto.sum( :total_dolar, :conditions => ['compra_id = ?', params[:id]])
        @sum_produtos_guarani         = ComprasProduto.sum( :total_guarani, :conditions => ['compra_id = ?', params[:id]])
        @sum_desconto_dolar           = ComprasProduto.sum( :desconto_dolar, :conditions => ['compra_id = ?', params[:id]])
        @sum_desconto_guarani         = ComprasProduto.sum( :desconto_guarani, :conditions => ['compra_id = ?', params[:id]])

        @total_dolar                = @sum_produtos_dolar - @sum_desconto_dolar
        @total_guarani                = @sum_produtos_guarani - @sum_desconto_guarani
        respond_to do |format|
            format.html # show.html.erb
            format.xml  { render :xml => @compra }
        end
    end

    def new                  #
        @compra = Compra.new

        respond_to do |format|
            format.html # new.html.erb
            format.xml  { render :xml => @compra }
        end
    end

    def edit                 #
        @compra  = Compra.find(params[:id])
        session[:prorateio] = ""
    end

    def create               #
        @compra = Compra.new(params[:compra])
        #USUARIO UNIDADE
        @compra.usuario_created = current_user.id
        @compra.unidade_created = current_unidade.id
        
        respond_to do |format|
            if @compra.save

                if @compra.rubro_id == 99
                    flash[:notice] = 'Grabado Con Sucesso!'
                    format.html { redirect_to("/sueldos/fim_detalhes/#{@compra.sueldo_id.to_s}"  ) }
                    format.xml  { render :xml => @compra, :status => :created, :location => @compra }
                end


                if @compra.tipo_compra == 0 || @compra.tipo_compra == 2 || @compra.tipo_compra == 3
                    flash[:notice] = 'Precione F4 para elegir un producto'
                    format.html { redirect_to(@compra) }
                    format.xml  { render :xml => @compra, :status => :created, :location => @compra }
                else
                    flash[:notice] = 'Grabado con Sucesso'
                    format.html { redirect_to "/compras/index_gasto" }
                    format.xml  { render :xml => @compra, :status => :created, :location => @compra }

                end

            else
                if @compra.tipo_compra == 0 || @compra.tipo_compra == 3
                    format.html { render :action => "new_compra" }
                    format.xml  { render :xml => @compra.errors, :status => :unprocessable_entity }
                elsif @compra.tipo_compra == 1
                    format.html { render :action => "new_gasto" }
                    format.xml  { render :xml => @compra.errors, :status => :unprocessable_entity }
                elsif @compra.tipo_compra == 2
                    format.html { render :action => "new" }
                    format.xml  { render :xml => @compra.errors, :status => :unprocessable_entity }
                end
            end
        end
    end

    def update               #
        @compra = Compra.find(params[:id])
        #USUARIO UNIDADE
        @compra.usuario_updated = current_user.id        
        @compra.unidade_updated = current_unidade.id

        respond_to do |format|

            if @compra.update_attributes(params[:compra])
                flash[:notice] = 'Grabado con Sucesso!'

                if @compra.rubro_id == 99
                    flash[:notice] = 'Grabado Con Sucesso!'
                    format.html { redirect_to("/sueldos/fim_detalhes/#{@compra.sueldo_id.to_s}" ) }
                    format.xml  { render :xml => @compra, :status => :created, :location => @compra }

                end

                 if session[:prorateio] == "PRORATEIO"
                    format.html { redirect_to "/compras/prorateo/#{@compra.id}" }
                 end


                if @compra.tipo_compra == 0 || @compra.tipo_compra == 2 || @compra.tipo_compra == 3
                    flash[:notice] = 'Precione F4 para elegir un producto'
                    format.html { redirect_to(@compra) }
                    format.xml  { render :xml => @compra, :status => :created, :location => @compra }
                else
                    flash[:notice] = 'Grabado con Sucesso'
                    format.html { redirect_to "/compras/index_gasto" }
                    format.xml  { render :xml => @compra, :status => :created, :location => @compra }

                end
            else
                format.html { render :action => "edit" }
                format.xml  { render :xml => @compra.errors, :status => :unprocessable_entity }
            end
        end
    end

    def destroy              #
        @compra = Compra.find(params[:id])
        @compra.destroy

        respond_to do |format|
             if @compra.rubro_id == 99
                    format.html { redirect_to("/sueldos/fim_detalhes/#{@compra.sueldo_id.to_s}" ) }
             elsif @compra.tipo_compra == 0 || @compra.tipo_compra == 3
                format.html { redirect_to "/compras/index_compra" }
                format.xml  { head :ok }
            elsif  @compra.tipo_compra == 1
                format.html { redirect_to "/compras/index_gasto" }
                format.xml  { head :ok }
            elsif  @compra.tipo_compra == 2
                format.html { redirect_to(compras_url) }
                format.xml  { head :ok }
            end
        end
    end
end
  