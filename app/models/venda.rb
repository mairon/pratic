class Venda < ActiveRecord::Base
  has_many :vendas_produtos,   :order => 1
  has_many :vendas_financas,   :order => 1
  belongs_to :persona


  def self.filtro_vendas(params)
    
    cond =  ["data BETWEEN '#{params[:inicio]}' AND '#{params[:final]}' "] unless params[:inicio].blank?
    
    if params[:tipo] == "CODIGO"
      tipo = "id"
      cond =  ["#{tipo} = ? ","#{params[:busca]}"] unless params[:busca].blank?
    else
      tipo = "persona_nome"
      cond =  ["#{tipo} LIKE ? ","%#{params[:busca]}%"] unless params[:busca].blank?

    end



    Venda.all(:select => 'id,data,persona_nome,tipo,documento_numero_01,documento_numero_02,documento_numero,quantidade,total_dolar,total_guarani',:conditions => cond,:order => 'data,id')
  end

end
