class Produto < ActiveRecord::Base

  has_many :compras_produtos
  has_many :vendas_produtos


    validates_uniqueness_of :barra

  def self.busca_produto(params)

    tipo = "nome"            if params[:tipo] == "DESCRIPCION"
    tipo = "barra"           if params[:tipo] == "BARRA"

        

    cond  = " #{tipo} LIKE '%#{params[:busca]}%' "
    #clase
    cond = cond + " AND clase_id    = #{params[:filtro01]["clase"]} "    unless params[:filtro01]["clase"].blank?
    #GRUPO
    cond = cond + " AND grupo_id    = #{params[:filtro02]["grupo"]} "    unless params[:filtro02]["grupo"].blank?

    Produto.all( :conditions =>  cond ,:order => 'clase_id,grupo_id,nome')

  end
    def after_create      #
        #CODIGO PRODUTO
        @produtos = Produto.all
        for produto in @produtos
            @codigo = produto.clase_id.to_s.rjust(2,'0') + produto.grupo_id.to_s.rjust(2,'0') + produto.id.to_s.rjust(10,'0')
            produto.update_attribute :codigo, @codigo;
        end
    end

end
