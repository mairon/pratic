class VendasProdutosController < ApplicationController

    def get_codigo             #
        @persona =  Persona.find(:first, :conditions =>  [ "id = ?", params[:codigo]])
        return render :text => "<script type='text/javascript'>
                              document.getElementById('vendas_financa_persona_id').value           = '#{@persona.id.to_i}';
                              document.getElementById('vendas_financa_persona_nome').value         = '#{@persona.nome.to_s}';
                              document.getElementById('vendas_financa_cidade_id').value            = '#{@persona.cidade_id.to_i}';
                              document.getElementById('vendas_financa_ruc').value                  = '#{@persona.ruc.to_s}';
                              document.getElementById('vendas_financa_direcao').value              = '#{@persona.direcao.to_s}';
                              document.getElementById('vendas_financa_bairro').value               = '#{@persona.bairro.to_s}';
                            </script>"
    end

    def get_codigo_barra_produto             #
        @produto =  Produto.find(:first, :conditions =>  [ "barra = ?", params[:codigo]])
        @stock = Stock.sum( 'entrada - saida',:conditions => ['produto_id = ?',@produto.id] )

        return render :text => "<script type='text/javascript'>
                              document.getElementById('venda_produto_produto_busca_').value             = '#{@produto.nome.to_s}';
                              document.getElementById('vendas_produto_produto_nome').value             = '#{@produto.nome.to_s}';
                              document.getElementById('vendas_produto_produto_id').value               = '#{@produto.id.to_i}';
                              document.getElementById('vendas_produto_saldo').value               = '#{@stock.to_i}';
                              document.getElementById('vendas_produto_clase_id').value                 = '#{@produto.clase_id.to_i}';
                              document.getElementById('vendas_produto_grupo_id').value                 = '#{@produto.grupo_id.to_i}';
                              document.getElementById('vendas_produto_tipo').value                     = '#{@produto.tipo.to_i}';
                              document.getElementById('vendas_produto_unitario_dolar').value           = '#{format("%.2f",@produto.preco_venda_dolar.to_f)}';
                              document.getElementById('vendas_produto_unitario_guarani').value         = '#{@produto.preco_venda_guarani.to_s}';
                              document.getElementById('vendas_produto_total_dolar').value           = '#{format("%.2f",@produto.preco_venda_dolar.to_f)}';
                              document.getElementById('vendas_produto_total_guarani').value         = '#{@produto.preco_venda_guarani.to_s}';
                              document.getElementById('vendas_produto_saldo').value                    = '#{@stock}';
                              document.getElementById('vendas_produto_taxa').value                     = '#{@produto.taxa.to_f}';
                               if ( '#{@stock}' <= 0 )
                                 {
                                  document.getElementById('red').innerHTML                             =  '<span>'+'#{@stock}'+'</span>' ;
                                  document.getElementById('green').innerHTML                           =  '' ;
                                 }
                               else
                                 {
                                  document.getElementById('green').innerHTML                           =  '<span>'+'#{@stock}'+'</span>' ;
                                  document.getElementById('red').innerHTML                             =  '' ;
                                 }
                           </script>"

    end


    def get_produto            #
        @produto =  Produto.find(:first, :conditions =>  [ "nome = ?", params[:produto_busca]])

        @stock = Stock.sum( 'entrada - saida',:conditions => ['produto_id = ?',@produto.id] )

        return render :text => "<script type='text/javascript'>
                              document.getElementById('vendas_produto_produto_nome').value             = '#{@produto.nome.to_s}';
                              document.getElementById('vendas_produto_produto_id').value               = '#{@produto.id.to_i}';
                              document.getElementById('vendas_produto_clase_id').value                 = '#{@produto.clase_id.to_i}';
                              document.getElementById('vendas_produto_grupo_id').value                 = '#{@produto.grupo_id.to_i}';
                              document.getElementById('vendas_produto_tipo').value                     = '#{@produto.tipo.to_i}';
                              document.getElementById('vendas_produto_unitario_dolar').value           = '#{format("%.2f",@produto.preco_venda_dolar.to_f)}';
                              document.getElementById('vendas_produto_unitario_guarani').value         = '#{@produto.preco_venda_guarani.to_s}';
                              document.getElementById('vendas_produto_total_dolar').value           = '#{format("%.2f",@produto.preco_venda_dolar.to_f)}';
                              document.getElementById('vendas_produto_total_guarani').value         = '#{@produto.preco_venda_guarani.to_s}';
                              document.getElementById('vendas_produto_saldo').value                    = '#{@stock}';
                              document.getElementById('vendas_produto_taxa').value                     = '#{@produto.taxa.to_f}';
                           if ( '#{@stock}' <= 0 )
                             {
                              document.getElementById('red').innerHTML                                   =  '<span>'+'#{@stock}'+'</span>' ;
                              document.getElementById('green').innerHTML                                 =  '' ;
                             }
                           else
                             {
                              document.getElementById('green').innerHTML                                 =  '<span>'+'#{@stock}'+'</span>' ;
                              document.getElementById('red').innerHTML                                   =  '' ;
                             }

                            </script>"
    end



    def busca_nota_credito_produto       #
        @vendas_produtos = VendasProduto.nota_credito_produto(params)
        render :layout => 'consulta'
    end

    def index       #
        @vendas_produtos = VendasProduto.find(:all)

        respond_to do |format|
            format.html # index.html.erb
            format.xml  { render :xml => @vendas_produtos }
        end
    end

    def show        #
        @vendas_produto = VendasProduto.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.xml  { render :xml => @vendas_produto }
        end
    end

    def new         #
        @vendas_produto = VendasProduto.new

        respond_to do |format|
            format.html # new.html.erb
            format.xml  { render :xml => @vendas_produto }
        end
    end

    def edit        #
        @vendas_produto = VendasProduto.find(params[:id])
    end

    def create      #
        @vendas_produto = VendasProduto.new(params[:vendas_produto])
        @vendas_produto.usuario_created   = current_user.id
        @vendas_produto.unidade_created   = current_unidade.id
        @vendas_produto.turno_created     = current_turno.id
        @vendas_produto.conta_created     = current_conta.id

        flash[:alert] = 'Fail to receive the comment. Double check the fields' unless @vendas_produto.save

        respond_to do |format|
            format.html { redirect_to venda_path(@vendas_produto.venda_id) }
            format.js
        end
    end

    def update      #
        @vendas_produto = VendasProduto.find(params[:id])
        @vendas_produto.usuario_updated   = current_user.id
        @vendas_produto.unidade_updated   = current_unidade.id
        @vendas_produto.turno_updated     = current_turno.id
        @vendas_produto.conta_updated     = current_conta.id

        respond_to do |format|
            if @vendas_produto.update_attributes(params[:vendas_produto])

                flash[:notice] = 'Actualizado con Sucesso'
                format.html { redirect_to "/vendas/show/#{@vendas_produto.venda_id}" }
                format.xml  { head :ok }
            else
                format.html { render :action => "edit" }
                format.xml  { render :xml => @vendas_produto.errors, :status => :unprocessable_entity }
            end
        end
    end

    def destroy     #
        @vendas_produto = VendasProduto.find(params[:id])
        @vendas_produto.destroy

        respond_to do |format|
            format.html { redirect_to "/vendas/show/#{@vendas_produto.venda_id}" }
            format.xml  { head :ok }
        end
    end
end
