class CobrosDetalhe < ActiveRecord::Base
  belongs_to :cobro

  def before_save
    if cobro.moeda == 0
      self.cobro_guarani = self.cobro_dolar *  cobro.cotacao.to_f
    else
      self.cobro_dolar   = self.cobro_guarani / cobro.cotacao.to_f
    end
  end


end
