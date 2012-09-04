class OrdemServicosController < ApplicationController
    def get_moeda         #
    @moeda =  Moeda.find(:first, :conditions =>  [ "data = ?", params[:key]])
    return render :text => "<script type='text/javascript'>
                              document.getElementById('ordem_servicos_produto_cotacao').value       = '#{format("%.2f",@moeda.dolar_venda.to_f)}';
                            </script>"
  end


  def get_cliente            #
    @cliente =  Persona.find(:first, :conditions =>  [ "nome = ?", params[:persona_busca]])
    return render :text => "<script type='text/javascript'>
                              document.getElementById('ordem_servico_persona_nome').value       = '#{@cliente.nome.to_sym}';
                              document.getElementById('ordem_servico_direcao').value            = '#{@cliente.direcao.to_sym}';
                              document.getElementById('ordem_servico_telefone').value           = '#{@cliente.telefone.to_s}'
                              document.getElementById('ordem_servico_cidade').value           = '#{@cliente.cidade.to_s}'
                            </script>"
  end

  def novo_produto           #
    @ordem_servico = OrdemServico.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ordem_servico }
    end
  end

  def novo_servico           #
    @ordem_servico = OrdemServico.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ordem_servico }
    end
  end

  def servico_executado      #
    @ordem_servico = OrdemServico.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ordem_servico }
    end
  end
  #METHODS BASE-------------------------------------------------------------------

  def index                  #
    @ordem_servicos = OrdemServico.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ordem_servicos }
    end
  end

  def show                   #
    @ordem_servico = OrdemServico.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ordem_servico }
    end
  end

  def new                    #
    @ordem_servico = OrdemServico.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ordem_servico }
    end
  end
  
  def edit                   #
    @ordem_servico = OrdemServico.find(params[:id])
  end

  def create                 #
    @ordem_servico = OrdemServico.new(params[:ordem_servico])

    respond_to do |format|
      if @ordem_servico.save
        flash[:notice] = 'OrdemServico was successfully created.'
        format.html { redirect_to(@ordem_servico) }
        format.xml  { render :xml => @ordem_servico, :status => :created, :location => @ordem_servico }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ordem_servico.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update                 #
    @ordem_servico = OrdemServico.find(params[:id])

    respond_to do |format|
      if @ordem_servico.update_attributes(params[:ordem_servico])
        flash[:notice] = 'OrdemServico was successfully updated.'
        format.html { redirect_to(@ordem_servico) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ordem_servico.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy                #
    @ordem_servico = OrdemServico.find(params[:id])
    @ordem_servico.destroy

    respond_to do |format|
      format.html { redirect_to(ordem_servicos_url) }
      format.xml  { head :ok }
    end
  end
end
