class Financa < ActiveRecord::Base

  def self.relatorio_financas(params)

    conta = "AND conta_id = #{params[:busca]["conta"]}" unless params[:busca]["conta"].blank?

    cond  = "data BETWEEN '#{params[:inicio]}' AND '#{params[:final]}' AND ESTADO = 0 AND entrada_guarani + saida_guarani > 0  #{conta}"

    Financa.all(:conditions => cond, :order => 'data,id')
  end

  def self.relatorio_financas_saldo_anterior(params)

    conta = "AND conta_id = #{params[:busca]["conta"]}" unless params[:busca]["conta"].blank?

    cond  = "data < '#{params[:inicio]}' AND ESTADO = 0 AND entrada_guarani + saida_guarani > 0  #{conta}"

    Financa.sum('entrada_guarani - saida_guarani',:conditions => cond)
  end


end
