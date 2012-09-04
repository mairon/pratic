class AdelantosProveedorsController < ApplicationController
    before_filter :authenticate

    def index                 #
        @adelantos_proveedors = AdelantosProveedor.all

        respond_to do |format|
            format.html # index.html.erb
        end
    end

    def busca                 #
        @adelantos_proveedors = AdelantosProveedor.filtro(params)
        render :layout => false
    end

    def show                  #
        @adelantos_proveedor = AdelantosProveedor.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
        end
    end

    def new                   #
        @adelantos_proveedor = AdelantosProveedor.new

        respond_to do |format|
            format.html # new.html.erb
        end
    end

    def edit                  #
        @adelantos_proveedor = AdelantosProveedor.find(params[:id])
    end

    def create                #
        @adelantos_proveedor = AdelantosProveedor.new(params[:adelantos_proveedor])

        respond_to do |format|
            if @adelantos_proveedor.save
                format.html { redirect_to(adelantos_proveedors_url) }
                format.xml  { render :xml => @adelantos_proveedor, :status => :created, :location => @adelantos_proveedor }
            else
                format.html { render :action => "new" }
            end
        end
    end

    def update                #
        @adelantos_proveedor = AdelantosProveedor.find(params[:id])

        respond_to do |format|
            if @adelantos_proveedor.update_attributes(params[:adelantos_proveedor])
                format.html { redirect_to(adelantos_proveedors_url) }
                format.xml  { head :ok }
            else
                format.html { render :action => "edit" }
            end
        end
    end

    def destroy               #
        @adelantos_proveedor = AdelantosProveedor.find(params[:id])
        @adelantos_proveedor.destroy

        respond_to do |format|
            format.html { redirect_to(adelantos_proveedors_url) }
            format.xml  { head :ok }
        end
    end
    
    def get_moeda             #
        @moeda =  Moeda.find(:first,:select => 'dolar_venda', :conditions =>  [ "data = ?", params[:key]])
        return render :text => "<script type='text/javascript'>
                               document.getElementById('adelantos_proveedor_cotacao').value       = '#{format("%.2f",@moeda.dolar_venda.to_f)}';
                            </script>"
    end

end
