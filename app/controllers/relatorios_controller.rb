class RelatoriosController < ApplicationController

    #RELATORIOS CONTABEIS========================================================#

    def resultado_livro_compra                      #

        @compra = Relatorios.livro_compra(params)

        if params[:tipo].to_s == "0"
            pdf = render :layout => 'layer_relatorios'
            kit = PDFKit.new(pdf,:orientation   => 'Landscape',
                :page_size     => 'A4',
                :footer_right  => "Pagina [page] de [toPage]",
                :margin_top    => '0.20in',
                :margin_bottom  => '0.25in',
                :margin_left   => '0.10in',
                :margin_right  => '0.10in')
            kit.stylesheets << RAILS_ROOT + '/public/stylesheets/relatorios.css'
            send_data(kit.to_pdf, :filename => "Libro_compra.pdf")

        else

            respond_to do |format|
                format.xls {
                    xls = render :layout => false

                    kit = PDFKit.new(xls,
                        :encoding => 'UTF-8')
                    kit.stylesheets << RAILS_ROOT + '/public/stylesheets/relatorios.css'

                    send_data(xls,:filename => 'Libro_compra.xls')
                }
            end
        end


    end

    def resultado_livro_venda                       #

        @venda = Relatorios.livro_venda(params)

        if params[:tipo].to_s == "0"
            pdf = render :layout => 'layer_relatorios'
            kit = PDFKit.new(pdf,:orientation   => 'Landscape',
                :page_size     => 'A4',
                :footer_right  => "Pagina [page] de [toPage]",
                :margin_top    => '0.20in',
                :margin_bottom  => '0.25in',
                :margin_left   => '0.10in',
                :margin_right  => '0.10in')

            kit.stylesheets << RAILS_ROOT + '/public/stylesheets/relatorios.css'
            send_data(kit.to_pdf, :filename => "Libro_Venta_#{params[:mes]}/#{params[:ano]}.pdf")

        else

            respond_to do |format|
                format.xls {
                    xls = render :layout => false

                    kit = PDFKit.new(xls,
                        :encoding => 'UTF-8')

                    kit.stylesheets << RAILS_ROOT + '/public/stylesheets/relatorios.css'
                    send_data(xls,:filename => "Libro_Venta_#{params[:mes]}/#{params[:ano]}.xls")
                }
            end
        end



    end

    def resultado_livro_diario                      #

        head =
        "                                                                                    #{$empresa_nome}
                                                                                        LIBRO DIARIO
    Mes : #{params[:mes]} Año #{params[:ano]}


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Lanz.         Fecha          Documento      Numero    Codigo         Descripcion                                             Debe                  Haber
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        "


        @diario = Relatorios.livro_diario(params)

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
                :margin_top    => '1.20in',
                :margin_bottom => '0.25in',
                :margin_left   => '0.10in',
                :margin_right  => '0.10in')

            kit.stylesheets << RAILS_ROOT + '/public/stylesheets/relatorios.css'
            send_data(kit.to_pdf, :filename => "Libro_diario.pdf")

        else

            respond_to do |format|
                format.xls {
                    xls = render :layout => false

                    kit = PDFKit.new(xls,
                        :encoding => 'UTF-8')

                    kit.stylesheets << RAILS_ROOT + '/public/stylesheets/relatorios.css'
                    send_data(xls,:filename => 'Libro_diario.xls')
                }
            end
        end



    end

    def resultado_livro_mayor                       #

        head =
        "                                                                                    #{$empresa_nome}
                                                                                        LIBRO MAYOR
    Fecha : #{params[:inicio]} Hasta #{params[:final]}
    Contabilidade : #{params[:codigo]}

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Fecha                     Proceso               N. Proceso        Documento                N. Documento             Debe            Haber
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        "


        @diario = Relatorios.livro_mayor(params)

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
                :margin_top    => '1.20in',
                :margin_bottom => '0.25in',
                :margin_left   => '0.10in',
                :margin_right  => '0.10in')

            kit.stylesheets << RAILS_ROOT + '/public/stylesheets/relatorios.css'
            send_data(kit.to_pdf, :filename => "Libro_Mayor.pdf")

        else

            respond_to do |format|
                format.xls {
                    xls = render :layout => false

                    kit = PDFKit.new(xls,
                        :encoding => 'UTF-8')

                    kit.stylesheets << RAILS_ROOT + '/public/stylesheets/relatorios.css'
                    send_data(xls,:filename => 'Libro_Mayor.xls')
                }
            end
        end



    end

    def resultado_generar_acientos_contables        #

        @compra = Relatorios.generar_acientos_contables(params)

        render :layout => false
    end

    def resultado_balance                           #

        @balance = Relatorios.balance(params)


        head =
        "                                                                                    #{$empresa_nome}
                                                                               Balance de Sumas y Sueldos
    Mes : #{params[:mes]} Año #{params[:ano]}


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Codigo               Descripcion                                                                Anterior                Debe                  Haber                 Saldo
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
                :margin_top    => '1.25in',
                :margin_bottom => '0.35in',
                :margin_left   => '0.10in',
                :margin_right  => '0.10in')

            kit.stylesheets << RAILS_ROOT + '/public/stylesheets/relatorios.css'
            send_data(kit.to_pdf, :filename => "Libro_diario.pdf")

        else

            respond_to do |format|
                format.xls {
                    xls = render :layout => false

                    kit = PDFKit.new(xls,
                        :encoding => 'UTF-8')

                    kit.stylesheets << RAILS_ROOT + '/public/stylesheets/relatorios.css'
                    send_data(xls,:filename => 'Libro_diario.xls')
                }
            end
        end



    end

    def resultado_balance_general                   #

        @balance = Relatorios.balance_general(params)


        head =
        "                                                                                    #{$empresa_nome}
                                                                                     Balance General
    Mes : #{params[:mes]} Año #{params[:ano]}
        "


        if params[:tipo].to_s == "0"
            pdf = render :layout => 'layer_relatorios'
            kit = PDFKit.new(pdf,:page_size     => 'A4',
                :print_media_type  => true,
                :header_font_name  => 'bold',
                :header_font_size  => "9" ,
                :header_spacing    => "9",
                :header_left       => head,
                :footer_font_size  => "7",
                :footer_right  => "Pagina [page] de [toPage]",
                :margin_top    => '0.60in',
                :margin_bottom => '0.35in',
                :margin_left   => '0.10in',
                :margin_right  => '0.10in')

            kit.stylesheets << RAILS_ROOT + '/public/stylesheets/relatorios.css'
            send_data(kit.to_pdf, :filename => "Libro_diario.pdf")

        else

            respond_to do |format|
                format.xls {
                    xls = render :layout => false

                    kit = PDFKit.new(xls,
                        :encoding => 'UTF-8')

                    kit.stylesheets << RAILS_ROOT + '/public/stylesheets/relatorios.css'
                    send_data(xls,:filename => 'Libro_diario.xls')
                }
            end
        end



    end

    #=============================================================================#

    def resultado_relatorio_fechamento_turno        #
        @fechamento_turnos = Relatorios.fechamento_turno(params)

        head =
        "                                                                                    #{$empresa_nome}
                                                                                       Cierre de Turno
    Fecha : #{params[:inicio]} hasta #{params[:final]}


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    Fecha             Turno                                                                 Inicio                                       Cierre                                    Total
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
            send_data(kit.to_pdf, :filename => "Cierre_Turno.pdf")

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

    def resultado_relatorio_vendas_do_dia           #
        if params[:status] == "0"
            clase   = "AND VP.CLASE_ID = #{ params[:busca]['clase'] }" unless  params[:busca]['clase'].blank?
            grupo   = "AND VP.GRUPO_ID = #{ params[:busca]['grupo'] }" unless  params[:busca]['grupo'].blank?
            produto = "AND VP.PRODUTO_ID = #{ params[:busca]['produto'] }" unless  params[:busca]['produto'].blank?
            turno   = "AND V.TURNO_ID = #{ params[:busca]['turno'] }" unless  params[:busca]['turno'].blank?
            sql = "SELECT VP.ID,
                          VP.DATA,
                          VP.VENDA_ID,
                          VP.CLASE_ID,
                          VP.GRUPO_ID,
                          VP.PRODUTO_ID,
                          VP.PRODUTO_NOME,
                          VP.QUANTIDADE,
                          VP.TOTAL_GUARANI                        
                          FROM VENDAS_PRODUTOS VP
                          INNER JOIN VENDAS V
                          ON V.ID = VP.VENDA_ID                           
                          WHERE
                               VP.DATA BETWEEN '#{params[:inicio]}' AND '#{params[:final]}' #{clase} #{grupo} #{produto} #{turno}
   "
            @vendas_produto = VendasProduto.find_by_sql(sql)

        head =
        "                                                                                    #{$empresa_nome}
                                                                                           VENTAS
    Fecha : #{params[:inicio]} hasta #{params[:final]}


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  Cod.                        Fecha               Tipo                   Producto                                                                Cantidad           Total Gs.
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        "


     elsif params[:status] == "2"
            @vendas_produto = Relatorios.vendas_resumo_produtos(params)

        head =
        "                                                                                    #{$empresa_nome}
                                                                                           VENTAS
    Fecha : #{params[:inicio]} hasta #{params[:final]}


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  Cod.     Producto												                                                                                              Cantidad                Total Gs.
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        "


        else
            turno = "turno_id = #{ params[:busca]['turno'] } AND " unless  params[:busca]['turno'].blank?
            vend = "vendedor_id = #{ params[:busca]['vend'] } AND " unless  params[:busca]['vend'].blank?
            @vendas_contado = Venda.all(:conditions => ["data >= ? AND data <= ? AND #{turno} #{vend} tipo = 0 AND tipo_ordem = 0",params[:inicio],params[:final]],:order => 'data,id')
            @vendas_credito = Venda.all(:conditions => ["data >= ? AND data <= ? AND #{turno} #{vend} tipo = 1 AND tipo_ordem = 0",params[:inicio],params[:final]],:order => 'data,id')
            @vendas_ordem   = Venda.all(:conditions => ["data >= ? AND data <= ? AND #{turno} #{vend} tipo = 1 AND tipo_ordem = 1",params[:inicio],params[:final]],:order => 'data,id')

        head =
        "                                                                                    #{$empresa_nome}
                                                                                           VENTAS
    Fecha : #{params[:inicio]} hasta #{params[:final]}
    Turno : #{params[:busca]['turno']}

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  Cod.      Fecha        Turno       Vendedor           Cliente                                                  Factura                   Cantidad     Total Gs.
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        "

        end


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
            send_data(kit.to_pdf, :filename => "Ventas.pdf")

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

    def resultado_relatorio_compra                  #

        @compras = Relatorios.relatorio_compras(params)
    
        @compras_anterior = Relatorios.relatorio_compras_anterior(params)
    
        head =
        "                                                                                    #{$empresa_nome}
                                                                                          COMPRAS
    Fecha : #{params[:inicio]} hasta #{params[:final]}


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    Fecha                       Proveedor                                                 Factura                                                     Cantidad          Total Gs.
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

    def resultado_relatorio_cobros                  #
        
        if $empresa == 'E01'
            @cobros = Relatorios.relatorio_cobros_detalhes(params)

            head =
            "                                                                                    #{$empresa_nome}
                                                                                          COBROS
    Fecha : #{params[:inicio]} hasta #{params[:final]}


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
     Cod.       Fecha                  Cliente                                                 Orden             Factura                 Facturacion          Total Gs.
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
            "

        else
            @cobros = Relatorios.relatorio_cobros(params)
            if params[:filtro].to_s == '1'
                ft = 'Factura'
            end
            head =
            "                                                                                    #{$empresa_nome}
                                                                                          COBROS
    Fecha : #{params[:inicio]} hasta #{params[:final]}


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
     Cod.       Fecha                  Cliente                                                                 Recibo         #{ft}                                Total Gs.
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
            "
        end

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

    def resultado_relogio_ponto                     #

        @relogio = Relatorios.relatorio_relogio_ponto(params)

        head =
        "                                                                                    #{$empresa_nome}
                                                                                        Relogio Punto
    Fecha : #{params[:inicio]} hasta #{params[:final]}


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
     Cod.       Fecha                  Empleado                                                 Inicio             Cierre                 Total
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
            send_data(kit.to_pdf, :filename => "Relogio_Punto.pdf")

        else

            respond_to do |format|
                format.xls {
                    xls = render :action => "relatorio_stock", :layout => false

                    kit = PDFKit.new(xls,
                        :encoding => 'UTF-8')
                    kit.stylesheets << RAILS_ROOT + '/public/stylesheets/relatorios.css'

                    send_data(xls,:filename => 'Relogio_Punto.xls')
                }
            end
        end

    end
end
