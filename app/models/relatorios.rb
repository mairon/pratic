class Relatorios < ActiveRecord::Base

#RELATORIOS CONTABEIS==========================================================#

    def self.livro_compra(params)                    #

        filtro = "data BETWEEN '#{params[:inicio]}' AND  '#{params[:final]}' AND documento_id = 2 OR data BETWEEN '#{params[:inicio]}' AND  '#{params[:final]}' AND documento_id = 3"

        ComprasDocumento.all(:conditions => filtro,:order => 'data,id')
    end

    def self.livro_venda(params)                     #

        filtro = "date_part('month', data) = '#{params[:mes]}'  AND  date_part('year', data) = '#{params[:ano]}' AND documento_nome = 'FACTURA VENTA'"

        Venda.all( :select => ' id,
                                documento_numero_01,
                                documento_numero_02,
                                documento_numero,
                                documento_nome,
                                data,
                                ruc,
                                persona_nome,
                                total_guarani,
                                exentas,
                                gravada_05,
                                imposto_05,
                                gravada_10,
                                imposto_10 ',
                   :conditions => filtro,
                   :order => ' data,
                               id ' )
    end

    def self.generar_acientos_contables(params)      #

       #FILTRO MES ANO
        filtro = "date_part('month', data) = '#{params[:mes]}'  AND  date_part('year', data) = '#{params[:ano]}'"
        filtro_diferido_mes_anterior = "date_part('month', data) < '#{params[:mes]}' AND date_part('month', DIFERIDO) = '#{params[:mes]}' AND DATA <> DIFERIDO AND TIPO = 0 "
        filtro_diferido_mes = "date_part('month', data) = '#{params[:mes]}' AND date_part('month', DIFERIDO) = '#{params[:mes]}' AND DATA <> DIFERIDO AND TIPO = 0 "

       #ELIMINA LANCAMENTOS QUANDO TABELA_ID FOR NULL
        Diario.destroy_all("#{filtro}      AND TABELA_ID IS NOT NULL" )
        DiarioDebe.destroy_all("#{filtro}  AND TABELA_ID IS NOT NULL" )
        DiarioHaber.destroy_all("#{filtro} AND TABELA_ID IS NOT NULL" )




#LANCAMENTO COMPRA=============================================================================================================
        compra        = Compra.all(:conditions => filtro)
       #LOOP COMPRA
        compra.each do |cp|

           if( cp.tipo_compra == 0 )
               if ( cp.data == cp.diferido )
                             #D.PRODUTOS / H.CONTA
                   diario =  Diario.create(  :tabela_id        => cp.id.to_i,
                                             :tabela_nome      => 'COMPRA',
                                             :data             => cp.data,
                                             :cotacao          => cp.cotacao.to_f,
                                             :descricao        => 'Compra Mercareria',
                                             :documento_id     => cp.documento_id,
                                             :documento_nome   => cp.documento_nome
                                          )

                         compra_produto = ComprasProduto.all( :conditions => ["compra_id = ?", cp.id.to_i] )
                         total_iva_dolar   = 0
                         total_iva_guarani = 0

                         compra_produto.each do |cpp|
                               #BUSCA COD_CONTABIL DO PRODUTO
                                cod_contabil_produto     = Produto.find_by_id( cpp.produto_id,:select => 'id,cod_contabil' );
                               #BUSCA DESCRIPCION DO RUBRO
                                descrip_contabil_produto = PlanoDeConta.find_by_codigo( cod_contabil_produto.cod_contabil,:select => 'id,codigo,descricao' );

                               #INSERE DADOS DA COMPRAS_PRODUTOS NO DIARIO_DEBES
                                DiarioDebe.create( :tabela_id        => cpp.id.to_i,
                                                   :tabela_nome      => 'COMPRA PRODUTO',
                                                   :diario_id        => diario.id,
                                                   :data             => cp.data,
                                                   :contabilidade    => cod_contabil_produto.cod_contabil,
                                                   :descricao        => descrip_contabil_produto.descricao,
                                                   :cotacao          => cpp.cotacao.to_f,
                                                   :valor_dolar      => cpp.total_dolar - cpp.iva_dolar,
                                                   :valor_guarani    => cpp.total_guarani - cpp.iva_guarani
                                                 )
                                total_iva_dolar   = total_iva_dolar   + cpp.iva_dolar
                                total_iva_guarani = total_iva_guarani + cpp.iva_guarani

                         end
                         if total_iva_guarani > 0
                           #IVA
                            DiarioDebe.create( :tabela_id        => cp.id.to_i,
                                               :tabela_nome      => 'COMPRA PRODUTO',
                                               :diario_id        => diario.id,
                                                :data             => cp.data,
                                               :contabilidade    => '1.02.05.001',
                                               :descricao        => 'IVA CREDITO FISCAL',
                                               :valor_dolar      => total_iva_dolar,
                                               :valor_guarani    => total_iva_guarani
                                              )
                         end

                         if( cp.tipo == 0 )
                            #BUSCA COD_CONTABIL DO CONTA
                             cod_contabil_conta     = Conta.find_by_id( cp.conta_id,:select => 'id,cod_contabil' );
                            #BUSCA DESCRIPCION  DO PLANO
                             descrip_contabil_conta = PlanoDeConta.find_by_codigo( cod_contabil_conta.cod_contabil,:select => 'id,codigo,descricao' );

                            #INSERE DADOS DO CONTA NO DIARIO_HABER
                             DiarioHaber.create( :tabela_id        => cp.id.to_i,
                                                 :tabela_nome      => 'COMPRA',
                                                 :diario_id        => diario.id,
                                                 :data             => cp.data,
                                                 :contabilidade    => cod_contabil_conta.cod_contabil,
                                                 :descricao        => descrip_contabil_conta.descricao,
                                                 :cotacao          => cp.cotacao.to_f,
                                                 :valor_dolar      => cp.total_dolar,
                                                 :valor_guarani    => cp.total_guarani
                                               )
                         else
                            #BUSCA COD_CONTABIL DO PROVEEDOR
                             cod_contabil_proveedor     = Persona.find_by_id( cp.persona_id,:select => 'id,cod_contabil' );
                            #BUSCA DESCRIPCION  DO RUBRO
                             descrip_contabil_proveedor = PlanoDeConta.find_by_codigo( cod_contabil_proveedor.cod_contabil,:select => 'id,codigo,descricao' );

                            #INSERE DADOS DO PROVEEDOR NO DIARIO_HABER
                             DiarioHaber.create( :tabela_id        => cp.id.to_i,
                                                 :tabela_nome      => 'COMPRA',
                                                 :diario_id        => diario.id,
                                                 :data             => cp.data,
                                                 :contabilidade    => cod_contabil_proveedor.cod_contabil,
                                                 :descricao        => descrip_contabil_proveedor.descricao,
                                                 :cotacao          => cp.cotacao.to_f,
                                                 :valor_dolar      => cp.total_dolar,
                                                 :valor_guarani    => cp.total_guarani
                                               )

                         end
               elsif ( cp.data != cp.diferido and cp.tipo == 0 )

                                  #D.PRODUTO / H.CHEQUE DIFERIDO A PAGAR
                        diario =  Diario.create(  :tabela_id        => cp.id.to_i,
                                                  :tabela_nome      => 'COMPRA',
                                                  :data             => cp.data,
                                                  :cotacao          => cp.cotacao.to_f,
                                                  :descricao        => 'Compra Mercareria - Diferido' ,
                                                  :documento_id     => cp.documento_id,
                                                  :documento_nome   => cp.documento_nome
                                               )

                        compra_produto = ComprasProduto.all( :conditions => ["compra_id = ?", cp.id.to_i] )
                        total_iva_dolar   = 0
                        total_iva_guarani = 0
                        #LOOP COMPRAS_PRODUTOS
                        compra_produto.each do |cpp|

                               cod_contabil_produto     = Produto.find_by_id( cpp.produto_id,:select => 'id,cod_contabil' );

                               descrip_contabil_produto = PlanoDeConta.find_by_codigo( cod_contabil_produto.cod_contabil,:select => 'id,codigo,descricao' );

                               DiarioDebe.create( :tabela_id        => cpp.id.to_i,
                                                  :tabela_nome      => 'COMPRA PRODUTO',
                                                  :diario_id        => diario.id,
                                                  :data             => cp.data,
                                                  :contabilidade    => cod_contabil_produto.cod_contabil,
                                                  :descricao        => descrip_contabil_produto.descricao,
                                                  :cotacao          => cpp.cotacao.to_f,
                                                  :valor_dolar      => cpp.total_dolar - cpp.iva_dolar,
                                                  :valor_guarani    => cpp.total_guarani - cpp.iva_guarani
                                                )
                                total_iva_dolar   = total_iva_dolar   + cpp.iva_dolar
                                total_iva_guarani = total_iva_guarani + cpp.iva_guarani

                         end
                                if total_iva_guarani > 0
                                  #IVA
                                   DiarioDebe.create( :tabela_id        => cp.id.to_i,
                                                      :tabela_nome      => 'COMPRA PRODUTO',
                                                      :diario_id        => diario.id,
                                                      :data             => cp.data,
                                                      :contabilidade    => '1.02.05.001',
                                                      :descricao        => 'IVA CREDITO FISCAL',
                                                      :valor_dolar      => total_iva_dolar,
                                                      :valor_guarani    => total_iva_guarani
                                                     )
                                end


                               cod_contabil_conta     = "2.04.01.001"
                               descrip_contabil_conta = PlanoDeConta.find_by_codigo( cod_contabil_conta,:select => 'id,codigo,descricao' );

                               DiarioHaber.create( :tabela_id        => cp.id.to_i,
                                                   :tabela_nome      => 'COMPRA',
                                                   :diario_id        => diario.id,
                                                   :data             => cp.data,
                                                   :contabilidade    => cod_contabil_conta,
                                                   :descricao        => descrip_contabil_conta.descricao,
                                                   :cotacao          => cp.cotacao.to_f,
                                                   :valor_dolar      => cp.total_dolar,
                                                   :valor_guarani    => cp.total_guarani
                                                 )

              end
           end


#LANCAMENTO GASTOS=============================================================================================================

           if( cp.tipo_compra == 1 )
                  if ( cp.data == cp.diferido )
                                 #D.RUBRO / H.CONTA
                       diario =  Diario.create(  :tabela_id        => cp.id.to_i,
                                                 :tabela_nome      => 'COMPRA',
                                                 :data             => cp.data,
                                                 :cotacao          => cp.cotacao.to_f,
                                                 :descricao        => 'GASTOS',
                                                 :documento_id     => cp.documento_id,
                                                 :documento_nome   => cp.documento_nome
                                              )


                                   total_iva_dolar   = 0
                                   total_iva_guarani = 0

                                   #BUSCA DESCRIPCION DO RUBRO

                                   #INSERE DADOS DA COMPRAS_PRODUTOS NO DIARIO_DEBES
                                    DiarioDebe.create( :tabela_id        => cp.id.to_i,
                                                       :tabela_nome      => 'COMPRA',
                                                       :diario_id        => diario.id,
                                                       :data             => cp.data,
                                                       :contabilidade    => cp.rubro_cod_contabil,
                                                       :descricao        => cp.rubro_descricao,
                                                       :cotacao          => cp.cotacao.to_f,
                                                       :valor_dolar      => ( cp.total_dolar - cp.iva_total_dolar ),
                                                       :valor_guarani    => ( cp.total_guarani - cp.iva_total_guarani )
                                                     )
                                    total_iva_dolar   = total_iva_dolar   + cp.iva_total_dolar
                                    total_iva_guarani = total_iva_guarani + cp.iva_total_guarani
                                    if total_iva_guarani > 0
                                      #IVA
                                       DiarioDebe.create( :tabela_id        => cp.id.to_i,
                                                          :tabela_nome      => 'COMPRA PRODUTO',
                                                          :diario_id        => diario.id,
                                                          :data             => cp.data,
                                                          :contabilidade    => '1.02.05.001',
                                                          :descricao        => 'IVA CREDITO FISCAL',
                                                          :valor_dolar      => total_iva_dolar,
                                                          :valor_guarani    => total_iva_guarani
                                                     )
                                  end
                             #VERIFICA SE CREDITO OU CONTADO
                             if( cp.tipo == 0 )
                                #BUSCA COD_CONTABIL DO CONTA
                                 cod_contabil_conta     = Conta.find_by_id( cp.conta_id,:select => 'id,cod_contabil' );
                                #BUSCA DESCRIPCION  DO RUBRO
                                 descrip_contabil_conta = PlanoDeConta.find_by_codigo( cod_contabil_conta.cod_contabil,:select => 'id,codigo,descricao' );

                                #INSERE DADOS DO CONTA NO DIARIO_HABER
                                 DiarioHaber.create( :tabela_id        => cp.id.to_i,
                                                     :tabela_nome      => 'COMPRA',
                                                     :diario_id        => diario.id,
                                                     :data             => cp.data,
                                                     :contabilidade    => cod_contabil_conta.cod_contabil,
                                                     :descricao        => descrip_contabil_conta.descricao,
                                                     :cotacao          => cp.cotacao.to_f,
                                                     :valor_dolar      => cp.total_dolar,
                                                     :valor_guarani    => cp.total_guarani
                                                   )
                             else
                                #BUSCA COD_CONTABIL DO PROVEEDOR
                                 cod_contabil_proveedor     = Persona.find_by_id( cp.persona_id,:select => 'id,cod_contabil' );
                                #BUSCA DESCRIPCION  DO RUBRO
                                 descrip_contabil_proveedor = PlanoDeConta.find_by_codigo( cod_contabil_proveedor.cod_contabil,:select => 'id,codigo,descricao' );

                                #INSERE DADOS DO PROVEEDOR NO DIARIO_HABER
                                 DiarioHaber.create( :tabela_id        => cp.id.to_i,
                                                     :tabela_nome      => 'COMPRA',
                                                     :diario_id        => diario.id,
                                                     :data             => cp.data,
                                                     :contabilidade    => cod_contabil_proveedor.cod_contabil,
                                                     :descricao        => descrip_contabil_proveedor.descricao,
                                                     :cotacao          => cp.cotacao.to_f,
                                                     :valor_dolar      => cp.total_dolar,
                                                     :valor_guarani    => cp.total_guarani
                                                   )

                             end
                   end

                     if ( cp.data != cp.diferido )
                          if( cp.tipo == 0 )
                                    #D.RUBRO / H.CHEQUE DIFERIDO A PAGAR
                          diario =  Diario.create(  :tabela_id        => cp.id.to_i,
                                                    :tabela_nome      => 'COMPRA',
                                                    :data             => cp.data,
                                                    :cotacao          => cp.cotacao.to_f,
                                                    :descricao        => 'Compra Gastos - Diferido' ,
                                                    :documento_id     => cp.documento_id,
                                                    :documento_nome   => cp.documento_nome
                                                 )

                                   total_iva_dolar   = 0
                                   total_iva_guarani = 0

                                   #BUSCA DESCRIPCION DO RUBRO

                                   #INSERE DADOS DA COMPRAS_PRODUTOS NO DIARIO_DEBES
                                    DiarioDebe.create( :tabela_id        => cp.id.to_i,
                                                       :tabela_nome      => 'COMPRA',
                                                       :diario_id        => diario.id,
                                                       :data             => cp.data,
                                                       :contabilidade    => cp.rubro_cod_contabil,
                                                       :descricao        => cp.rubro_descricao,
                                                       :cotacao          => cp.cotacao.to_f,
                                                       :valor_dolar      => ( cp.total_dolar - cp.iva_total_dolar ),
                                                       :valor_guarani    => ( cp.total_guarani - cp.iva_total_guarani )
                                                     )
                                    total_iva_dolar   = total_iva_dolar   + cp.iva_total_dolar
                                    total_iva_guarani = total_iva_guarani + cp.iva_total_guarani
                                    if total_iva_guarani > 0
                                      #IVA
                                       DiarioDebe.create( :tabela_id        => cp.id.to_i,
                                                          :tabela_nome      => 'COMPRA PRODUTO',
                                                          :diario_id        => diario.id,
                                                          :data             => cp.data,
                                                          :contabilidade    => '1.02.05.001',
                                                          :descricao        => 'IVA CREDITO FISCAL',
                                                          :valor_dolar      => total_iva_dolar,
                                                          :valor_guarani    => total_iva_guarani
                                                     )
                                  end


                                   cod_contabil_conta     = "2.04.01.001"
                                   descrip_contabil_conta = PlanoDeConta.find_by_codigo( cod_contabil_conta,:select => 'id,codigo,descricao' );

                                   DiarioHaber.create( :tabela_id        => cp.id.to_i,
                                                       :tabela_nome      => 'COMPRA',
                                                       :diario_id        => diario.id,
                                                       :data             => cp.data,
                                                       :contabilidade    => cod_contabil_conta,
                                                       :descricao        => descrip_contabil_conta.descricao,
                                                       :cotacao          => cp.cotacao.to_f,
                                                       :valor_dolar      => cp.total_dolar,
                                                       :valor_guarani    => cp.total_guarani
                                                     )
                     end
               end
           end
        end


           compra_df_mes = Compra.all(:conditions => filtro_diferido_mes)
                           compra_df_mes.each do |cpm|
                                         if ( cpm.tipo_compra == 0 )
                                                    #D.CHEQUE DIFERIDO A PAGAR / H.CONTA NA DATA DIFERIDA
                                                   diario =  Diario.create( :tabela_id        => cpm.id.to_i,
                                                                            :tabela_nome      => 'COMPRA',
                                                                            :data             => cpm.diferido,
                                                                            :cotacao          => cpm.cotacao.to_f,
                                                                            :descricao        => 'Compra Mercareria - Diferido' ,
                                                                            :documento_id     => cpm.documento_id,
                                                                            :documento_nome   => cpm.documento_nome
                                                                           )

                                                   cod_contabil_conta     = "2.04.01.001"
                                                   descrip_contabil_conta = PlanoDeConta.find_by_codigo( cod_contabil_conta,:select => 'id,codigo,descricao' );

                                                   DiarioDebe.create( :tabela_id        => cpm.id.to_i,
                                                                      :tabela_nome      => 'COMPRA',
                                                                      :diario_id        => diario.id,
                                                                      :data             => cpm.diferido,
                                                                      :contabilidade    => cod_contabil_conta,
                                                                      :descricao        => descrip_contabil_conta.descricao,
                                                                      :cotacao          => cpm.cotacao.to_f,
                                                                      :valor_dolar      => cpm.total_dolar,
                                                                      :valor_guarani    => cpm.total_guarani
                                                                    )

                                                   cod_contabil_conta     = Conta.find_by_id( cpm.conta_id,:select => 'id,cod_contabil' );
                                                   descrip_contabil_conta = PlanoDeConta.find_by_codigo( cod_contabil_conta.cod_contabil,:select => 'id,codigo,descricao' );
                                                   DiarioHaber.create( :tabela_id        => cpm.id.to_i,
                                                                       :tabela_nome      => 'COMPRA',
                                                                       :diario_id        => diario.id,
                                                                       :data             => cpm.diferido,
                                                                       :contabilidade    => cod_contabil_conta.cod_contabil,
                                                                       :descricao        => descrip_contabil_conta.descricao,
                                                                       :cotacao          => cpm.cotacao.to_f,
                                                                       :valor_dolar      => cpm.total_dolar,
                                                                       :valor_guarani    => cpm.total_guarani
                                                                     )

                                         end


                       end

           compra_df_ant = Compra.all(:conditions => filtro_diferido_mes_anterior)
                           compra_df_ant.each do |cpma|
                                         if ( cpma.tipo_compra == 0 )
                                                   #D.CHEQUE DIFERIDO A PAGAR / H.CONTA NA DATA DIFERIDA
                                                   diario =  Diario.create( :tabela_id        => cpma.id.to_i,
                                                                            :tabela_nome      => 'COMPRA',
                                                                            :data             => cpma.diferido,
                                                                            :cotacao          => cpma.cotacao.to_f,
                                                                            :descricao        => 'Compra Mercareria - Diferido' ,
                                                                            :documento_id     => cpma.documento_id,
                                                                            :documento_nome   => cpma.documento_nome
                                                                           )

                                                   cod_contabil_conta     = "2.04.01.001"
                                                   descrip_contabil_conta = PlanoDeConta.find_by_codigo( cod_contabil_conta,:select => 'id,codigo,descricao' );

                                                   DiarioDebe.create( :tabela_id        => cpma.id.to_i,
                                                                      :tabela_nome      => 'COMPRA',
                                                                      :diario_id        => diario.id,
                                                                      :data             => cpma.diferido,
                                                                      :contabilidade    => cod_contabil_conta,
                                                                      :descricao        => descrip_contabil_conta.descricao,
                                                                      :cotacao          => cpma.cotacao.to_f,
                                                                      :valor_dolar      => cpma.total_dolar,
                                                                      :valor_guarani    => cpma.total_guarani
                                                                    )

                                                   cod_contabil_conta     = Conta.find_by_id( cpma.conta_id,:select => 'id,cod_contabil' );
                                                   descrip_contabil_conta = PlanoDeConta.find_by_codigo( cod_contabil_conta.cod_contabil,:select => 'id,codigo,descricao' );
                                                   DiarioHaber.create( :tabela_id        => cpma.id.to_i,
                                                                       :tabela_nome      => 'COMPRA',
                                                                       :diario_id        => diario.id,
                                                                       :data             => cpma.diferido,
                                                                       :contabilidade    => cod_contabil_conta.cod_contabil,
                                                                       :descricao        => descrip_contabil_conta.descricao,
                                                                       :cotacao          => cpma.cotacao.to_f,
                                                                       :valor_dolar      => cpma.total_dolar,
                                                                       :valor_guarani    => cpma.total_guarani
                                                                     )

                                         end

                    end

           compra_df_mes = Compra.all(:conditions => filtro_diferido_mes)
                           compra_df_mes.each do |cpm|
                                         if ( cpm.tipo_compra == 1 )
                                                    #D.CHEQUE DIFERIDO A PAGAR / H.CONTA NA DATA DIFERIDA
                                                   diario =  Diario.create( :tabela_id        => cpm.id.to_i,
                                                                            :tabela_nome      => 'COMPRA',
                                                                            :data             => cpm.diferido,
                                                                            :cotacao          => cpm.cotacao.to_f,
                                                                            :descricao        => 'Compra Mercareria - Diferido' ,
                                                                            :documento_id     => cpm.documento_id,
                                                                            :documento_nome   => cpm.documento_nome
                                                                           )

                                                   cod_contabil_conta     = "2.04.01.001"
                                                   descrip_contabil_conta = PlanoDeConta.find_by_codigo( cod_contabil_conta,:select => 'id,codigo,descricao' );

                                                   DiarioDebe.create( :tabela_id        => cpm.id.to_i,
                                                                      :tabela_nome      => 'COMPRA',
                                                                      :diario_id        => diario.id,
                                                                      :data             => cpm.diferido,
                                                                      :contabilidade    => cod_contabil_conta,
                                                                      :descricao        => descrip_contabil_conta.descricao,
                                                                      :cotacao          => cpm.cotacao.to_f,
                                                                      :valor_dolar      => cpm.total_dolar,
                                                                      :valor_guarani    => cpm.total_guarani
                                                                    )

                                                   cod_contabil_conta     = Conta.find_by_id( cpm.conta_id,:select => 'id,cod_contabil' );
                                                   descrip_contabil_conta = PlanoDeConta.find_by_codigo( cod_contabil_conta.cod_contabil,:select => 'id,codigo,descricao' );
                                                   DiarioHaber.create( :tabela_id        => cpm.id.to_i,
                                                                       :tabela_nome      => 'COMPRA',
                                                                       :diario_id        => diario.id,
                                                                       :data             => cpm.diferido,
                                                                       :contabilidade    => cod_contabil_conta.cod_contabil,
                                                                       :descricao        => descrip_contabil_conta.descricao,
                                                                       :cotacao          => cpm.cotacao.to_f,
                                                                       :valor_dolar      => cpm.total_dolar,
                                                                       :valor_guarani    => cpm.total_guarani
                                                                     )

                                         end


                       end

           compra_df_ant = Compra.all(:conditions => filtro_diferido_mes_anterior)
                           compra_df_ant.each do |cpma|
                                         if ( cpma.tipo_compra == 1 )
                                                   #D.CHEQUE DIFERIDO A PAGAR / H.CONTA NA DATA DIFERIDA
                                                   diario =  Diario.create( :tabela_id        => cpma.id.to_i,
                                                                            :tabela_nome      => 'COMPRA',
                                                                            :data             => cpma.diferido,
                                                                            :cotacao          => cpma.cotacao.to_f,
                                                                            :descricao        => 'Compra Mercareria - Diferido' ,
                                                                            :documento_id     => cpma.documento_id,
                                                                            :documento_nome   => cpma.documento_nome
                                                                           )

                                                   cod_contabil_conta     = "2.04.01.001"
                                                   descrip_contabil_conta = PlanoDeConta.find_by_codigo( cod_contabil_conta,:select => 'id,codigo,descricao' );

                                                   DiarioDebe.create( :tabela_id        => cpma.id.to_i,
                                                                      :tabela_nome      => 'COMPRA',
                                                                      :diario_id        => diario.id,
                                                                      :data             => cpma.diferido,
                                                                      :contabilidade    => cod_contabil_conta,
                                                                      :descricao        => descrip_contabil_conta.descricao,
                                                                      :cotacao          => cpma.cotacao.to_f,
                                                                      :valor_dolar      => cpma.total_dolar,
                                                                      :valor_guarani    => cpma.total_guarani
                                                                    )

                                                   cod_contabil_conta     = Conta.find_by_id( cpma.conta_id,:select => 'id,cod_contabil' );
                                                   descrip_contabil_conta = PlanoDeConta.find_by_codigo( cod_contabil_conta.cod_contabil,:select => 'id,codigo,descricao' );
                                                   DiarioHaber.create( :tabela_id        => cpma.id.to_i,
                                                                       :tabela_nome      => 'COMPRA',
                                                                       :diario_id        => diario.id,
                                                                       :data             => cpma.diferido,
                                                                       :contabilidade    => cod_contabil_conta.cod_contabil,
                                                                       :descricao        => descrip_contabil_conta.descricao,
                                                                       :cotacao          => cpma.cotacao.to_f,
                                                                       :valor_dolar      => cpma.total_dolar,
                                                                       :valor_guarani    => cpma.total_guarani
                                                                     )

                                         end

                    end




#LANCAMENTO PAGOS=============================================================================================================

        pagos     = Pago.all(:conditions => filtro)

        pagos.each do |pg|
           diario =  Diario.create(  :tabela_id        => pg.id.to_i,
                                     :tabela_nome      => 'PAGOS',
                                     :data             => pg.data,
                                     :cotacao          => pg.cotacao.to_f,
                                     :descricao        => 'PAGO PROVEEDOR '+ pg.persona_nome,
                                     :documento_id     => pg.documento_id,
                                     :documento_nome   => pg.documento_nome
                                  )

          #BUSCA COD_CONTABIL DO PROVEEDOR
           cod_contabil_proveedor     = Persona.find_by_id( pg.persona_id,:select => 'id,cod_contabil' );
          #BUSCA DESCRIPCION  DO RUBRO
           descrip_contabil_proveedor = PlanoDeConta.find_by_codigo( cod_contabil_proveedor.cod_contabil,:select => 'id,codigo,descricao' );

          #INSERE DADOS DO PROVEEDOR NO DIARIO_HABER
           DiarioDebe.create(  :tabela_id        => pg.id.to_i,
                               :tabela_nome      => 'PAGOS',
                               :diario_id        => diario.id,
                               :data             => pg.data,
                               :contabilidade    => cod_contabil_proveedor.cod_contabil,
                               :descricao        => descrip_contabil_proveedor.descricao,
                               :cotacao          => pg.cotacao.to_f,
                               :valor_dolar      => pg.valor_dolar,
                               :valor_guarani    => pg.valor_guarani
                             )
                        #BUSCA COD_CONTABIL DO CONTA
                         cod_contabil_conta     = Conta.find_by_id( pg.conta_id,:select => 'id,cod_contabil' );
                        #BUSCA DESCRIPCION  DO RUBRO
                         descrip_contabil_conta = PlanoDeConta.find_by_codigo( cod_contabil_conta.cod_contabil,:select => 'id,codigo,descricao' );

                        #INSERE DADOS DO CONTA NO DIARIO_HABER
                         DiarioHaber.create( :tabela_id        => pg.id.to_i,
                                             :tabela_nome      => 'COMPRA',
                                             :diario_id        => diario.id,
                                             :data             => pg.data,
                                             :contabilidade    => cod_contabil_conta.cod_contabil,
                                             :descricao        => descrip_contabil_conta.descricao,
                                             :cotacao          => pg.cotacao.to_f,
                                             :valor_dolar      => pg.valor_dolar,
                                             :valor_guarani    => pg.valor_guarani
                                           )



        end

#LANCAMENTO COBROS=============================================================================================================

        cobros    = Cobro.all(:conditions => filtro)

        cobros.each do |cb|
           diario =  Diario.create(  :tabela_id        => cb.id.to_i,
                                     :tabela_nome      => 'COBROS',
                                     :data             => cb.data,
                                     :cotacao          => cb.cotacao.to_f,
                                     :descricao        => 'COBRO CLIENTE '+ cb.persona_nome,
                                     :documento_id     => cb.documento_id,
                                     :documento_nome   => cb.documento_nome
                                  )

                        #BUSCA COD_CONTABIL DO CONTA
                         cod_contabil_conta     = Conta.find_by_id( cb.conta_id,:select => 'id,cod_contabil' );
                        #BUSCA DESCRIPCION  DO RUBRO
                         descrip_contabil_conta = PlanoDeConta.find_by_codigo( cod_contabil_conta.cod_contabil,:select => 'id,codigo,descricao' );

                        #INSERE DADOS DO CONTA NO DIARIO_HABER
                         DiarioDebe.create(  :tabela_id        => cb.id.to_i,
                                             :tabela_nome      => 'COBROS',
                                             :diario_id        => diario.id,
                                             :data             => cb.data,
                                             :contabilidade    => cod_contabil_conta.cod_contabil,
                                             :descricao        => descrip_contabil_conta.descricao,
                                             :cotacao          => cb.cotacao.to_f,
                                             :valor_dolar      => cb.valor_dolar,
                                             :valor_guarani    => cb.valor_guarani
                                           )


          #BUSCA COD_CONTABIL DO PROVEEDOR
           cod_contabil_proveedor     = Persona.find_by_id( cb.persona_id,:select => 'id,cod_contabil' );
          #BUSCA DESCRIPCION  DO RUBRO
           descrip_contabil_proveedor = PlanoDeConta.find_by_codigo( cod_contabil_proveedor.cod_contabil,:select => 'id,codigo,descricao' );

          #INSERE DADOS DO PROVEEDOR NO DIARIO_HABER
           DiarioHaber.create( :tabela_id        => cb.id.to_i,
                               :tabela_nome      => 'COBROS',
                               :diario_id        => diario.id,
                               :data             => cb.data,
                               :contabilidade    => cod_contabil_proveedor.cod_contabil,
                               :descricao        => descrip_contabil_proveedor.descricao,
                               :cotacao          => cb.cotacao.to_f,
                               :valor_dolar      => cb.valor_dolar,
                               :valor_guarani    => cb.valor_guarani
                             )

        end

#LANCAMENTO VENDAS=============================================================================================================
        vendas        = Venda.all( :conditions =>  filtro )  #+ ' AND documento_id = 9' )

        vendas.each do |vd|
               diario =  Diario.create(  :tabela_id        => vd.id.to_i,
                                         :tabela_nome      => 'VENTAS',
                                         :data             => vd.data,
                                         :cotacao          => vd.cotacao.to_f,
                                         :descricao        => 'VENTA CLIENTE',
                                         :documento_id     => vd.documento_id,
                                         :documento_nome   => vd.documento_nome
                                      )

              #AO CONTADO=======================================================
               if( vd.tipo == 0 && vd.tipo_ordem == 0 )
                  #BUSCA COD_CONTABIL DA CONTA
                   cod_contabil_conta     = Conta.find_by_id( vd.conta_id,:select => 'id,cod_contabil' );
                  #BUSCA DESCRIPCION  DO RUBRO
                   descrip_contabil_conta = PlanoDeConta.find_by_codigo( cod_contabil_conta.cod_contabil,:select => 'id,codigo,descricao' );


                  #INSERE DADOS DO CONTA NO DIARIO_DEBE
                   DiarioDebe.create(  :tabela_id        => vd.id.to_i,
                                       :tabela_nome      => 'VENTAS',
                                       :diario_id        => diario.id,
                                       :data             => vd.data,
                                       :contabilidade    => cod_contabil_conta.cod_contabil,
                                       :descricao        => descrip_contabil_conta.descricao,
                                       :cotacao          => vd.cotacao.to_f,
                                       :valor_dolar      => vd.total_dolar,
                                       :valor_guarani    => vd.total_guarani
                                     )

              #AO CREDITO=======================================================
               elsif( vd.tipo == 1 && vd.tipo_ordem == 0 )

                     #BUSCA COD_CONTABIL DO PERSONA
                      cod_contabil_cliente     = Persona.find_by_id( vd.persona_id,:select => 'id,cod_contabil' );
                     #BUSCA DESCRIPCION  DO PLANO DE CONTA
                      descrip_contabil_cliente = PlanoDeConta.find_by_codigo( cod_contabil_cliente.cod_contabil,:select => 'id,codigo,descricao' );

                    #INSERE DADOS DO CLIENTE NO DIARIO_DEBE
                      DiarioDebe.create(  :tabela_id        => vd.id.to_i,
                                          :tabela_nome      => 'VENTAS',
                                          :diario_id        => diario.id,
                                          :data             => vd.data,
                                          :contabilidade    => '1.02.01.003',
                                          :descricao        => 'OTROS CLIENTES',
                                          :cotacao          => vd.cotacao.to_f,
                                          :valor_dolar      => vd.total_dolar,
                                          :valor_guarani    => vd.total_guarani
                                        )

              #AO CREDITO ORDEM=================================================
               elsif( vd.tipo == 1 && vd.tipo_ordem == 1 )

                     #INSERE DADOS DO CLIENTE NO DIARIO_DEBE
                      DiarioDebe.create(  :tabela_id        => vd.id.to_i,
                                          :tabela_nome      => 'VENTAS',
                                          :diario_id        => diario.id,
                                          :data             => vd.data,
                                          :contabilidade    => '1.02.01.001',
                                          :descricao        => 'AGROEXPRESS S.A.',
                                          :cotacao          => vd.cotacao.to_f,
                                          :valor_dolar      => vd.total_dolar,
                                          :valor_guarani    => vd.total_guarani
                                        )

               end

               venda_produto = VendasProduto.all( :conditions => ["venda_id = ?", vd.id.to_i] )

               total_iva_dolar   = 0
               total_iva_guarani = 0
              #LOOP VENDAS_PRODUTOS - VENDAS
               venda_produto.each do |vpp|

                     #INSERE DADOS DA VENDAS_PRODUTOS NO DIARIO_DEBES
                      cod_contabil_produto = '4.01.01.001';
                      descrip_contabil_produto = PlanoDeConta.find_by_codigo( cod_contabil_produto,:select => 'id,codigo,descricao' );

                      DiarioHaber.create( :tabela_id        => vpp.id.to_i,
                                          :tabela_nome      => 'VENTA PRODUTO',
                                          :diario_id        => diario.id,
                                          :data             => vd.data,
                                          :contabilidade    => cod_contabil_produto,
                                          :descricao        => descrip_contabil_produto.descricao,
                                          :cotacao          => vpp.cotacao.to_f,
                                          :valor_dolar      => ( vpp.total_dolar - vpp.iva_dolar) ,
                                          :valor_guarani    => ( vpp.total_guarani - vpp.iva_guarani )
                                       )
                      total_iva_dolar   = total_iva_dolar   + vpp.iva_dolar
                      total_iva_guarani = total_iva_guarani + vpp.iva_guarani

               end

               if total_iva_guarani > 0
                  #IVA
                  DiarioHaber.create( :tabela_id        => vd.id.to_i,
                                      :tabela_nome      => 'VENTA PRODUTO',
                                      :diario_id        => diario.id,
                                      :data             => vd.data,
                                      :contabilidade    => '0.00.00.000',
                                      :descricao        => 'IVA COMPRA',
                                      :valor_dolar      => total_iva_dolar,
                                      :valor_guarani    => total_iva_guarani
                                    )
               end

              #LOOP VENDAS_PRODUTOS - COSTOS

               venda_produto.each do |vpp|

                      suma_entrada        = Stock.sum(:entrada, :conditions => ["produto_id = #{vpp.produto_id} AND data <= '#{vd.data}'"])
                      suma_custo_dolar    = Stock.sum('( entrada * custo_contabil_dolar )', :conditions => ["produto_id = #{vpp.produto_id} AND data <= '#{vd.data}'"])
                      suma_custo_guarani  = Stock.sum('( entrada * custo_contabil_guarani )', :conditions => ["produto_id = #{vpp.produto_id} AND data <= '#{vd.data}'"])

                      stock_custo_dolar   = ( suma_custo_dolar.to_f / suma_entrada.to_f )
                      stock_custo_guarani = ( suma_custo_guarani.to_f / suma_entrada.to_f )

                      valor_dolar   = ( vpp.quantidade * stock_custo_dolar ).round(2);
                      valor_guarani = ( vpp.quantidade * stock_custo_guarani ).round(0);

                      diario =  Diario.create(  :tabela_id        => vd.id.to_i,
                                                :tabela_nome      => 'STOCK',
                                                :data             => vd.data,
                                                :cotacao          => vd.cotacao.to_f,
                                                :descricao        => 'COSTO DE VENTAS',
                                                :documento_id     => vd.documento_id,
                                                :documento_nome   => vd.documento_nome
                                             )

                      cod_contabil_produto = '5.01.01.001';
                      descrip_contabil_produto = PlanoDeConta.find_by_codigo( cod_contabil_produto,:select => 'id,codigo,descricao' );

                      DiarioDebe.create( :tabela_id        => vpp.id.to_i,
                                         :tabela_nome      => 'STOCK',
                                         :diario_id        => diario.id,
                                         :data             => vd.data,
                                         :contabilidade    => cod_contabil_produto,
                                         :descricao        => descrip_contabil_produto.descricao,
                                         :cotacao          => vpp.cotacao.to_f,
                                         :valor_dolar      => valor_dolar,
                                         :valor_guarani    => valor_guarani
                                       )

                      cod_contabil_produto     = Produto.find_by_id( vpp.produto_id,:select => 'id,cod_contabil' );
                      descrip_contabil_produto = PlanoDeConta.find_by_codigo( cod_contabil_produto.cod_contabil,:select => 'id,codigo,descricao' );


                      DiarioHaber.create( :tabela_id        => vpp.id.to_i,
                                          :tabela_nome      => 'STOCK',
                                          :diario_id        => diario.id,
                                          :data             => vd.data,
                                          :contabilidade    => cod_contabil_produto.cod_contabil,
                                          :descricao        => descrip_contabil_produto.descricao,
                                          :cotacao          => vpp.cotacao.to_f,
                                          :valor_dolar      => valor_dolar,
                                          :valor_guarani    => valor_guarani
                                        )

               end

               if( vd.tipo == 0 && vd.tipo_ordem == 0 )

                   if ( vd.data != vd.diferido )

                        diario =  Diario.create(  :tabela_id        => vd.id.to_i,
                                                  :tabela_nome      => 'VENTAS',
                                                  :data             => vd.data,
                                                  :cotacao          => vd.cotacao.to_f,
                                                  :descricao        => 'VENTA CLIENTE - DIFERIDO',
                                                  :documento_id     => vd.documento_id,
                                                  :documento_nome   => vd.documento_nome
                                               )

                       cod_contabil_conta     = Conta.find_by_id( vd.conta_id,:select => 'id,cod_contabil' );
                       descrip_contabil_conta = PlanoDeConta.find_by_codigo( cod_contabil_conta.cod_contabil,:select => 'id,codigo,descricao' );

                       DiarioHaber.create( :tabela_id        => vd.id.to_i,
                                           :tabela_nome      => 'VENTAS',
                                           :diario_id        => diario.id,
                                           :data             => vd.data,
                                           :contabilidade    => cod_contabil_conta.cod_contabil,
                                           :descricao        => descrip_contabil_conta.descricao,
                                           :cotacao          => vd.cotacao.to_f,
                                           :valor_dolar      => vd.total_dolar,
                                           :valor_guarani    => vd.total_guarani
                                         )

                       cod_contabil_conta     = "1.02.02.002"
                       descrip_contabil_conta = PlanoDeConta.find_by_codigo( cod_contabil_conta,:select => 'id,codigo,descricao' );

                       DiarioDebe.create( :tabela_id        => vd.id.to_i,
                                           :tabela_nome      => 'VENTAS',
                                           :diario_id        => diario.id,
                                           :data             => vd.data,
                                           :contabilidade    => cod_contabil_conta,
                                           :descricao        => descrip_contabil_conta.descricao,
                                           :cotacao          => vd.cotacao.to_f,
                                           :valor_dolar      => vd.total_dolar,
                                           :valor_guarani    => vd.total_guarani
                                         )

                        diario =  Diario.create(  :tabela_id        => vd.id.to_i,
                                                  :tabela_nome      => 'VENTAS',
                                                  :data             => vd.diferido,
                                                  :cotacao          => vd.cotacao.to_f,
                                                  :descricao        => 'VENTA CLIENTE - DIFERIDO',
                                                  :documento_id     => vd.documento_id,
                                                  :documento_nome   => vd.documento_nome
                                               )

                       cod_contabil_conta     = "1.02.02.002"
                       descrip_contabil_conta = PlanoDeConta.find_by_codigo( cod_contabil_conta,:select => 'id,codigo,descricao' );

                       DiarioHaber.create( :tabela_id        => vd.id.to_i,
                                           :tabela_nome      => 'VENTAS',
                                           :diario_id        => diario.id,
                                           :data             => vd.diferido,
                                           :contabilidade    => cod_contabil_conta,
                                           :descricao        => descrip_contabil_conta.descricao,
                                           :cotacao          => vd.cotacao.to_f,
                                           :valor_dolar      => vd.total_dolar,
                                           :valor_guarani    => vd.total_guarani
                                         )

                       cod_contabil_conta     = Conta.find_by_id( vd.conta_id,:select => 'id,cod_contabil' );
                       descrip_contabil_conta = PlanoDeConta.find_by_codigo( cod_contabil_conta.cod_contabil,:select => 'id,codigo,descricao' );

                       DiarioDebe.create( :tabela_id        => vd.id.to_i,
                                           :tabela_nome      => 'VENTAS',
                                           :diario_id        => diario.id,
                                           :data             => vd.diferido,
                                           :contabilidade    => cod_contabil_conta.cod_contabil,
                                           :descricao        => descrip_contabil_conta.descricao,
                                           :cotacao          => vd.cotacao.to_f,
                                           :valor_dolar      => vd.total_dolar,
                                           :valor_guarani    => vd.total_guarani
                                         )

                   end
               end
        end

#LANCAMENTO INGRESSOS=============================================================================================================

        ingresso    = Ingresso.all(:conditions => filtro)

        ingresso.each do |ig|
           diario =  Diario.create(  :tabela_id        => ig.id.to_i,
                                     :tabela_nome      => 'INGRESSOS',
                                     :data             => ig.data,
                                     :cotacao          => ig.cotacao.to_f,
                                     :descricao        => ig.concepto,
                                     :documento_id     => ig.documento_id,
                                     :documento_nome   => ig.documento_nome
                                  )

                        #BUSCA COD_CONTABIL DO RUBRO
                         cod_contabil_rubro     = Rubro.find_by_id( ig.rubro_id,:select => 'id,codigo' );
                        #BUSCA DESCRIPCION  DO RUBRO
                         descrip_contabil_rubro = PlanoDeConta.find_by_codigo( cod_contabil_rubro.codigo,:select => 'id,codigo,descricao' );

                        #INSERE DADOS DO RUBRO NO DIARIO_HABER
                         DiarioHaber.create( :tabela_id        => ig.id.to_i,
                                             :tabela_nome      => 'INGRESSOS',
                                             :diario_id        => diario.id,
                                             :data             => ig.data,
                                             :contabilidade    => cod_contabil_rubro.codigo,
                                             :descricao        => descrip_contabil_rubro.descricao,
                                             :cotacao          => ig.cotacao.to_f,
                                             :valor_dolar      => ig.valor_dolar,
                                             :valor_guarani    => ig.valor_guarani
                                           )


                        #BUSCA COD_CONTABIL DA CONTA
                         cod_contabil_conta     = Conta.find_by_id( ig.conta_id,:select => 'id,cod_contabil' );
                        #BUSCA DESCRIPCION  DA CONTA
                         descrip_contabil_conta = PlanoDeConta.find_by_codigo( cod_contabil_conta.cod_contabil,:select => 'id,codigo,descricao' );

                        #INSERE DADOS DO CONTA NO DIARIO_HABER
                         DiarioDebe.create(  :tabela_id        => ig.id.to_i,
                                             :tabela_nome      => 'INGRESSOS',
                                             :diario_id        => diario.id,
                                             :data             => ig.data,
                                             :contabilidade    => cod_contabil_conta.cod_contabil,
                                             :descricao        => descrip_contabil_conta.descricao,
                                             :cotacao          => ig.cotacao.to_f,
                                             :valor_dolar      => ig.valor_dolar,
                                             :valor_guarani    => ig.valor_guarani
                                           )

        end

#LANCAMENTO TRANSFERENCIA ENTRE CONTAS=============================================================================================================

        transferecia    = TransferenciaConta.all(:conditions => filtro)

        transferecia.each do |tc|
           diario =  Diario.create(  :tabela_id        => tc.id.to_i,
                                     :tabela_nome      => 'TRANSFERENCIA CONTAS',
                                     :data             => tc.data,
                                     :cotacao          => tc.cotacao.to_f,
                                     :descricao        => tc.concepto,
                                     :documento_id     => tc.documento_id,
                                     :documento_nome   => tc.documento_nome
                                  )

                         cod_contabil_conta     = Conta.find_by_id( tc.destino_id,:select => 'id,cod_contabil' );
                        #BUSCA DESCRIPCION  DO RUBRO
                         descrip_contabil_conta = PlanoDeConta.find_by_codigo( cod_contabil_conta.cod_contabil,:select => 'id,codigo,descricao' );

                        #INSERE DADOS DO CONTA NO DIARIO_DEBE
                         DiarioDebe.create(  :tabela_id        => tc.id.to_i,
                                             :tabela_nome      => 'TRANSFERENCIA CONTAS',
                                             :diario_id        => diario.id,
                                             :data             => tc.data,
                                             :contabilidade    => cod_contabil_conta.cod_contabil,
                                             :descricao        => descrip_contabil_conta.descricao,
                                             :cotacao          => tc.cotacao.to_f,
                                             :valor_dolar      => tc.valor_dolar,
                                             :valor_guarani    => tc.valor_guarani
                                           )


                        #BUSCA COD_CONTABIL DO CONTA
                         cod_contabil_conta     = Conta.find_by_id( tc.ingreso_id,:select => 'id,cod_contabil' );
                        #BUSCA DESCRIPCION  DO RUBRO
                         descrip_contabil_conta = PlanoDeConta.find_by_codigo( cod_contabil_conta.cod_contabil,:select => 'id,codigo,descricao' );

                        #INSERE DADOS DO CONTA NO DIARIO_HABER
                         DiarioHaber.create( :tabela_id        => tc.id.to_i,
                                             :tabela_nome      => 'TRANSFERENCIA CONTAS',
                                             :diario_id        => diario.id,
                                             :data             => tc.data,
                                             :contabilidade    => cod_contabil_conta.cod_contabil,
                                             :descricao        => descrip_contabil_conta.descricao,
                                             :cotacao          => tc.cotacao.to_f,
                                             :valor_dolar      => tc.valor_dolar,
                                             :valor_guarani    => tc.valor_guarani
                                           )

        end

        sfs = SobrantesFaltante.all(:conditions => filtro)
        
        sfs.each do |sf|
           diario =  Diario.create(  :tabela_id        => sf.id.to_i,
                                     :tabela_nome      => 'SOBRANTES_FALTANTES',
                                     :data             => sf.data,
                                     :cotacao          => sf.cotacao.to_f,
                                     :descricao        => sf.concepto
                                  )
           if sf.tipo.to_i == 0
             DiarioHaber.create( :tabela_id        => sf.id.to_i,
                                 :tabela_nome      => 'SOBRANTES_FALTANTES',
                                 :diario_id        => diario.id,
                                 :data             => sf.data,
                                 :contabilidade    => '5.01.01.001',
                                 :descricao        => 'COSTO DE VENTA DE COMBUSTIBLES',
                                 :cotacao          => sf.cotacao.to_f,
                                 :valor_dolar      => sf.total_dolar,
                                 :valor_guarani    => sf.total_guarani
                                           )
             DiarioDebe.create( :tabela_id        => sf.id.to_i,
                                 :tabela_nome      => 'SOBRANTES_FALTANTES',
                                 :diario_id        => diario.id,
                                 :data             => sf.data,
                                 :contabilidade    => '1.03.01.001',
                                 :descricao        => 'COMBUSTIBLES SAN ANTONIO',
                                 :cotacao          => sf.cotacao.to_f,
                                 :valor_dolar      => sf.total_dolar,
                                 :valor_guarani    => sf.total_guarani )

           else

             DiarioHaber.create( :tabela_id        => sf.id.to_i,
                                 :tabela_nome      => 'SOBRANTES_FALTANTES',
                                 :diario_id        => diario.id,
                                 :data             => sf.data,
                                 :contabilidade    => '1.03.01.001',
                                 :descricao        => 'COMBUSTIBLES SAN ANTONIO',
                                 :cotacao          => sf.cotacao.to_f,
                                 :valor_dolar      => sf.total_dolar,
                                 :valor_guarani    => sf.total_guarani )


             DiarioDebe.create( :tabela_id        => sf.id.to_i,
                                 :tabela_nome      => 'SOBRANTES_FALTANTES',
                                 :diario_id        => diario.id,
                                 :data             => sf.data,
                                 :contabilidade    => '5.01.01.001',
                                 :descricao        => 'COSTO DE VENTA DE COMBUSTIBLES',
                                 :cotacao          => sf.cotacao.to_f,
                                 :valor_dolar      => sf.total_dolar,
                                 :valor_guarani    => sf.total_guarani
                                           )
           
           end
        end

    end

    def self.livro_diario(params)                    #

        filtro = "date_part('month', data) = '#{params[:mes]}'  AND  date_part('year', data) = '#{params[:ano]}'"


        Diario.find_by_sql("SELECT
                                  D.ID,
                                  0 AS ORDEM,
                                  D.DATA,
                                  D.DOCUMENTO_NOME,
                                  D.NUMERO,
                                  CAST( DD.CONTABILIDADE AS VARCHAR(25) ) AS CONTABILIDADE,
                                  CAST( P.DESCRICAO AS VARCHAR(80) ) AS DESCRIPCION,
                                  DD.VALOR_GUARANI AS DEBE,
                                  0.00 AS HABER
                            FROM
                                  DIARIOS D
                            LEFT JOIN
                                  DIARIO_DEBES DD
                                  ON ( DD.DIARIO_ID=D.ID )
                            LEFT JOIN
                                  PLANO_DE_CONTAS P
                                  ON ( P.CODIGO=DD.CONTABILIDADE )
                            WHERE
                                 date_part('month', D.DATA) = '#{params[:mes]}'  AND  date_part('year', D.DATA) = '#{params[:ano]}'

                            UNION ALL

                            SELECT
                                  D.ID,
                                  1 AS ORDEM,
                                  D.DATA,
                                  D.DOCUMENTO_NOME,
                                  D.NUMERO,
                                  CAST( DH.CONTABILIDADE AS VARCHAR(25) ) AS CONTABILIDADE,
                                  CAST( P.DESCRICAO AS VARCHAR(80) ) AS DESCRIPCION,
                                  0.00 AS DEBE,
                                  DH.VALOR_GUARANI AS HABER
                            FROM
                                  DIARIOS D
                            LEFT JOIN
                                  DIARIO_HABERS DH
                                  ON ( DH.DIARIO_ID=D.ID )
                            LEFT JOIN
                                  PLANO_DE_CONTAS P
                                  ON ( P.CODIGO=DH.CONTABILIDADE )
                            WHERE
                                 date_part('month', D.DATA) = '#{params[:mes]}'  AND  date_part('year', D.DATA) = '#{params[:ano]}'

                            UNION ALL

                            SELECT
                                  D.ID,
                                  2 AS ORDEM,
                                  D.DATA,
                                  D.DOCUMENTO_NOME,
                                  D.NUMERO,
                                  CAST( ' ' AS VARCHAR(25) ) AS CONTABILIDADE,
                                  CAST( D.DESCRICAO AS VARCHAR(80) ) AS DESCRIPCION,
                                  0.00 AS DEBE,
                                  0.00 AS HABER
                            FROM
                                  DIARIOS D
                            WHERE
                                 date_part('month', D.DATA) = '#{params[:mes]}'  AND  date_part('year', D.DATA) = '#{params[:ano]}'

                            ORDER BY
                                  3, 1, 2

                                                                ")
    end

    def self.livro_mayor(params)                     #

        filtro  = "AND CONTABILIDADE  BETWEEN  '#{params[:codigo_inicio]}' AND '#{params[:codigo_final]}'" unless params[:codigo_inicio].blank?

sql = "
        SELECT
              DD.CONTABILIDADE,
              P.DESCRICAO AS CONTABILIDADE_DESCRICAO,
              D.DATA,
              D.TABELA_NOME,
              D.TABELA_ID AS PROCESO_NUMERO,
              D.DOCUMENTO_NOME,
              D.DOCUMENTO_NUMERO,
              D.DESCRICAO,
              DD.VALOR_GUARANI AS DEBE,
              CAST( 0.00 AS NUMERIC(15,2) ) AS HABER,
              D.ID
        FROM
              DIARIO_DEBES DD
        LEFT JOIN
              DIARIOS D
              ON ( D.ID=DD.DIARIO_ID )
        LEFT JOIN
              PLANO_DE_CONTAS P
              ON ( P.CODIGO=DD.CONTABILIDADE )
        WHERE
              D.DATA BETWEEN '#{params[:inicio]}' AND '#{params[:final]}'
              #{filtro}
        UNION ALL
        SELECT
              DH.CONTABILIDADE,
              P.DESCRICAO AS CONTABILIDADE_DESCRICAO,
              D.DATA,
              D.TABELA_NOME,
              D.TABELA_ID AS PROCESO_NUMERO,
              D.DOCUMENTO_NOME,
              D.DOCUMENTO_NUMERO,
              D.DESCRICAO,
              CAST( 0.00 AS NUMERIC(15,2) ) AS DEBER,
              DH.VALOR_GUARANI AS HABER,
              D.ID
        FROM
              DIARIO_HABERS DH
        LEFT JOIN
              DIARIOS D
              ON ( D.ID=DH.DIARIO_ID )
        LEFT JOIN
              PLANO_DE_CONTAS P
              ON ( P.CODIGO=DH.CONTABILIDADE )
        WHERE
              D.DATA BETWEEN '#{params[:inicio]}' AND '#{params[:final]}'
              #{filtro}
        ORDER BY
              1, 2, 3, 4, 5,11

      "
        Diario.find_by_sql(sql)
    end

    def self.balance(params)                         #

        filtro = "date_part('month', data) = '#{params[:mes]}'  AND  date_part('year', data) = '#{params[:ano]}'"

        PlanoDeConta.all(:order => 'codigo')

    end

    def self.balance_general(params)                 #

        filtro = "date_part('month', data) = '#{params[:mes]}'  AND  date_part('year', data) = '#{params[:ano]}'"

        PlanoDeConta.all(:order => 'codigo')

    end

#===============================================================================#

    def self.relatorio_compras(params)               #

        filtro = "data BETWEEN  '#{params[:inicio]}' AND  '#{params[:final]}' AND tipo_compra = 0"
        filtro += "AND persona_id = #{params[:busca]['proveedor']}" unless params[:busca]['proveedor'].blank?

        Compra.all(:conditions => filtro,:order => 'data,id')
    end

    def self.relatorio_compras_anterior(params)      #

        filtro = "data < '#{params[:inicio]}'"
        filtro += "AND persona_id = #{params[:busca]['proveedor']}" unless params[:busca]['proveedor'].blank?

        Compra.sum(:total_guarani,:conditions => filtro)
    end

    def self.relatorio_cobros_detalhes(params)       #

        filtro = "data BETWEEN  '#{params[:inicio]}' AND  '#{params[:final]}'"
        filtro += "AND persona_id = #{params[:busca]['persona']}" unless params[:busca]['persona'].blank?

        CobrosDetalhe.all(:conditions => filtro,:order => 'data,id')
    end

    def self.relatorio_cobros(params)                #

        filtro = "data BETWEEN  '#{params[:inicio]}' AND  '#{params[:final]}'"
        filtro += "AND persona_id = #{params[:busca]['persona']}" unless params[:busca]['persona'].blank?

        Cobro.all(:conditions => filtro,:order => 'data,id')
    end

    def self.relatorio_relogio_ponto(params)         #

        usuario = "AND usuario_id = #{params[:busca]['usuario']}" unless params[:busca]['usuario'].blank?
        turno   = "AND turno_id = #{params[:busca]['turno']}" unless params[:busca]['turno'].blank?
        filtro  = "data BETWEEN  '#{params[:inicio]}' AND  '#{params[:final]}' #{usuario} #{turno}"

        RelogioPonto.all(:conditions => filtro,:order => 'data,id')
    end

    def self.fechamento_turno(params)                #

        filtro = " data BETWEEN '#{params[:inicio]}' AND '#{params[:final]}' "

        FechamentoTurno.all(:conditions => filtro,:order => 'data,bomba_nome,turno_nome')
    end

    def self.vendas_resumo_produtos(params)                #

        clase   = "AND CLASE_ID = #{ params[:busca]['clase'] }" unless  params[:busca]['clase'].blank?
        grupo   = "AND GRUPO_ID = #{ params[:busca]['grupo'] }" unless  params[:busca]['grupo'].blank?
        produto = "AND PRODUTO_ID = #{ params[:busca]['produto'] }" unless  params[:busca]['produto'].blank?
        turno   = "AND TURNO_CREATED = #{ params[:busca]['turno'] }" unless  params[:busca]['turno'].blank?
        vend = "vendedor_id = #{ params[:busca]['vend'] } AND " unless  params[:busca]['vend'].blank?
        
		sql = "SELECT 
						      PRODUTO_ID,
						      PRODUTO_NOME,
						      SUM(QUANTIDADE) AS QTD,
						      SUM(TOTAL_GUARANI) AS TOT
					FROM      
						      VENDAS_PRODUTOS
					WHERE 
			        DATA BETWEEN '#{params[:inicio]}' AND '#{params[:final]}' #{clase} #{grupo} #{produto} #{turno} #{vend}
            
					GROUP BY 
						      1,2 "
		VendasProduto.find_by_sql(sql)
    end

end

    


