class FaturasController < ApplicationController
    def index
        respond_to do |format|
            format.html # index.html.erb
        end
    end

    def busca                 #
        @faturas = Fatura.filtro(params)
        render :layout => false
    end

    def show
        @fatura = Fatura.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.xml  { render :xml => @fatura }
        end
    end

    def new
        @fatura = Fatura.new

        respond_to do |format|
            format.html # new.html.erb
            format.xml  { render :xml => @fatura }
        end
    end

    def edit
        @fatura = Fatura.find(params[:id])
    end

    def create
        @fatura = Fatura.new(params[:fatura])

        respond_to do |format|
            if @fatura.save
                format.html { redirect_to(faturas_url, :notice => 'Grabado con Sucesso') }
            else
                format.html { render :action => "new" }
            end
        end
    end

    def update
        @fatura = Fatura.find(params[:id])

        respond_to do |format|
            if @fatura.update_attributes(params[:fatura])
                format.html { redirect_to(faturas_url, :notice => 'Actualizado con Sucesso') }
            else
                format.html { render :action => "edit" }
            end
        end
    end

    def destroy
        @fatura = Fatura.find(params[:id])
        @fatura.destroy

        respond_to do |format|
            format.html { redirect_to(faturas_url) }
            format.xml  { head :ok }
        end
    end
end
