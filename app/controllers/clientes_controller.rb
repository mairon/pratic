class ClientesController < ApplicationController

    def busca_cliente               #
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
                                              cota,
                                              original,
                                              divida_dolar,
                                              divida_guarani,
                                              cobro_dolar,
                                              cobro_guarani,
                                              diferido,
                                              documento_numero_01,
                                              documento_numero_02',
            :conditions => [" persona_id = ? AND documento_numero LIKE '%#{params[:filtro]}%' AND liquidacao != 2  AND tipo = '1'",params[:busca]],:order => 'data,venda_id,cota')

        respond_to do |format|
            format.html # index.html.erb
            format.xml  { render :xml => @cobros }
        end
    end

    def filtro_busca_cliente        #
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
                                              cota,
                                              original,
                                              divida_dolar,
                                              divida_guarani,
                                              cobro_dolar,
                                              cobro_guarani,
                                              diferido,
                                              documento_numero_01,
                                              documento_numero_02',
            :conditions => [" persona_id = ? AND documento_numero LIKE '%#{params[:filtro]}%' AND liquidacao != 2  AND tipo = '1'",params[:busca]],:order => 'data,venda_id,cota')

    end

    def get_persona                 #
        @persona =  Persona.find(:first, :conditions =>  [ "id = ?", params[:campo_persona]])
        return render :text => "<script type='text/javascript'>
                                     document.getElementById('busca_persona').value                = '#{@persona.id.to_i}';
                            </script>"
    end

    def relatorio_contas_receber    #
        if params[:detalhe].to_s == "2"
            @clientes       = Cliente.relatorio_contas_receber_general(params)


        head =
        "                                                                                       #{$empresa_nome}
                                                                                       Cuentas a Receber
    Todos


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
         Cod.                    Cliente                                                                                                      Total
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        "
        else
            @clientes       = Cliente.relatorio_contas_receber(params)
            @saldo_anterior = Cliente.relatorio_contas_receber_saldo_anterior(params)
            unless params[:recibo].blank?
                recibo = "- Recibo N.: #{params[:recibo]}"
            end

            if params[:busca]["persona"].blank?
               cliente = 'Todos'
            else
               persona = Persona.find_by_id(params[:busca]["persona"].to_i);
               cliente ="#{persona.nome}"
            end

            if params[:filtro] == '0'
                filtro = 'En Abertas'
            elsif params[:filtro] == '1'
                filtro = 'Canceladas'
            else
                filtro = 'Todos'
            end
        head =
        "                                                                                       #{$empresa_nome}
                                                                                       Cuentas a Receber
   - Fecha : #{params[:inicio_faturacao]} hasta #{params[:final_faturacao]}                                                                                                          - Filtro : #{filtro}
   - Cliente : #{cliente}
   #{recibo}
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
      Fecha        Cod.  Doc.   Recibo                    Numero           Cheq. Cuota   Venc.                  Delda              Pago         Saldo
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        "
        end
        

        if params[:tipo].to_s == "0"
            pdf = render :layout => 'layer_relatorios'
            kit = PDFKit.new(pdf,:page_size        => 'A4',
                :print_media_type  => true,
                :header_font_name  => 'bold',
                :header_font_size  => "9" ,
                :header_spacing    => "25",
                :header_left       => head,
                :footer_font_size  => "7",
                :footer_right  => "Pagina [page] de [toPage]",
                :footer_left   => "MercoSys Pratic - Fecha de la imprecion: #{Time.now.strftime("%d/%m/%Y")} Hora: #{Time.now.strftime("%H:%M:%S")} - Usuario: #{current_user.usuario_nome}",
                :margin_top    => '1.20in',
                :margin_bottom => '0.25in',
                :margin_left   => '0.10in',
                :margin_right  => '0.10in')
            kit.stylesheets << RAILS_ROOT + '/public/stylesheets/relatorios.css'
            send_data(kit.to_pdf, :filename => "Relatorio_Contas_Receber.pdf")

        else

            respond_to do |format|
                format.xls {
                    xls = render :action => "relatorio_contas_receber", :layout => false

                    kit = PDFKit.new(xls,
                        :encoding => 'UTF-8')
                    kit.stylesheets << RAILS_ROOT + '/public/stylesheets/relatorios.css'

                    send_data(xls,:filename => 'Relatorio_Contas_Receber.xls')
                }
            end
        end

    end
  
    #METHOS BASE------------------------------------------------------------------

    def index                       #
        @clientes = Cliente.find(:all)

        respond_to do |format|
            format.html # index.html.erb
            format.xml  { render :xml => @clientes }
        end
    end

    def show                        #
        @cliente = Cliente.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.xml  { render :xml => @cliente }
        end
    end

    def new                         #
        @cliente = Cliente.new

        respond_to do |format|
            format.html # new.html.erb
            format.xml  { render :xml => @cliente }
        end
    end

    def edit                        #
        @cliente = Cliente.find(params[:id])
    end

    def create                      #
        @cliente = Cliente.new(params[:cliente])

        respond_to do |format|
            if @cliente.save
                flash[:notice] = 'Cliente was successfully created.'
                format.html { redirect_to(@cliente) }
                format.xml  { render :xml => @cliente, :status => :created, :location => @cliente }
            else
                format.html { render :action => "new" }
                format.xml  { render :xml => @cliente.errors, :status => :unprocessable_entity }
            end
        end
    end

    def update                      #
        @cliente = Cliente.find(params[:id])

        respond_to do |format|
            if @cliente.update_attributes(params[:cliente])
                flash[:notice] = 'Cliente was successfully updated.'
                format.html { redirect_to(@cliente) }
                format.xml  { head :ok }
            else
                format.html { render :action => "edit" }
                format.xml  { render :xml => @cliente.errors, :status => :unprocessable_entity }
            end
        end
    end

    def destroy                     #
        @cliente = Cliente.find(params[:id])
        @cliente.destroy

        respond_to do |format|
            format.html { redirect_to(clientes_url) }
            format.xml  { head :ok }
        end
    end
end
