class Cliente < ActiveRecord::Base
  belongs_to :venda

  def self.relatorio_contas_receber(params)

      if params[:inicio_faturacao].blank?
         #FITRO POR DATA FATURACAO

         pers      = "AND PERSONA_ID = #{params[:busca]["persona"]} " unless params[:busca]["persona"].blank?
         liq_open  = "AND liquidacao = 0 #{pers}"                     if params[:filtro] == "0"
         liq_close = "AND liquidacao = 1 #{pers}"                     if params[:filtro] == "1"
         liq_all   = "#{pers}"                                        if params[:filtro] == "2"
         recibo    = "AND recibo = #{params[:recibo]}"                unless params[:recibo].blank?

         cond = "data  BETWEEN  '#{params[:inicio_vencimento]}' AND '#{params[:final_vencimento]}' #{liq_open} #{liq_close} #{liq_all} #{recibo}"
      else
         #FITRO POR DATA FATURACAO VENCIMENTO

         pers      = "AND PERSONA_ID = #{params[:busca]["persona"]} " unless params[:busca]["persona"].blank?
         liq_open  = "AND liquidacao = 0 #{pers}"                     if params[:filtro] == "0"
         liq_close = "AND liquidacao = 1 #{pers}"                     if params[:filtro] == "1"
         liq_all   = "#{pers}"                                        if params[:filtro] == "2"
         recibo    = "AND recibo = #{params[:recibo]}"                unless params[:recibo].blank?

         cond = "data  BETWEEN  '#{params[:inicio_faturacao]}' AND '#{params[:final_faturacao]}' #{liq_open} #{liq_close} #{liq_all} #{recibo}"

      end

      Cliente.all( :select     => "id,
                                   data,
                                   persona_id,
                                   persona_nome,
                                   documento_numero_01,
                                   documento_numero_02,
                                   documento_numero,
                                   documento_nome,
                                   cheque,
                                   tipo,
                                   recibo,
                                   cota,
                                   vencimento,
                                   divida_guarani,
                                   cobro_guarani
                                  ",
                   :conditions => cond,
                   :order      => "2,3,7,8,1" )
  end

  def self.relatorio_contas_receber_saldo_anterior(params)
      
      if params[:inicio_faturacao].blank?
         #FITRO POR DATA FATURACAO VENCIMENTO
         
         pers      = "AND PERSONA_ID = #{params[:busca]["persona"]} " unless params[:busca]["persona"].blank?
         liq_open  = "AND liquidacao = 0 #{pers}"                     if params[:filtro] == "0"
         liq_close = "AND liquidacao = 1 #{pers}"                     if params[:filtro] == "1"
         liq_all   = "#{pers}"                                        if params[:filtro] == "2"
         recibo    = "AND recibo = #{params[:recibo]}"                unless params[:recibo].blank?

         cond = "data < '#{params[:inicio_vencimento]}' #{liq_open} #{liq_close} #{liq_all} #{recibo}"
      else
         #FITRO POR DATA FATURACAO

         pers      = "AND PERSONA_ID = #{params[:busca]["persona"]} " unless params[:busca]["persona"].blank?
         liq_open  = "AND liquidacao = 0 #{pers}"                     if params[:filtro] == "0"
         liq_close = "AND liquidacao = 1 #{pers}"                     if params[:filtro] == "1"
         liq_all   = "#{pers}"                                        if params[:filtro] == "2"
         recibo    = "AND recibo = #{params[:recibo]}"                unless params[:recibo].blank?

         cond = "data < '#{params[:inicio_faturacao]}' #{liq_open} #{liq_close} #{liq_all} #{recibo}"
      end

      Cliente.sum("divida_guarani - cobro_guarani",:conditions => cond )
  end


  def self.relatorio_contas_receber_general(params)
      #FITRO POR DATA FATURACAO
         pers = "AND PERSONA_ID = #{params[:busca]["persona"]} " unless params[:busca]["persona"].blank?
         cond = "#{pers}"

      Persona.all( :select     => "id,nome
                                  ",
                   :conditions => cond,
                   :order      => "2" )
  end

end
