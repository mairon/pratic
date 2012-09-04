class ComprasDocumentosController < ApplicationController
  before_filter :authenticate
  
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

  def get_moeda            #
    @moeda =  Moeda.find(:first, :conditions =>  [ "data = ?", params[:key]])
    return render :text => "<script type='text/javascript'>
                              document.getElementById('compra_cotacao').value       = '#{format("%.2f",@moeda.dolar_venda.to_f)}';
                            </script>"
  end


  def index
    @compras_documentos = ComprasDocumento.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @compras_documentos }
    end
  end

  # GET /compras_documentos/1
  # GET /compras_documentos/1.xml
  def show
    @compras_documento = ComprasDocumento.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @compras_documento }
    end
  end

  # GET /compras_documentos/new
  # GET /compras_documentos/new.xml
  def new
    @compras_documento = ComprasDocumento.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @compras_documento }
    end
  end

  # GET /compras_documentos/1/edit
  def edit
    @compras_documento = ComprasDocumento.find(params[:id])
  end

  # POST /compras_documentos
  # POST /compras_documentos.xml
  def create
    @compras_documento = ComprasDocumento.new(params[:compras_documento])
    @compras_documento.usuario_created = current_user.id
    @compras_documento.unidade_created = current_unidade.id

    respond_to do |format|
      if @compras_documento.save
        flash[:notice] = 'Documento Grabado'
        format.html { redirect_to "/compras/compras_documento/#{@compras_documento.compra_id}" }
        format.xml  { render :xml => @compras_documento, :status => :created, :location => @compras_documento }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @compras_documento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /compras_documentos/1
  # PUT /compras_documentos/1.xml
  def update
    @compras_documento = ComprasDocumento.find(params[:id])
    @compras_documento.usuario_updated = current_user.id
    @compras_documento.unidade_updated = current_unidade.id

    respond_to do |format|
      if @compras_documento.update_attributes(params[:compras_documento])
        flash[:notice] = 'Documento Editado'
        format.html { redirect_to "/compras/compras_documento/#{@compras_documento.compra_id}" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @compras_documento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /compras_documentos/1
  # DELETE /compras_documentos/1.xml
  def destroy
    @compras_documento = ComprasDocumento.find(params[:id])
    @compras_documento.destroy

    respond_to do |format|
     format.html { redirect_to "/compras/compras_documento/#{@compras_documento.compra_id}" }
      format.xml  { head :ok }
    end
  end
end
