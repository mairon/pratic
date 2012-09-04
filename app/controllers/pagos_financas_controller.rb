class PagosFinancasController < ApplicationController
      before_filter :authenticate

      def index             #
        @pagos_financas = PagosFinanca.all

        respond_to do |format|
          format.html # index.html.erb
          format.xml  { render :xml => @pagos_financas }
        end
      end

      def show              #
        @pagos_financa = PagosFinanca.find(params[:id])

        respond_to do |format|
          format.html # show.html.erb
          format.xml  { render :xml => @pagos_financa }
        end
      end

      def new               #
        @pagos_financa = PagosFinanca.new

        respond_to do |format|
          format.html # new.html.erb
          format.xml  { render :xml => @pagos_financa }
        end
      end

      def edit              #
        @pagos_financa = PagosFinanca.find(params[:id])
      end

      def create            #
        @pagos_financa = PagosFinanca.new(params[:pagos_financa])
        @pagos_financa.usuario_created = current_user.id
        @pagos_financa.unidade_created = current_unidade.id

        respond_to do |format|
          if @pagos_financa.save
            format.html { redirect_to "/pagos/pago_final/#{@pagos_financa.pago_id}" }
            format.xml  { render :xml => @pagos_financa, :status => :created, :location => @pagos_financa }
          else
            format.html { render :action => "new" }
            format.xml  { render :xml => @pagos_financa.errors, :status => :unprocessable_entity }
          end
        end
      end

      def update            #
        @pagos_financa = PagosFinanca.find(params[:id])
        @pagos_financa.usuario_updated = current_user.id
        @pagos_financa.unidade_updated = current_unidade.id

        respond_to do |format|
          if @pagos_financa.update_attributes(params[:pagos_financa])
            format.html { redirect_to "/pagos/pago_final/#{@pagos_financa.pago_id}" }
            format.xml  { head :ok }
          else
            format.html { render :action => "edit" }
            format.xml  { render :xml => @pagos_financa.errors, :status => :unprocessable_entity }
          end
        end
      end

      def destroy           #
        @pagos_financa = PagosFinanca.find(params[:id])
        @pagos_financa.destroy

        respond_to do |format|
          format.html { redirect_to "/pagos/pago_final/#{@pagos_financa.pago_id}" }
          format.xml  { head :ok }
        end
      end
end
