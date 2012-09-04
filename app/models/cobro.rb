class Cobro < ActiveRecord::Base
  has_many :cobros_detalhes,   :order => 'documento_numero'
  has_many :cobros_financas,   :order => 'diferido'

  belongs_to :persona

  validates_presence_of :cotacao,
                        :persona_nome


  def self.filtro(params)

      cond =  ["data BETWEEN '#{params[:inicio]}' AND '#{params[:final]}' "] unless params[:inicio].blank?

      if params[:tipo] == "CODIGO"
         tipo = "id"
         cond =  ["#{tipo} = ? ","#{params[:busca]}"] unless params[:busca].blank?
      else
         tipo = "persona_nome"
         cond =  ["#{tipo} LIKE ? ","%#{params[:busca]}%"] unless params[:busca].blank?
      end

      Cobro.all(:select => 'id,data,persona_nome,recibo,valor_guarani',:conditions => cond,:order => 'data,id')
  end



  def before_update    
      @conta = Conta.find_by_id(self.conta_id);
      self.conta_nome = @conta.nome.to_s unless self.conta_id.blank?

      @documento = Documento.find_by_id(self.documento_id);
      self.documento_nome = @documento.nome.to_s unless self.documento_id.blank?
  end


end
