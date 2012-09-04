class AdelantosProveedor < ActiveRecord::Base

    validates_presence_of :cotacao,
                          :valor_dolar,
                          :valor_guarani

    def before_save
        @doc = Documento.find_by_id(self.documento_id);
        self.documento_nome = @doc.nome.to_s;

        @conta = Conta.find_by_id(self.conta_id);
        self.conta_nome = @conta.nome.to_s;

        @prov = Persona.find_by_id(self.persona_id);
        self.persona_nome = @prov.nome.to_s;

    end

    def self.filtro(params)

        cond =  ["data BETWEEN ? AND ? ",params[:inicio],params[:final]] unless params[:inicio].blank?

        if params[:tipo] == "CODIGO"
            tipo = "id"
            cond =  ["#{tipo} = ? ","#{params[:busca]}"] unless params[:busca].blank?
        else
            tipo = "persona_nome"
            cond =  ["#{tipo} LIKE ? ","%#{params[:busca]}%"] unless params[:busca].blank?
        end

        self.all(:select => 'id,data,moeda,conta_nome,persona_nome,valor_guarani,valor_dolar',:conditions => cond,:order => 'data,id')
    end


end
