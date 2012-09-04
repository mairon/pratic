class Conta < ActiveRecord::Base

  validates_presence_of :nome
  
  def before_save
     @cidade = Cidade.find_by_id(self.cidade_id);
      self.cidade = @cidade.nome.to_s;
  end
end
