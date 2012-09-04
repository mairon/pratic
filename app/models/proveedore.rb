class Proveedore < ActiveRecord::Base

  def self.relatorio_contas_pagar(params)
      #FITRO POR DATA FATURACAO
      if params[:inicio_faturacao] != blank?
         pers      = "AND PERSONA_ID = #{params[:busca]["persona"]} " unless params[:busca]["persona"].blank?
         liq_open  = "AND liquidacao = 0 #{pers}"                     if params[:filtro] == "0"
         liq_close = "AND liquidacao = 1 #{pers}"                     if params[:filtro] == "1"
         liq_all   = "#{pers}"                                        if params[:filtro] == "2"

         cond = "data  BETWEEN  '#{params[:inicio_faturacao]}' AND '#{params[:final_faturacao]}' #{liq_open} #{liq_close} #{liq_all}"
      else
         #FITRO POR DATA FATURACAO VENCIMENTO
         pers      = "AND PERSONA_ID = #{params[:busca]["persona"]} " unless params[:busca]["persona"].blank?
         liq_open  = "AND liquidacao = 0 #{pers}"                     if params[:filtro] == "0"
         liq_close = "AND liquidacao = 1 #{pers}"                     if params[:filtro] == "1"
         liq_all   = "#{pers}"                                        if params[:filtro] == "2"

         cond = "data  BETWEEN  '#{params[:inicio_vencimento]}' AND '#{params[:final_vencimento]}' #{liq_open} #{liq_close} #{liq_all}"
      end

      Proveedore.all( :select     => "id,
                                      data,                                      
                                      persona_id,
                                      persona_nome,
                                      documento_numero_01,
                                      documento_numero_02,
                                      documento_numero,
                                      documento_nome,
                                      cota,
                                      vencimento,
                                      divida_guarani,
                                      divida_dolar,
                                      pago_guarani,
                                      pago_dolar
                                     ",
                    :conditions   => cond,
                    :order        => "2,3,7,8,1" )
  end

end
