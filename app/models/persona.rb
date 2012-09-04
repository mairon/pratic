class Persona < ActiveRecord::Base

  validates_presence_of :nome,
                        :ruc
  validates_uniqueness_of :ruc
    def before_save
    @cidade = Cidade.find_by_id(self.cidade_id);
    self.cidade = @cidade.nome.to_s;
  end

end
