class ComprasFinanca < ActiveRecord::Base
belongs_to :compra

 def before_save          #
    @documento          = Documento.find_by_id(self.documento_id);
    self.documento_nome = @documento.nome.to_s;

    @conta          = Conta.find_by_id(self.conta_id);
    self.conta_nome = @conta.nome.to_s;


    self.documento_numero = self.documento_numero.to_s.rjust(5,'0')
 end
end
