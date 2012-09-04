class Bomba < ActiveRecord::Base

  validates_presence_of :nome

  def before_save
    @deposito          = Deposito.find_by_id(self.deposito_id);
    self.deposito_nome = @deposito.nome.to_s;
  end

end
