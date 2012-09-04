class FinancasController < ApplicationController

  def relatorio_financas          #

    @financas         = Financa.relatorio_financas(params)
    @financas_aterior = Financa.relatorio_financas_saldo_anterior(params)
    head =
"                                                                                    #{$empresa_nome}
                                                                                      EXTRACTO CAJA
    Fecha : #{params[:inicio]} hasta #{params[:final]}
    

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Codigo   Fecha               Concepto                             Cuenta                    Documento                 Entrada            Salida           Saldo
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
      send_data(kit.to_pdf, :filename => "Relatorio_Financas.pdf")

    else

      respond_to do |format|
        format.xls {
          xls = render :action => "relatorio_financas", :layout => false

          kit = PDFKit.new(xls,
                           :encoding => 'UTF-8')
          kit.stylesheets << RAILS_ROOT + '/public/stylesheets/relatorios.css'

          send_data(xls,:filename => 'Relatorio_Financas.xls')
        }
      end
    end
  end

  def index                       #
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @financas }
    end
  end

  def extrato_bancario            #
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @financas }
    end
  end

  def resultado_extrato_bancario  #

    @financas         = Financa.relatorio_financas(params)
    @financas_aterior = Financa.relatorio_financas_saldo_anterior(params)
    head =
"                                                                                    #{$empresa_nome}
                                                                                  EXTRACTO BANCARIO
    Fecha : #{params[:inicio]} hasta #{params[:final]}


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  Fecha                  Concepto                      Cuenta         N. Cheque      Documento                    Entrada            Salida           Saldo
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
      send_data(kit.to_pdf, :filename => "Relatorio_Financas.pdf")

    else

      respond_to do |format|
        format.xls {
          xls = render :action => "relatorio_financas", :layout => false

          kit = PDFKit.new(xls,
                           :encoding => 'UTF-8')
          kit.stylesheets << RAILS_ROOT + '/public/stylesheets/relatorios.css'

          send_data(xls,:filename => 'Relatorio_Financas.xls')
        }
      end
    end
  end

  def show                        #
    @financa = Financa.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @financa }
    end
  end

  def new                         #
    @financa = Financa.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @financa }
    end
  end

  def edit                        #
    @financa = Financa.find(params[:id])
  end

  def create                      #
    @financa = Financa.new(params[:financa])

    respond_to do |format|
      if @financa.save
        flash[:notice] = 'Financa was successfully created.'
        format.html { redirect_to(@financa) }
        format.xml  { render :xml => @financa, :status => :created, :location => @financa }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @financa.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update                      #
    @financa = Financa.find(params[:id])

    respond_to do |format|
      if @financa.update_attributes(params[:financa])
        flash[:notice] = 'Financa was successfully updated.'
        format.html { redirect_to(@financa) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @financa.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy                     #
    @financa = Financa.find(params[:id])
    @financa.destroy

    respond_to do |format|
      format.html { redirect_to(financas_url) }
      format.xml  { head :ok }
    end
  end
end
