class ComprasDocumento < ActiveRecord::Base
  belongs_to :compra
  


  def before_save          #

    @documento          = Documento.find_by_id(self.documento_id);
    self.documento_nome = @documento.nome.to_s;
      
     cotacao = self.cotacao.to_f

         if self.moeda == 0
            self.exentas_guarani     =  self.exentas_dolar  * cotacao
            self.gravadas_05_guarani =  self.gravadas_05_dolar * cotacao
            self.gravadas_10_guarani =  self.gravadas_10_dolar * cotacao
            self.imposto_05_guarani  =  self.imposto_05_dolar * cotacao
            self.imposto_10_guarani  =  self.imposto_10_dolar * cotacao
            self.total_guarani       =  self.total_dolar * cotacao
         else
            self.exentas_dolar     =  self.exentas_guarani  / cotacao
            self.gravadas_05_dolar =  self.gravadas_05_guarani / cotacao
            self.gravadas_10_dolar =  self.gravadas_10_guarani / cotacao
            self.imposto_05_dolar  =  self.imposto_05_guarani / cotacao
            self.imposto_10_dolar  =  self.imposto_10_guarani / cotacao
            self.total_dolar       =  self.total_guarani / cotacao

         end
    
  end

end
