class ProdutosController < ApplicationController
  def get_clase                #
    @clase =  Clase.find(:first, :conditions =>  [ "id = ?", params[:campo_clase]])
    return render :text => "<script type='text/javascript'>
                    document.getElementById('busca_clase').value                = '#{@clase.id.to_i}';
                            </script>"
  end

  def get_grupo                #
    @grupo =  Grupo.find(:first, :conditions =>  [ "id = ?", params[:campo_grupo]])
    return render :text => "<script type='text/javascript'>
                    document.getElementById('busca_grupo').value                = '#{@grupo.id.to_i}';
                            </script>"
  end


  def get_moeda                    #
    @moeda =  Moeda.find(:first, :conditions =>  [ "data = ?", params[:key]])
    return render :text => "<script type='text/javascript'>
                              document.getElementById('produto_cotacao').value       = '#{format("%.2f",@moeda.dolar_venda.to_f)}';
                            </script>"
  end

  def dinamic_busca_compra_produto #
    tipo = "nome"            if params[:tipo] == "DESCRIPCION"
    tipo = "barra"           if params[:tipo] == "BARRA"

    @produtos = Produto.all( :conditions => ["#{tipo} LIKE ? ","%#{params[:busca]}%"],:order => 'nome,fabricante')
    respond_to do |format|
      format.js # show.html.erb
      format.html {render :layout => false}
      format.xml  { render :xml => @produtos }
    end
  end

  def produtos_selecionados                    #
     @produtos = Produto.find(params[:produto_ids])
     render :layout => false
  end

  def busca_compra_produto         #
    @produtos = Produto.find(:all, :order => 1)
    
    render :layout => 'consulta'
  end

  def dinamic_busca_venda_produto  #
    @produtos = Produto.find(:all, :conditions => ["fabricante_cod LIKE ? OR nome LIKE ? OR fabricante LIKE ?","%#{params[:busca]}%","%#{params[:busca]}%","%#{params[:busca]}%"])
    render :layout => false
  end

  def busca_venda_produto          #
    @produtos = Produto.find(:all, :order => 1)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @produtos }
    end
  end

  def dinamic_busca_ordem_produto  #
    @produtos = Produto.find(:all, :conditions => ["fabricante_cod LIKE ? OR nome LIKE ? OR fabricante LIKE ?","%#{params[:busca]}%","%#{params[:busca]}%","%#{params[:busca]}%"])
    render :layout => false
  end

  def busca_ordem_produto          #
    @produtos = Produto.find(:all, :order => 1)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @produtos }
    end
  end

  def historico_preco_produto      #
    @produto = Produto.find(params[:id])
    @tabela = TabelaPrecoProduto.all(:conditions => ['produto_id = ?',params[:id]])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @produto }
    end
  end

  def consulta_stock               #
      render :layout => 'consulta'
  end

  def dinamic_busca_consulta_stock #


    tipo = "nome"        if params[:tipo] == "DESCRIPCION"
    tipo = "barra"       if params[:tipo] == "CODIGO"
   
    cond  = " #{tipo} LIKE '%#{params[:busca]}%' "

    @produtos = Produto.all( :conditions => cond,:order => 'nome,fabricante')
    respond_to do |format|
      format.js # show.html.erb
      format.html {render :layout => false}
      format.xml  { render :xml => @produtos }
    end

  end

  def dinamic_busca                #

    @prod = Produto.busca_produto(params)

    respond_to do |format|      
      format.html {render :layout => false}      
    end
  end


  #METHOD BASE
  def index                        #
    @prod = Produto.all(:select => 'id,nome', :conditions => ["nome LIKE ?","%#{params[:busca]}%"])
    respond_to do |format|
      format.js # show.html.erb
      format.html # index.html.erb
      format.xml  { render :xml => @produtos }
    end
  end

  def show                         #
    @produto = Produto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @produto }
    end
  end

  def new                          #
    @produto = Produto.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @produto }
    end
  end

  def edit                         #
    @produto = Produto.find(params[:id])
    @quantidade = Stock.sum("entrada - saida",:conditions => ["produto_id = ?",params[:id]])
  end

  def create                       #
    @produto = Produto.new(params[:produto])
    @produto.usuario_created = current_user.usuario_nome
    @produto.unidade_created = current_unidade.unidade_nome


    respond_to do |format|
      if @produto.save
        flash[:notice] = 'Grabado con Sucesso'
        format.html { redirect_to(produtos_url) }
        format.xml  { render :xml => @produto, :status => :created, :location => @produto }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @produto.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update                       #
    @produto = Produto.find(params[:id])
    @produto.usuario_created = current_user.usuario_nome
    @produto.unidade_created = current_unidade.unidade_nome


    respond_to do |format|
      if @produto.update_attributes(params[:produto])
        flash[:notice] = 'Actualizado con Sucesso'
        format.html { redirect_to(produtos_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @produto.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy                      #
    @produto = Produto.find(params[:id])
    @produto.destroy

    respond_to do |format|
      format.html { redirect_to(produtos_url) }
      format.xml  { head :ok }
    end
  end
end
