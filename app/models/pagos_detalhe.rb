class PagosDetalhe < ActiveRecord::Base
 belongs_to :pago

    def before_save
        if pago.moeda == 0
           self.pago_guarani = self.pago_dolar * pago.cotacao
        else
           self.pago_dolar   = self.pago_guarani / pago.cotacao
        end
    end
end
