class Stock < ActiveRecord::Base

  validates_presence_of :produto_id,:entrada

    def self.relatorio_ficha_stock( params )               #
        #FILTRO
        filtro   = " AND status      = #{params[:filtro]} "  unless params[:filtro].blank?
        #CLASE
        clase    = " AND clase_id    = #{params[:busca]["clase"]}"    unless params[:busca]["clase"].blank?
        #GRUPO
        grupo    = " AND grupo_id    = #{params[:busca]["grupo"]}"    unless params[:busca]["grupo"].blank?
        #PRODUTO
        produto  = " AND produto_id  = #{params[:busca]["produto"]}"  unless params[:busca]["produto"].blank?
        #DEPOSITO
        deposito = " AND deposito_id = #{params[:busca]["deposito"]}" unless params[:busca]["deposito"].blank?

        cond = " data BETWEEN '#{params[:inicio]}' AND '#{params[:final]}' #{filtro} #{clase} #{grupo} #{produto} #{deposito} "

        Stock.all(:select     => "id,
                              data,
                              status,
                              venda_id,
                              produto_id,
                              codigo,
                              produto_nome,
                              deposito_nome,
                              entrada,
                              saida,
                              tabela_id",
            :conditions => cond,
            :order      => '2,1' )

    end

    def self.relatorio_ficha_stock_saldo_anterio( params ) #
        #FILTRO
        filtro   = " AND status      = #{params[:filtro]} "  unless params[:filtro].blank?
        #CLASE
        clase    = " AND clase_id    = #{params[:busca]["clase"]}"    unless params[:busca]["clase"].blank?
        #GRUPO
        grupo    = " AND grupo_id    = #{params[:busca]["grupo"]}"    unless params[:busca]["grupo"].blank?
        #PRODUTO
        produto  = " AND produto_id  = #{params[:busca]["produto"]}"  unless params[:busca]["produto"].blank?
        #DEPOSITO
        deposito = " AND deposito_id = #{params[:busca]["deposito"]}" unless params[:busca]["deposito"].blank?

        cond = " data < '#{params[:inicio]}' #{filtro} #{clase} #{grupo} #{produto} #{deposito} "

        Stock.sum( 'entrada - saida',:conditions => cond )

    end

    def self.resultaro_iventario( params )                 #
        #CONDICOES
        #CLASE
        clase   = " and clase_id = #{params[:busca]["clase"]}" unless params[:busca]["clase"].blank?
        #GRUPO
        grupo   = "AND grupo_id = #{params[:busca]["grupo"]}" unless params[:busca]["grupo"].blank?
        #PRODUTO
        produto = "AND id = #{params[:busca]["produto"]}"     unless params[:busca]["produto"].blank?

        cond    = "status != 1 #{clase} #{grupo} #{produto}"

        Produto.all( :select     => ' id,
                                   clase_id,
                                   grupo_id,
                                   cod_velho,
				   barra,
                                   preco_venda_guarani,
                                   nome',
            :conditions =>   cond,
            :order      => ' clase_id,
                                   grupo_id,
                                   nome' )

    end

    def self.stock_final(params)                           #


        if params[:tipo] == "CODIGO"
            tipo = "barra"
            unless params[:busca].blank?
                cond =  ["#{tipo} LIKE ? AND tabela = 'STOCK FINAL'","%#{params[:busca]}%"]
            else
                cond =  ["tabela = 'STOCK FINAL'"]
            end
        else
            tipo = "produto_nome"

            unless params[:busca].blank?
                cond =  ["#{tipo} LIKE ? AND tabela = 'STOCK FINAL'","%#{params[:busca]}%"]
            else
                cond =  ["tabela = 'STOCK FINAL'"]
            end
        end



        self.all(:conditions => cond,:order => 'data,id')
    end


    def self.stock_inicial(params)                           #


        if params[:tipo] == "CODIGO"
            tipo = "barra"
                cond =  ["#{tipo} LIKE ? AND TABELA IS NULL","%#{params[:busca]}%"]
        else
            tipo = "produto_nome"
                cond =  ["#{tipo} LIKE ? AND TABELA IS NULL","%#{params[:busca]}%"]
        end

        self.all(:conditions => cond,:order => 'data,id')
    end


    def before_save
        @prod          = Produto.find_by_id(self.produto_id);
        self.produto_nome = @prod.nome.to_s;
        self.clase_id = @prod.clase_id.to_s;
        self.grupo_id = @prod.grupo_id.to_s;


        taxa        = ( ( self.taxa.to_f / 100 ) + 1.00 )

        iva_prod_gs = ( self.unitario_guarani.to_f / taxa )
        iva_unit_gs = ( ( iva_prod_gs.to_f * self.taxa.to_f ) / 100 )
        custo_gs    = ( self.unitario_guarani.to_f - iva_unit_gs.to_f )

        iva_prod_us = ( self.unitario_dolar.to_f / taxa )
        iva_unit_us = ( ( iva_prod_us.to_f * self.taxa.to_f ) / 100 )
        custo_us    = ( self.unitario_dolar.to_f - iva_unit_us.to_f )

        self.custo_contabil_guarani = custo_gs
        self.custo_contabil_dolar   = custo_us
        self.iva_guarani = iva_unit_gs
        self.iva_dolar   = iva_unit_us

    end


    #RENTABILIDAD
    def self.rentabilidade( params )                                     #
        #CONDICOES
        #CLASE
        clase   = "clase_id = #{params[:busca]["clase"]}" unless params[:busca]["clase"].blank?
        #GRUPO
        grupo   = "AND grupo_id = #{params[:busca]["grupo"]}" unless params[:busca]["grupo"].blank?
        #PRODUTO
        produto = "AND id = #{params[:busca]["produto"]}"     unless params[:busca]["produto"].blank?

        cond    = "#{clase} #{grupo} #{produto}"

        Produto.all( :select     => ' id,
                                   clase_id,
                                   grupo_id,
                                   barra,
                                   nome',
            :conditions =>   cond,
            :order      => ' clase_id,
                             grupo_id,
                             nome' )

    end


end


