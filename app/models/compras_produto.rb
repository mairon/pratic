class ComprasProduto < ActiveRecord::Base
  belongs_to :compra
  belongs_to  :produto

  validates_presence_of :quantidade,:produto_nome

  def validate
      #PREENCHE A QUANTIDADE
      if self.quantidade.to_f <= 0
         errors.add_to_base( "Por Favor Agrege La Cantidad" )
      end
      #MOEDA DOLAR
      if self.moeda == 0
         #PREENHE UNITARIO
         if self.unitario_dolar.to_f <= 0
             errors.add_to_base( "Por Favor Agrege Lo Unitario" )
         end
         #PREENHE TOTAL
         if self.total_dolar.to_f <= 0
             errors.add_to_base( "Por Favor Agrege Lo Total" )
         end

      #MOEDA GUARANI
      else
         #PREENHE UNITARIO
         if self.unitario_guarani.to_f <= 0
             errors.add_to_base( "Por Favor Agrege Lo Unitario" )
         end
         #PREENHE TOTAL
         if self.total_guarani.to_f <= 0
             errors.add_to_base( "Por Favor Agrege Lo Total" )
         end
      end
  end

  def before_save     #
    if self.moeda == 0

      #TOTAL_GUARANI
      self.total_guarani          = self.total_dolar.to_f * self.cotacao.to_f
      #TOTAL IVA GUARANI
      self.iva_total_guarani      = self.iva_total_dolar.to_f * self.cotacao.to_f
      #DESCONTO_GUARANI
      self.desconto_guarani       = self.desconto_dolar.to_f * self.cotacao.to_f
      #FRETE_GUARANI
      self.frete_guarani          = self.frete_dolar.to_f * self.cotacao.to_f
      #DESPACHO_GUARANI
      self.despacho_guarani       = self.despacho_dolar.to_f * self.cotacao.to_f
      #UNITARIO_GUARANI
      self.unitario_guarani       = self.total_guarani.to_f / self.quantidade.to_f

      self.custo_contabil_guarani = self.custo_contabil_dolar.to_f * self.cotacao.to_f

      if compra.tipo_compra != 2

        #IVA_GUARANI
        taxa = ( ( self.iva_taxa.to_f / 100 ) + 1.00 );
        vartotal = ( self.total_guarani.to_f / taxa );
        vartotal = ( ( vartotal * self.iva_taxa.to_f ) / 100 );
        self.iva_guarani = vartotal;
        #CUSTO CONTABIL GUARANI
     end
      
    else

      #TOTAL_DOLAR
      self.total_dolar      = self.total_guarani.to_f / self.cotacao.to_f
      #TOTAL IVA DOLAR
      self.iva_total_dolar  = self.iva_total_guarani.to_f / self.cotacao.to_f
      #DESCONTO_DOLAR
      self.desconto_dolar   = self.desconto_guarani.to_f / self.cotacao.to_f
      #FRETE_DOLAR
      self.frete_dolar      = self.frete_guarani.to_f / self.cotacao.to_f
      #DESPACHO_DOLAR
      self.despacho_dolar   = self.despacho_guarani.to_f / self.cotacao.to_f
      #UNITARIO_DOLAR
      self.unitario_dolar   = self.total_dolar.to_f / self.quantidade.to_f
      #PRECO VENDA
      self.preco_venda_dolar   = self.preco_venda_guarani.to_f / self.quantidade.to_f

      self.custo_contabil_dolar = self.custo_contabil_guarani.to_f / self.cotacao.to_f
      
      if compra.tipo_compra != 2
        #IVA_DOLAR
        taxa = ( ( self.iva_taxa.to_f / 100 ) + 1.00 );
        vartotal = ( self.total_dolar.to_f / taxa );
        vartotal = ( ( vartotal * self.iva_taxa.to_f ) / 100 );
        self.iva_dolar = vartotal;

      end
      if self.porcentagem > 0
      @preco_venda =  Produto.all(:conditions => ["id = ?",self.produto_id])

       for preco_venda in @preco_venda
           preco_venda.update_attribute :porcentagem,         self.porcentagem
           preco_venda.update_attribute :preco_venda_dolar,   self.preco_venda_dolar
           preco_venda.update_attribute :preco_venda_guarani, self.preco_venda_guarani
       end
      end

    end


  end 

  def before_create   #

    @deposito = Deposito.find_by_id(self.deposito_id,:select => 'id,nome');
    self.deposito_nome = @deposito.nome.to_s;
  end
  

end
 
