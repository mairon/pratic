class StocksController < ApplicationController

    def stock_inicial                              #

        respond_to do |format|
            format.html # index.html.erb
            format.xml  { render :xml => @diarios }
        end
    end

    def print_stock_final                          #
        @stock = Stock.all( :conditions => ["tabela = 'STOCK FINAL'"])
        pdf = render :layout => 'layer_relatorios'
        kit = PDFKit.new(pdf,:page_size     => 'A4',
            :footer_right  => "Pagina [page] de [toPage]",
            :margin_top    => '0.20in',
            :margin_bottom  => '0.25in',
            :margin_left   => '0.10in',
            :margin_right  => '0.10in')
      kit.stylesheets << RAILS_ROOT + '/public/stylesheets/relatorios.css'
      send_data(kit.to_pdf, :filename => "Stock_Final.pdf")

    end

    def get_produto_inicial                        #
        @produto =  Produto.find(:first, :conditions =>  [ "barra = ?", params[:cod]])
        custo =  ComprasProduto.find(:last,:conditions => ["produto_id = ?",@produto.id])

        return render :text => "<script type='text/javascript'>
                                document.getElementById('stock_produto_id').value             = '#{@produto.id.to_i}';
                            </script>"
    end

    def dinamic_busca_stock_inicial                #

        @stocks = Stock.stock_inicial(params)

        render :layout => false
    end

    def dinamic_busca_stock_final                  #

        @stocks = Stock.stock_final(params)

        render :layout => false
    end

    def get_clase                                  #
        @clase =  Clase.find(:first, :conditions =>  [ "id = ?", params[:campo_clase]])
        return render :text => "<script type='text/javascript'>
                    document.getElementById('busca_clase').value                = '#{@clase.id.to_i}';
                            </script>"
    end

    def get_moeda                                  #
        @moeda =  Moeda.find(:first,:select => 'dolar_venda', :conditions =>  [ "data = ?", params[:key]])
        return render :text => "<script type='text/javascript'>
                               document.getElementById('stock_cotacao').value       = '#{format("%.2f",@moeda.dolar_venda.to_f)}';
                            </script>"
    end

    def get_grupo                                  #
        @grupo =  Grupo.find(:first, :conditions =>  [ "id = ?", params[:campo_grupo]])
        return render :text => "<script type='text/javascript'>
                    document.getElementById('busca_grupo').value                = '#{@grupo.id.to_i}';
                            </script>"
    end

    def get_produto                                #
        @produto =  Produto.find(:first, :conditions =>  [ "fabricante_cod = ?", params[:campo_produto]])
        return render :text => "<script type='text/javascript'>
                    document.getElementById('busca_produto').value                = '#{@produto.id.to_i}';
                            </script>"
    end

    def relatorio_consumo_bomba                    #

        respond_to do |format|
            format.html # show.html.erb
        end
    end

    def resultado_relatorio_consumo_bomba          #
        cond = "data >= '#{params[:inicio]}' AND data <= '#{params[:final]}' AND tipo = 1"
        cond = cond + " AND turno_created = #{params[:busca]["turno"]}" if params[:busca]["turno"].to_s != ""
        cond = cond + " AND produto_id = #{params[:busca]["bomba"]}" if params[:busca]["bomba"].to_s != ""
        @stocks = Stock.all(:conditions => cond, :order => 'status,data')
        respond_to do |format|
            format.html # show.html.erb
            format.xls  { render :action => "resultado_relatorio_consumo_bomba", :layout => false }
            format.pdf  { render :action => "resultado_relatorio_consumo_bomba", :layout => false }
        end

    end

    def index                                      #

        respond_to do |format|
            format.html # show.html.erb
        end
    end

    def resultado_rentabilidade                    #

        @stocks = Stock.rentabilidade( params )


        head =
        "                                                                                    #{$empresa_nome}
                                                                                       Rentabilidad


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
     Cod.                      Productos                                                                     Cantidad     Venta         Costo         Renta.   Margen%
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        "

        if params[:tipo].to_s == "0"
            pdf = render :layout => 'layer_relatorios'
            kit = PDFKit.new(pdf,:page_size     => 'A4',
                :print_media_type  => true,
                :header_font_name  => 'bold',
                :header_font_size  => "9" ,
                :header_spacing    => "25",
                :header_left       => head,
                :footer_font_size  => "7",
                :footer_right  => "Pagina [page] de [toPage]",
                :footer_left   => "MercoSys Enterprise - Fecha de la imprecion: #{Time.now.strftime("%d/%m/%Y")} Hora: #{Time.now.strftime("%H:%M:%S")} - Usuario: #{current_user.usuario_nome}",
                :margin_top    => '1.20in',
                :margin_bottom => '0.25in',
                :margin_left   => '0.10in',
                :margin_right  => '0.10in')
            kit.stylesheets << RAILS_ROOT + '/public/stylesheets/relatorios.css'
            send_data(kit.to_pdf, :filename => "Ficha_Stock.pdf")

        else

            respond_to do |format|
                format.xls {
                    xls = render :action => "resultado_rentabilidade", :layout => false

                    kit = PDFKit.new(xls,
                        :encoding => 'UTF-8')
                    kit.stylesheets << RAILS_ROOT + '/public/stylesheets/relatorios.css'

                    send_data(xls,:filename => 'rentabilidade.xls')
                }
            end
        end

    end
    
    
    
    def resultado_iventario                        #

        @stocks = Stock.resultaro_iventario( params )


        head =
        "                                                                                               #{$empresa_nome}
                                                                                                      Inventario


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
     Cod.                      Productos                                                                    Ant.    Entrada   Saida      Saldo      Precio Venta       Costo        Total.
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        "

        head_consulta =
        "                                                                                  #{$empresa_nome}
                                                                                          Inventario


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
     Cod.                      Productos                                                                            Saldo                      Observacion
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        "


        if params[:tipo].to_s == "0"
            pdf = render :layout => 'layer_relatorios'
            kit = PDFKit.new(pdf,:page_size     => 'A4',
                :print_media_type  => true,
                :header_font_name  => 'bold',
                :header_font_size  => "8" ,
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
            send_data(kit.to_pdf, :filename => "Ficha_Stock.pdf")


        elsif params[:tipo].to_s == "2"
            pdf = render :layout => 'layer_relatorios'
            kit = PDFKit.new(pdf,:page_size     => 'A4',
                :print_media_type  => true,
                :header_font_name  => 'bold',
                :header_font_size  => "9" ,
                :header_spacing    => "25",
                :header_left       => head_consulta,
                :footer_font_size  => "7",
                :footer_right  => "Pagina [page] de [toPage]",
                :footer_left   => "MercoSys Pratic - Fecha de la imprecion: #{Time.now.strftime("%d/%m/%Y")} Hora: #{Time.now.strftime("%H:%M:%S")} - Usuario: #{current_user.usuario_nome}",
                :margin_top    => '1.20in',
                :margin_bottom => '0.25in',
                :margin_left   => '0.10in',
                :margin_right  => '0.10in')
            kit.stylesheets << RAILS_ROOT + '/public/stylesheets/relatorios.css'
            send_data(kit.to_pdf, :filename => "Ficha_Stock.pdf")


        else

            respond_to do |format|
                format.xls {
                    xls = render :layout => false

                    kit = PDFKit.new(xls,
                        :encoding => 'UTF-8')
                    kit.stylesheets << RAILS_ROOT + '/public/stylesheets/relatorios.css'

                    send_data(xls,:filename => 'Cierre_Turno.xls')
                }
            end
        end

    end

    def relatorio_stock                            #

        @stocks = Stock.relatorio_ficha_stock(params)
        @saldo_anterior = Stock.relatorio_ficha_stock_saldo_anterio( params )

        #VERIFICA SE  TEM CLASE E IMPRIME
        if params[:busca]["clase"].blank?
            clase = 'Todos'
        else
            clase = params[:busca]["clase"]
        end
        #VERIFICA SE  TEM GRUPO E IMPRIME
        if params[:busca]["grupo"].blank?
            grupo = 'Todos'
        else
            grupo = params[:busca]["grupo"]
        end

        #VERIFICA SE  TEM PRODUTO E IMPRIME
        if params[:busca]["produto"].blank?
            produto = 'Todos'
        else
            produto = params[:busca]["produto"]
        end

        #VERIFICA SE  TEM DEPOSITO E IMPRIME
        if params[:busca]["deposito"].blank?
            deposito = 'Todos'
        else
            deposito = params[:busca]["deposito"]
        end

        head =
        "                                                                                    #{$empresa}
                                                                                       FICHA STOCK
    Fecha : #{params[:inicio]} hasta #{params[:final]}
    Clase : #{clase}   Grupo : #{grupo}  Produto : #{produto}   Deposito : #{deposito}

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
       Fecha                 Cod.        Status       Deposito                          Produto                           Entrada          Salida           Saldo
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        "

        if params[:tipo].to_s == "0"
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
                :margin_top    => '1.20in',
                :margin_bottom => '0.25in',
                :margin_left   => '0.10in',
                :margin_right  => '0.10in')
            kit.stylesheets << RAILS_ROOT + '/public/stylesheets/relatorios.css'
            send_data(kit.to_pdf, :filename => "Ficha_Stock.pdf")

        else

            respond_to do |format|
                format.xls {
                    xls = render :action => "relatorio_stock", :layout => false

                    kit = PDFKit.new(xls,
                        :encoding => 'UTF-8')
                    kit.stylesheets << RAILS_ROOT + '/public/stylesheets/relatorios.css'

                    send_data(xls,:filename => 'Ficha_Stock.xls')
                }
            end
        end

    end

    def relatorio_stock_print                      #
        cond = "data >= '#{params[:inicio]}' AND data <= '#{params[:final]}'"
        cond = cond + " AND produto_id = #{params[:busca]["produto"]}" if params[:busca]["produto"].to_s != ""
        cond = cond + " AND produto_id = #{params[:busca]["clase"]}" if params[:busca]["clase"].to_s != ""
        cond = cond + " AND produto_id = #{params[:busca]["grupo"]}" if params[:busca]["grupo"].to_s != ""
        @stocks = Stock.all(:conditions => cond, :order => 'status,data')
        render :layout => false
    end

    def show                                       #
        @stock = Stock.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.xml  { render :xml => @stock }
        end
    end

    def new                                        #
        @stock = Stock.new

        respond_to do |format|
            format.html # new.html.erb
            format.xml  { render :xml => @stock }
        end
    end

    def new_st_final                               #
        @stock = Stock.new
        @stock_qt_sum = Stock.sum(:saida, :conditions => ["tabela = 'STOCK FINAL'"])
        @stock_count  = Stock.count(:id, :conditions => ["tabela = 'STOCK FINAL'"])
        respond_to do |format|
            format.html # new.html.erb
            format.xml  { render :xml => @stock }
        end
    end

    def edit_st_final                              #
        @stock = Stock.find(params[:id])
    end

    def edit                              #
        @stock = Stock.find(params[:id])
    end


    def create                                     #
        @stock = Stock.new(params[:stock])

        respond_to do |format|
            if @stock.save
                flash[:notice] = 'Grabado Con Sucesso!'
                if @stock.status == 1
                    format.html { redirect_to('/stocks/new_st_final') }
                else
                    format.html { redirect_to('/stocks/new') }
                end
            else
                format.html { render :action => "new" }
            end
        end
    end

    def update                                     #
        @stock = Stock.find(params[:id])

        respond_to do |format|
            if @stock.update_attributes(params[:stock])
                flash[:notice] = 'Actualizado con Sucesso'
                if @stock.status == 1
                    format.html { redirect_to('/stocks/new_st_final') }
                else
                    format.html { redirect_to('/stocks/new') }
                end
            else
                format.html { render :action => "edit" }
            end
        end
    end

    def destroy                                    #
        @stock = Stock.find(params[:id])
        @stock.destroy

        respond_to do |format|
            if @stock.status == 1
                format.html { redirect_to(stock_final_stocks_url) }
            else
                format.html { redirect_to(stocks_url) }
            end

            format.html { redirect_to(stocks_url) }
            format.xml  { head :ok }
        end
    end
end
