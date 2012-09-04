class Producao < ActiveRecord::Base
    has_many :producao_produtos, :dependent => :destroy

    validates_presence_of :cotacao,:quantidade,:produto_id

    def self.filtro(params)                                         #

        cond =  ["data BETWEEN '#{params[:inicio]}' AND '#{params[:final]}' "] unless params[:inicio].blank?

        if params[:tipo] == "CODIGO"
            tipo = "id"
            cond =  ["#{tipo} = ? ","#{params[:busca]}"] unless params[:busca].blank?
        elsif params[:tipo] == "PRODUCTO"
            tipo = "produto_nome"
            cond =  ["#{tipo} LIKE ? ","%#{params[:busca]}%"] unless params[:busca].blank?
        end



        self.all(:conditions => cond,:order => 'data,id')
    end


    def before_save

        produto = Produto.find_by_id(self.produto_id)
        self.produto_nome = produto.nome
        self.clase_id     = produto.clase_id
        self.grupo_id     = produto.grupo_id

        deposito = Deposito.find_by_id(self.deposito_id)
        self.deposito_nome = deposito.nome unless self.deposito_id.blank?

    end
end
