class ProducaoProdutosController < ApplicationController
    before_filter :authenticate

    def get_codigo_barra_produto            #
        @producao = Producao.find(params[:producao_id])
        @produto =  Produto.find(:first, :conditions =>  [ "fabricante_cod = ?", params[:codigo]])

        return render :text => "<script type='text/javascript'>
                                  document.getElementById('producao_produto_produto_nome').value             = '#{@produto.nome.to_s}';
                                </script>"
    end

    def index                               #
        @producao_produtos = ProducaoProduto.all

        respond_to do |format|
            format.html # index.html.erb
            format.xml  { render :xml => @producao_produtos }
        end
    end

    def show                                #
        @producao_produto = ProducaoProduto.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.xml  { render :xml => @producao_produto }
        end
    end

    def new                                 #
        @producao = Producao.find(params[:producao_id])

        @producao_produto = ProducaoProduto.new

        respond_to do |format|
            format.html # new.html.erb
            format.xml  { render :xml => @producao_produto }
        end
    end

    def edit                                #
        @producao = Producao.find(params[:producao_id])
        @producao_produto = ProducaoProduto.find(params[:id])
    end

    def create                              #
        @producao = Producao.find(params[:producao_id])
        @producao_produto = @producao.producao_produtos.build(params[:producao_produto])

        respond_to do |format|
            if @producao_produto.save
                format.html { redirect_to producao_path(@producao) }
            else
                format.html { render :action => "new" }
            end
        end
    end

    def update                              #
        @producao = Producao.find(params[:producao_id])
        @producao_produto = ProducaoProduto.find(params[:id])

        respond_to do |format|
            if @producao_produto.update_attributes(params[:producao_produto])
                format.html { redirect_to producao_path(@producao) }
            else
                format.html { render :action => "edit" }
            end
        end
    end

    def destroy                             #
        @producao = Producao.find(params[:producao_id])
        @producao_produto = ProducaoProduto.find(params[:id])
        @producao_produto.destroy

        respond_to do |format|
            format.html { redirect_to producao_path(@producao) }
        end
    end
end
