class Sueldo < ActiveRecord::Base

has_many :sueldos_detalhes
has_one :compra


  def before_save
    @persona = Persona.find_by_id(self.persona_id);
    self.persona_nome        = @persona.nome.to_s;
    self.salario             = @persona.salario.to_f;
    self.salario_minimo      = @persona.salario_minimo.to_f;
    self.comissao            = @persona.comissao.to_f;
    self.ci                  = @persona.ci.to_f;
    self.ips                 = @persona.ips.to_f;
  end

end
