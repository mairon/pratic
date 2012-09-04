class Compra < ActiveRecord::Base
  has_many :compras_produtos,   :order => 1 
  has_many :compras_documentos, :order => 1
  has_many :compras_financas,   :order => 1
  has_one :sueldo
  belongs_to :persona
  
  validates_length_of   :documento_numero_01,
                        :documento_numero_02, :maximum=> 3


  validates_uniqueness_of :documento_numero  , :scope=>[:documento_numero_01, :documento_numero_02],:if => :tipo_compra?, :message => " ja cadastrado."


  validates_presence_of :cotacao,
                        :persona_nome,
                        :documento_numero_01,
                        :documento_numero_02,
                        :documento_numero,
                        :documento_timbrado,
                        :if => :tipo_compra?

  def validate          #
    #QUANDO FOR DIFERENTE DE UMA IMPORTACAO
        if self.tipo_compra != 2
            #REGRA DOLAR============================================================
            if self.moeda == 0

               #OBRIGATORIO TOTAL DA FATURA
               if self.total_dolar.to_f <= 0
                  errors.add_to_base( "Por Favor Agrege o Total de la Factura!" )
               end

              #REGRA CREDITO
               if self.tipo == 1
                  cotas_dolar = self.cota_dolar_01.to_f + self.cota_dolar_02.to_f + self.cota_dolar_03.to_f + self.cota_dolar_04.to_f + self.cota_dolar_05.to_f + self.cota_dolar_06.to_f
                  #COTA == TOTAL FATURA
                  if cotas_dolar.to_f != self.total_dolar.to_f
                     errors.add_to_base( "Las Cuotas No Corresponden con Los Totales" )
                  end
               end
            end

        #REGRA GUARANI==========================================================
            if self.moeda == 1

               #OBRIGATORIO TOTAL DA FATURA
               if self.total_guarani.to_f <= 0
                  errors.add_to_base( "Por Favor Agrege o Total de la Factura!" )
               end

               #REGRA CREDITO
               if self.tipo == 1
                   
                  cotas_guarani = self.cota_guarani_01.to_f + self.cota_guarani_02.to_f + self.cota_guarani_03.to_f + self.cota_guarani_04.to_f + self.cota_guarani_05.to_f + self.cota_guarani_06.to_f
                  #COTA == TOTAL FATURA
                  if cotas_guarani.to_f != self.total_guarani.to_f
                     errors.add_to_base( "Las Cuotas No Corresponden con Los Totales" )
                  end
               end
            end         
      end
      return false
    end



  def self.filtro_compra(params)

    cond =  ["tipo_compra = 0 AND data BETWEEN '#{params[:inicio]}' AND '#{params[:final]}' "] unless params[:inicio].blank?

    if params[:tipo] == "CODIGO"
       tipo = "id"
       cond =  ["#{tipo} = ? AND tipo_compra = 0","#{params[:busca]}"]  unless params[:busca].blank?
    else
       tipo = "persona_nome"
       cond =  ["#{tipo} LIKE ? AND tipo_compra = 0","%#{params[:busca]}%"] unless params[:busca].blank?

    end



    Compra.all( :select     => ' id,
                                 data,
                                 persona_nome,
                                 tipo,
                                 conta_nome,
                                 documento_numero_01,
                                 documento_numero_02,
                                 documento_numero',
                :conditions =>   cond,
                :order      => ' data,
                                 id ' )
  end



  def before_save       #
    @persona = Persona.find_by_nome(self.persona_nome);
    self.persona_id = @persona.id.to_s;
    self.persona_ruc = @persona.ruc.to_s;

     cotacao = self.cotacao.to_f

     if self.tipo_compra != 2
         @conta = Conta.find_by_id(self.conta_id);
         self.conta_nome = @conta.nome.to_s;

         @documento = Documento.find_by_id(self.documento_id);
         self.documento_nome = @documento.nome.to_s;

       #CALCULO COTACAO FATURA
         if self.moeda == 0
            self.exentas_guarani     =  self.exentas_dolar  * cotacao
            self.gravadas_05_guarani =  self.gravadas_05_dolar * cotacao
            self.gravadas_10_guarani =  self.gravadas_10_dolar * cotacao
            self.imposto_05_guarani  =  self.imposto_05_dolar * cotacao
            self.imposto_10_guarani  =  self.imposto_10_dolar * cotacao
            self.total_guarani       =  self.total_dolar * cotacao
            self.desconto_guarani    =  self.desconto_dolar * cotacao
         else
            self.exentas_dolar     =  self.exentas_guarani  / cotacao
            self.gravadas_05_dolar =  self.gravadas_05_guarani / cotacao
            self.gravadas_10_dolar =  self.gravadas_10_guarani / cotacao
            self.imposto_05_dolar  =  self.imposto_05_guarani / cotacao
            self.imposto_10_dolar  =  self.imposto_10_guarani / cotacao
            self.total_dolar       =  self.total_guarani / cotacao
            self.desconto_dolar    =  self.desconto_guarani / cotacao

         end
         #QUANDO FOR A CREDITO CALCULO COTACAO DAS COTAS
         if self.tipo == 1
            if self.moeda == 0
                self.cota_guarani_01 = self.cota_dolar_01.to_f * self.cotacao.to_f
                self.cota_guarani_02 = self.cota_dolar_02.to_f * self.cotacao.to_f
                self.cota_guarani_03 = self.cota_dolar_03.to_f * self.cotacao.to_f
                self.cota_guarani_04 = self.cota_dolar_04.to_f * self.cotacao.to_f
                self.cota_guarani_05 = self.cota_dolar_05.to_f * self.cotacao.to_f
                self.cota_guarani_06 = self.cota_dolar_06.to_f * self.cotacao.to_f
            else
                self.cota_dolar_01 = self.cota_guarani_01.to_f / self.cotacao.to_f
                self.cota_dolar_02 = self.cota_guarani_02.to_f / self.cotacao.to_f
                self.cota_dolar_03 = self.cota_guarani_03.to_f / self.cotacao.to_f
                self.cota_dolar_04 = self.cota_guarani_04.to_f / self.cotacao.to_f
                self.cota_dolar_05 = self.cota_guarani_05.to_f / self.cotacao.to_f
                self.cota_dolar_06 = self.cota_guarani_06.to_f / self.cotacao.to_f
            end
         end
     end
      if self.tipo_compra == 1
         @rubro = Rubro.find_by_id(self.rubro_id);
         self.rubro_descricao = @rubro.descricao.to_s;
         self.rubro_cod_contabil = @rubro.codigo.to_s;
      end

  end

end
