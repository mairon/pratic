class NotaCreditosController < ApplicationController
before_filter :authenticate

   def get_moeda                #
        @moeda =  Moeda.find(:first, :conditions =>  [ "data = ?", params[:key]])
        return render :text => "<script type='text/javascript'>
                              document.getElementById('nota_credito_cotacao').value       = '#{format("%.2f",@moeda.dolar_venda.to_f)}';
                            </script>"
    end

    def index                    #
        @nota_creditos = NotaCredito.find(:all)

        respond_to do |format|
            format.html # index.html.erb
            format.xml  { render :xml => @nota_creditos }
        end
    end

    def show                     #
        @nota_credito = NotaCredito.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.xml  { render :xml => @nota_credito }
        end
    end

    def nota_credito_financas    #
        @nota_credito       = NotaCredito.find(params[:id])
        @total_nota_dolar   = NotaCreditosDetalhe.sum(:total_dolar,   :conditions => ['nota_credito_id = ?',params[:id]])
        @total_nota_guarani = NotaCreditosDetalhe.sum(:total_guarani, :conditions => ['nota_credito_id = ?',params[:id]])
        respond_to do |format|
            format.html # show.html.erb
            format.xml  { render :xml => @nota_credito }
        end
        session[:pagina] = ''
    end

    def nota_credito_comprovante #
        @nota_credito       = NotaCredito.find(params[:id])
        @total_nota_dolar   = NotaCreditosDetalhe.sum(:total_dolar,   :conditions => ['nota_credito_id = ?',params[:id]])
        @total_nota_guarani = NotaCreditosDetalhe.sum(:total_guarani, :conditions => ['nota_credito_id = ?',params[:id]])
        respond_to do |format|
            format.html # show.html.erb
            format.xml  { render :xml => @nota_credito }
        end
    end

    def new                      #
        @nota_credito = NotaCredito.new

        respond_to do |format|
            format.html # new.html.erb
            format.xml  { render :xml => @nota_credito }
        end
    end

    def edit                     #
        @nota_credito = NotaCredito.find(params[:id])
        session[:pagina] = '1'
    end

    def create                   #
        @nota_credito = NotaCredito.new(params[:nota_credito])
        @nota_credito.usuario_created = current_user.usuario_nome
        @nota_credito.unidade_created = current_unidade.unidade_nome


        respond_to do |format|
            if @nota_credito.save
                flash[:notice] = 'Grabado con Sucesso!'
                format.html { redirect_to(@nota_credito) }
                format.xml  { render :xml => @nota_credito, :status => :created, :location => @nota_credito }
            else
                format.html { render :action => "new" }
                format.xml  { render :xml => @nota_credito.errors, :status => :unprocessable_entity }
            end
        end
    end

    def update                   #
        @nota_credito = NotaCredito.find(params[:id])
        @nota_credito.usuario_updated = current_user.usuario_nome
        @nota_credito.unidade_updated = current_unidade.unidade_nome

        respond_to do |format|
            if @nota_credito.update_attributes(params[:nota_credito])
                flash[:notice] = 'Actualizado con Sucesso!'
                if session[:pagina] == ''
                    format.html { redirect_to "/nota_creditos/nota_credito_comprovante/#{@nota_credito.id}" }
                    format.xml  { head :ok }
                else
                    format.html { redirect_to "/nota_creditos/#{@nota_credito.id}" }
                    format.xml  { head :ok }

                end
                format.html { redirect_to(@nota_credito) }
                format.xml  { head :ok }
            else
                format.html { render :action => "edit" }
                format.xml  { render :xml => @nota_credito.errors, :status => :unprocessable_entity }
            end
        end
    end

    def destroy                  #
        @nota_credito = NotaCredito.find(params[:id])
        @nota_credito.destroy

        respond_to do |format|
            format.html { redirect_to(nota_creditos_url) }
            format.xml  { head :ok }
        end
    end
end
