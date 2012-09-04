class ProveedoresController < ApplicationController

  def get_persona                 #
    @persona =  Persona.find(:first, :conditions =>  [ "id = ?", params[:campo_persona]])

    return render :text => "<script type='text/javascript'>

                             document.getElementById('busca_persona').value                = '#{@persona.id.to_i}';

                            </script>"
  end

  def relatorio_contas_pagar      #

    @proveedores = Proveedore.relatorio_contas_pagar(params)

    head =
"                                                                                    #{$empresa_nome}
                                                                                            Pagar
    Fecha : #{params[:inicio_faturacao]} hasta #{params[:final_faturacao]}    

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
       Fecha            Cod.            Documento                  Numero    Cuotas     Venc.                   Deuda              Pago           Saldo
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
      send_data(kit.to_pdf, :filename => "Relatorio_Contas_Pagar.pdf")

    else

      respond_to do |format|
        format.xls {
          xls = render :action => "relatorio_contas_pagar", :layout => false

          kit = PDFKit.new(xls,
                           :encoding => 'UTF-8')
          kit.stylesheets << RAILS_ROOT + '/public/stylesheets/relatorios.css'

          send_data(xls,:filename => 'Relatorio_Contas_Pagar.xls')
        }
      end
    end
  end

  #METHODS BASE ----------------------------------------------------------------

  def index                       #

    respond_to do |format|
      format.html # index.html.erb

    end
  end

  def show                        #
    @proveedore = Proveedore.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @proveedore }
    end
  end

  def new                         #
    @proveedore = Proveedore.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @proveedore }
    end
  end

  def edit                        #
    @proveedore = Proveedore.find(params[:id])
  end

  def create                      #
    @proveedore = Proveedore.new(params[:proveedore])

    respond_to do |format|
      if @proveedore.save
        flash[:notice] = 'Proveedore was successfully created.'
        format.html { redirect_to(@proveedore) }
        format.xml  { render :xml => @proveedore, :status => :created, :location => @proveedore }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @proveedore.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update                      #
    @proveedore = Proveedore.find(params[:id])

    respond_to do |format|
      if @proveedore.update_attributes(params[:proveedore])
        flash[:notice] = 'Proveedore was successfully updated.'
        format.html { redirect_to(@proveedore) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @proveedore.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy                     #
    @proveedore = Proveedore.find(params[:id])
    @proveedore.destroy

    respond_to do |format|
      format.html { redirect_to(proveedores_url) }
      format.xml  { head :ok }
    end
  end
end
