class ComprasProdutosController < ApplicationController
before_filter :authenticate

def get_produto            #
        @produto =  Produto.find(:first, :conditions =>  [ "id = ?", params[:key]])
        return render :text => "<script type='text/javascript'>
                              document.getElementById('compras_produto_produto_nome').value       = '#{@produto.nome.to_s}';
                              document.getElementById('compras_produto_iva_taxa').value           = '#{@produto.taxa.to_i}';
                              document.getElementById('compras_produto_produto_id').value         = '#{@produto.id.to_i}';
                              document.getElementById('compras_produto_codigo').value             = '#{@produto.codigo.to_s}';
                              document.getElementById('compras_produto_fabricante_cod').value     = '#{@produto.fabricante_cod.to_s}';
                            </script>"
    end

def index
    @compras_produtos = ComprasProduto.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @compras_produtos }
    end
  end

  # GET /compras_produtos/1
  # GET /compras_produtos/1.xml
  def show
    @compras_produto = ComprasProduto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @compras_produto }
    end
  end

  # GET /compras_produtos/new
  # GET /compras_produtos/new.xml
  def new
    @compras_produto = ComprasProduto.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @compras_produto }
    end
  end

  # GET /compras_produtos/1/edit
  def edit
    @compras_produto = ComprasProduto.find(params[:id])
  end

  # POST /compras_produtos
  # POST /compras_produtos.xml
  def create
    @compras_produto = ComprasProduto.new(params[:compras_produto])
    @compras_produto.usuario_created = current_user.id
    @compras_produto.unidade_created = current_unidade.id

    respond_to do |format|
      if @compras_produto.save
        flash[:notice] = 'Producto Adicionado'
        format.html { redirect_to "/compras/show/#{@compras_produto.compra_id}" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @compras_produto.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /compras_produtos/1
  # PUT /compras_produtos/1.xml
  def update
    @compras_produto = ComprasProduto.find(params[:id])
    @compras_produto.usuario_updated = current_user.id
    @compras_produto.unidade_updated = current_unidade.id

    respond_to do |format|
      if @compras_produto.update_attributes(params[:compras_produto])
        flash[:notice] = 'Producto Editado'
        format.html { redirect_to "/compras/show/#{@compras_produto.compra_id}" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @compras_produto.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /compras_produtos/1
  # DELETE /compras_produtos/1.xml
  def destroy
    @compras_produto = ComprasProduto.find(params[:id])
    @compras_produto.destroy

    respond_to do |format|
      format.html { redirect_to "/compras/show/#{@compras_produto.compra_id}" }
      format.xml  { head :ok }
    end
  end

end
