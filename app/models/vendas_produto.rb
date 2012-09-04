class VendasProduto < ActiveRecord::Base
  belongs_to :venda
  belongs_to :produto  
  validates_presence_of :produto_id

  def persona_busca       #
    persona.nome if produto
  end

  def persona_busca=(nome)#
    self.persona_nome = Persona.find_or_create_by_nome(nome) unless nome.blank?
  end


#BUSCA PRODUTO NOTA DE CREDITO

  def self.nota_credito_produto(params)

    cod = "persona_id = #{params[:persona_id]} AND moeda = #{params[:moeda]} AND tipo = #{params[:tipo]}"

    VendasProduto.all(:conditions => [cod])
  end


  def before_save         #
      @bomba = Bomba.find_by_id(self.bomba_id);
      self.bomba_nome     = @bomba.nome.to_s unless self.bomba_id.blank?;
      self.deposito_id    = @bomba.deposito_id.to_i unless self.bomba_id.blank?;
      self.deposito_nome  = @bomba.deposito_nome.to_s unless self.bomba_id.blank?;
      self.total_guarani = self.quantidade * self.unitario_guarani
      self.total_dolar = self.quantidade * self.unitario_dolar

  end


end
