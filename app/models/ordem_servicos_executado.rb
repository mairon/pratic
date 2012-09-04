class OrdemServicosExecutado < ActiveRecord::Base

  belongs_to :ordem_servico
  belongs_to :servico

  def before_save
    @servico = Servico.find_by_id(self.servico_id);
    self.servico_valor = @servico.valor.to_f;
    self.servico_nome = @servico.nome.to_s;
    self.servico_tipo = @servico.tipo.to_i;
    if self.servico_tipo == 0
   
      #VALOR MINUTO
      inicio        = ( self.hora_inicio * 3600 ) + ( self.minuto_inicio * 60 )
      final         = ( self.hora_final  * 3600 ) + ( self.minuto_final  * 60 )

      total         = final - inicio

      self.valor_total_trabalhado  = ( total.to_f / 3600 ) * self.servico_valor

      total_hora                   = total.to_i / 3600
      total_minuto                 = total % 3600
      total_minuto                 = total_minuto.to_i / 60
      #VALOR TRABALHO
      #CAMPOS
      self.horario_inicio     = self.hora_inicio.to_s + '.' + self.minuto_inicio.to_s
      self.horario_final      = self.hora_final.to_s + '.' + self.minuto_final.to_s
      self.horario_diferenca  = total_hora.to_s +  '.' + total_minuto.to_s

    else
      
      #CALCULO KILOMETRAGEM
      self.km_diferenca           = self.km_final.to_f - self.km_inicio.to_f
      self.valor_total_trabalhado = self.km_diferenca.to_f * self.servico_valor.to_f
    end
  end
  #USUARIO
  def before_create
    self.usuario_created = $log_usuario_id
  end

  def before_update
    self.usuario_updated = $log_usuario_id
  end

end
