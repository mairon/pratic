class CobrosController < ApplicationController
before_filter :authenticate

    def get_moeda                   #
        @moeda =  Moeda.find(:first, :conditions =>  [ "data = ?", params[:key]])
        return render :text => "<script type='text/javascript'>
                              document.getElementById('cobro_cotacao').value       = '#{format("%.2f",@moeda.dolar_venda.to_f)}';
                            </script>"
    end

    def nova_cota                   #
        @cobro = Cobro.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.xml  { render :xml => @cobro }
        end
    end

    def busca_cliente               #
        @cobro    = Cobro.find(params[:id])
        render :layout => 'consulta'
    end

    def selecao_dividas             #
      
        @cobro    = Cobro.find(params[:id])

        @cliente  = Cliente.all( :select => ' id,
                                              persona_id,
                                              persona_nome,
                                              liquidacao,
                                              tipo,
                                              data,
                                              vencimento,
                                              venda_id,
                                              documento_nome,
                                              documento_numero,
                                              numero_ordem,
                                              cota,
                                              original,
                                              divida_dolar,
                                              divida_guarani,
                                              cobro_dolar,
                                              cobro_guarani,
                                              diferido,
                                              documento_numero_01,
                                              documento_numero_02',

                                 :conditions => [" persona_id = ? AND liquidacao = 0  AND tipo = '1' AND divida_guarani > 0 and data BETWEEN ? and ?",params[:busca],params[:inicio],params[:final]],:order => 'data,venda_id,cota')
                               
                                 render :layout => 'consulta'
    end

    def filtro_divida_selecionadas  #

         @cobro    = Cobro.find(params[:id])
         @cliente  = Cliente.find(params[:cliente_ids])

      
         @cliente.each do |cliente|
                  anterior_dolar     = Cliente.sum(:cobro_dolar, :conditions   => ["documento_numero = ? AND cota = ? AND tabela = 'COBROS_DETALHE'",cliente.documento_numero,cliente.cota])
                  anterior_guarani   = Cliente.sum(:cobro_guarani, :conditions => ["documento_numero = ? AND cota = ? AND tabela = 'COBROS_DETALHE'",cliente.documento_numero,cliente.cota])
                  saldo_dolar        = cliente.divida_dolar - anterior_dolar
                  saldo_guarani      = cliente.divida_guarani - anterior_guarani

                  CobrosDetalhe.create(  :cobro_id             => @cobro.id,
                                         :vencimento           => cliente.vencimento,
                                         :data                 => cliente.data,
                                         :persona_id           => cliente.persona_id,
                                         :persona_nome         => cliente.persona_nome,
                                         :documento_nome       => cliente.documento_nome,
                                         :documento_numero_01  => cliente.documento_numero_01,
                                         :documento_numero_02  => cliente.documento_numero_02,
                                         :documento_numero     => cliente.documento_numero,
                                         :venda_id             => cliente.venda_id,
                                         :cota                 => cliente.cota,
                                         :estado               => 1,
                                         :liquidacao           => 1,
                                         :valor_dolar          => cliente.divida_dolar.to_f,
                                         :valor_guarani        => cliente.divida_guarani.to_f,
                                         :anterior_dolar       => anterior_dolar.to_f,
                                         :anterior_guarani     => anterior_guarani.to_f,
                                         :cobro_dolar          => saldo_dolar,
                                         :cobro_guarani        => saldo_guarani
                                       )


         end

        respond_to do |format|
            format.html {redirect_to "/cobros/show/#{params[:id]}"}
            format.xml  { render :xml => @cobros }
        end


                  
    end

    def filtro_busca_cliente        #
        @cobro    = Cobro.find(params[:id])

         tipo = "documento_numero"          if params[:tipo] == "FACTURA"
         tipo = "numero_ordem"              if params[:tipo] == "ORDEN"

        @cliente  = Cliente.all( :select => ' id,
                                              persona_id,
                                              persona_nome,
                                              liquidacao,
                                              tipo,
                                              data,
                                              vencimento,
                                              venda_id,
                                              documento_nome,
                                              documento_numero,
                                              numero_ordem,
                                              cota,
                                              original,
                                              divida_dolar,
                                              divida_guarani,
                                              cobro_dolar,
                                              cobro_guarani,
                                              diferido,
                                              documento_numero_01,
                                              documento_numero_02',

                                 :conditions => [" persona_id = ? AND #{tipo} LIKE '%#{params[:filtro]}%' AND liquidacao = 0  AND tipo = '1' AND divida_dolar > 0",params[:busca]],:order => 'data,venda_id,cota')
                                 render :layout => false
    end

    def get_cliente                 #
        @cliente =  Persona.find(:first, :conditions =>  [ "nome = ?", params[:persona_busca]])
        return render :text => "<script type='text/javascript'>
                              document.getElementById('cobro_ruc').value                = '#{@cliente.ruc.to_s}';
                              document.getElementById('cobro_persona_id').value         = '#{@cliente.id.to_s}';
                              document.getElementById('cobro_persona_nome').value         = '#{@cliente.nome.to_s}';
                            </script>"
    end

    def cobro_final                 #
        @cobro       = Cobro.find(params[:id])
        @total_cobro_dolar      = CobrosDetalhe.sum( :cobro_dolar,     :conditions => ['cobro_id = ?',params[:id]])
        @total_cobro_guarani    = CobrosDetalhe.sum( :cobro_guarani,   :conditions => ['cobro_id = ?',params[:id]])
        respond_to do |format|
            format.html # show.html.erb
            format.xml  { render :xml => @cobro }
        end
    end

    #METHOD BASE------------------------------------------------------------------

    def index                #

        respond_to do |format|
            format.html # index.html.erb
            format.xml  { render :xml => @cobros }
        end
    end

    def busca                #
        @cobros = Cobro.filtro(params)
        render :layout => false
    end

    def gera_pdf_cobros      #
        @cobro       = Cobro.find(params[:id])
        @cobros_detalhes     = CobrosDetalhe.all( :conditions => ['cobro_id = ?',params[:id]],:order => 'documento_numero')
        @total_cobro_dolar   = CobrosDetalhe.sum(:cobro_dolar, :conditions => ['cobro_id = ?',params[:id]])
        @total_cobro_guarani = CobrosDetalhe.sum(:cobro_guarani, :conditions => ['cobro_id = ?',params[:id]])
        @count               = CobrosDetalhe.count(:id, :conditions => ['cobro_id = ?',params[:id]])


    head =
"                                                                                    #{$empresa_nome}
                                                                                           COBROS
    Fecha : #{@cobro.data.strftime("%d/%m/%Y")}
    Cliente : #{@cobro.persona_nome}

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
     Fecha             Cliente                               Documento                     Orden          N. Doc       Cuota     Facturacion            Total
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
"



         pdf = render :layout => 'layer_relatorios'
              kit = PDFKit.new(pdf,:page_size     => 'A4',
                                   :print_media_type  => true,
                                   :header_font_name  => 'bold',
                                   :header_font_size  => "9" ,
                                   :header_spacing    => "25",
                                   :header_left       => head,
                                   :footer_font_size  => "7",
                                   :footer_right  => "Pagina [page] de [toPage]",
                                   :footer_left   => "MercoSys Pratic - Fecha de la imprecion: #{Time.now.strftime("%d/%m/%Y")} Hora: #{Time.now.strftime("%H:%M:%S")} - Usuario: #{current_user.usuario_nome}",
                                   :margin_top    => '1.15in',
                                   :margin_bottom => '0.25in',
                                   :margin_left   => '0.10in',
                                   :margin_right  => '0.10in')
              kit.stylesheets << RAILS_ROOT + '/public/stylesheets/relatorios.css'
              send_data(kit.to_pdf, :filename => "Detalhes_Cobros.pdf")    end

    def show                 #
        @cobro       = Cobro.find(params[:id])
        @total_cobro_dolar   = CobrosDetalhe.sum(:cobro_dolar, :conditions => ['cobro_id = ?',params[:id]])
        @total_cobro_guarani = CobrosDetalhe.sum(:cobro_guarani, :conditions => ['cobro_id = ?',params[:id]])
        @count               = CobrosDetalhe.count(:id, :conditions => ['cobro_id = ?',params[:id]])
        respond_to do |format|
            format.html # show.html.erb
            format.xml  { render :xml => @cobro }
        end
    end

    def new                  #
        @cobro = Cobro.new

        respond_to do |format|
            format.html # new.html.erb
            format.xml  { render :xml => @cobro }
        end
    end

    def edit                 #
        @cobro = Cobro.find(params[:id])
        session[:pagina] = '1'
    end

    def create               #
        @cobro = Cobro.new(params[:cobro])
        @cobro.usuario_created = current_user.id
        @cobro.unidade_created = current_unidade.id


        respond_to do |format|
            if @cobro.save
                flash[:notice] = 'Cobro was successfully created.'
                format.html { redirect_to(@cobro) }
                format.xml  { render :xml => @cobro, :status => :created, :location => @cobro }
            else
                format.html { render :action => "new" }
                format.xml  { render :xml => @cobro.errors, :status => :unprocessable_entity }
            end
        end
    end

    def update               #
        @cobro = Cobro.find(params[:id])
        @cobro.usuario_created = current_user.id
        @cobro.unidade_created = current_unidade.id

        respond_to do |format|
      
            if @cobro.update_attributes(params[:cobro])
                flash[:notice] = 'Actualizado con Sucesso.'
                if session[:pagina] == '1'
                    format.html { redirect_to(@cobro) }
                    format.xml  { head :ok }
                else
                    format.html { redirect_to(cobros_url) }
                    format.xml  { head :ok }

                end
            else
                format.html { render :action => "edit" }
                format.xml  { render :xml => @cobro.errors, :status => :unprocessable_entity }
            end

        end
    end

    def destroy              #
        @cobro = Cobro.find(params[:id])
        @cobro.destroy

        respond_to do |format|
            format.html { redirect_to(cobros_url) }
            format.xml  { head :ok }
        end
    end
end
