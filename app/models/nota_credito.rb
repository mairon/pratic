class NotaCredito < ActiveRecord::Base
    has_many :nota_creditos_detalhes,   :order => 1

    def before_save       #

        if self.total_dolar > 0
            @conta = Conta.find_by_id(self.conta_id);
            self.conta_nome = @conta.nome.to_s;

        end
    end

end
