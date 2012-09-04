class Fatura < ActiveRecord::Base

    validates_length_of   :documento_numero_01,
    :documento_numero_02, :maximum=> 3

    validates_uniqueness_of :documento_numero  , :scope=>[:documento_numero_01, :documento_numero_02]

    def self.filtro(params)

        cond =  ["data BETWEEN ? AND ? ",params[:inicio],params[:final]] unless params[:inicio].blank?

        if params[:tipo] == "STATUS"
            tipo = "status"
            cond =  ["#{tipo} = ? ","#{params[:busca]}"] unless params[:busca].blank?
        else
            tipo = "documento_numero"
            cond =  ["#{tipo} LIKE ? ","%#{params[:busca]}%"] unless params[:busca].blank?
        end

        self.all(:conditions => cond,:order => 'documento_numero_01,documento_numero_02,documento_numero')
    end

end
