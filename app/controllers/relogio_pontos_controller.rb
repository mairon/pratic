class RelogioPontosController < ApplicationController


    def get_turno                       #
        @turno =  Turno.find(:first, :select => 'id',:conditions =>  [ "id = ?", params[:campo_turno]])
        return render :text =>
        "<script type='text/javascript'>
         document.getElementById('relogio_ponto_turno_id').value    = '#{@turno.id.to_i}';
       </script>"
    end

    def get_usuario                     #
        @usuario =  Usuario.find(:first,:select => 'id', :conditions =>  [ "id = ?", params[:campo_usuario]])
        return render :text =>
        "<script type='text/javascript'>
         document.getElementById('relogio_ponto_usuario_id').value    = '#{@usuario.id.to_i}';
       </script>"
    end



    def index                         #
        @relogio_pontos = RelogioPonto.all

        respond_to do |format|
            format.html # index.html.erb
            format.xml  { render :xml => @relogio_pontos }
        end
    end

    def show                          #
        @relogio_ponto = RelogioPonto.find(params[:id])

        render :layout => 'relogio_ponto'
    end

    def new                           #
        @relogio_ponto = RelogioPonto.new
        
        render :layout => 'relogio_ponto'
    end

    def edit                          #
        @relogio_ponto = RelogioPonto.find(params[:id])
        render :layout => 'relogio_ponto'
    end

    def create                        #
        @relogio_ponto = RelogioPonto.new(params[:relogio_ponto])

        respond_to do |format|
            if @relogio_ponto.save
                format.html { redirect_to(@relogio_ponto, :notice => 'Grabado con Sucesso') }
            else
                format.html { render :action => "new", :layout => 'relogio_ponto' }
            end
        end
    end

    def update                        #
        @relogio_ponto = RelogioPonto.find(params[:id])

        respond_to do |format|
            if @relogio_ponto.update_attributes(params[:relogio_ponto])
                format.html { redirect_to(@relogio_ponto, :notice => 'RelogioPonto was successfully updated.') }
                format.xml  { head :ok }
            else
                format.html { render :action => "edit" }
                format.xml  { render :xml => @relogio_ponto.errors, :status => :unprocessable_entity }
            end
        end
    end

    def destroy                       #
        @relogio_ponto = RelogioPonto.find(params[:id])
        @relogio_ponto.destroy

        respond_to do |format|
            format.html { redirect_to(relogio_pontos_url) }
            format.xml  { head :ok }
        end
    end
end
