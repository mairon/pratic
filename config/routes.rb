ActionController::Routing::Routes.draw do |map|
  map.resources :producaos,:member     => { :producao_final  => :get,
                                            :detalhe_print   => :get},
                           :collection => { :busca           => :get} do |producao|
                                                                          producao.resources :producao_produtos
                                                                      end

  map.resources :transferencia_deposito_produtos

  
  map.connect   'pratic',                             :controller=>'logins',            :action=>'new';
  map.connect   '/vendas/venda_produto',              :controller=>'vendas',            :action=>'venda_produto';
  map.connect   '/vendas/faturas_pendentes',          :controller=>'vendas',            :action=>'faturas_pendentes';
  map.connect   '/vendas/comprovante',                :controller=>'vendas',            :action=>'comprovante';
  map.connect   '/vendas/comprovante_fatura_pendentes', :controller=>'vendas',          :action=>'comprovante_fatura_pendentes';
  map.connect   '/vendas/detalhes_produto',           :controller=>'vendas',            :action=>'detalhes_produto';
  map.connect   '/vendas/filtro_faturas_pendentes_comprovante',   :controller=>'vendas',            :action=>'filtro_faturas_pendentes_comprovante';  
  map.connect   '/produtos/busca_compra_produto',     :controller=>'produtos',          :action=>'busca_compra_produto';
  map.connect   '/produtos/busca_venda_produto',      :controller=>'produtos',          :action=>'busca_venda_produto';
  map.connect   '/produtos/busca_ordem_produto',      :controller=>'produtos',          :action=>'busca_ordem_produto';
  map.connect   '/produtos/consulta_stock',           :controller=>'produtos',          :action=>'consulta_stock';
  map.connect   '/produtos/index_print',              :controller=>'produtos',          :action=>'index_print';
  map.connect   '/compras/compras_financa',           :controller=>'compras',           :action=>'compras_financa';
  map.connect   '/compras/compras_documento',         :controller=>'compras',           :action=>'compras_documento';
  map.connect   '/compras/novo_produto',              :controller=>'compras',           :action=>'novo_produto';
  map.connect   '/compras/novo_financa',              :controller=>'compras',           :action=>'novo_financa';
  map.connect   '/compras/index_gasto',              :controller=>'compras',           :action=>'index_gasto';
  map.connect   '/cobros/busca_cliente',              :controller=>'cobros',            :action=>'busca_cliente';
  map.connect   '/pagos/busca_proveedor',             :controller=>'pagos',             :action=>'busca_proveedor';
  map.connect   '/personas/persona_compra',           :controller=>'personas',          :action=>'persona_compra';
  map.connect   '/personas/persona_venda',            :controller=>'personas',          :action=>'persona_venda';
  map.connect   '/personas/persona_ordem',            :controller=>'personas',          :action=>'persona_ordem';
  map.connect   '/personas/persona_cobro',            :controller=>'personas',          :action=>'persona_cobro';
  map.connect   '/personas/persona_pago',             :controller=>'personas',          :action=>'persona_pago';
  map.connect   '/personas/persona_venda_financa',    :controller=>'personas',          :action=>'persona_venda_financa';
  map.connect   '/personas/persona_nota_credito',     :controller=>'personas',          :action=>'persona_nota_credito';
  map.connect   '/stocks/relatorio_consumo_bomba',    :controller=>'stocks',            :action=>'relatorio_consumo_bomba';
  map.connect   '/compras/index_compra',              :controller=>'compras',           :action=>'index_compra';
  map.connect   '/compras/new_compra',               :controller=>'compras',            :action=>'new_compra';
  map.connect   '/compras/new_gasto',                :controller=>'compras',            :action=>'new_gasto';
  map.connect   '/relatorios/relatorio_vendas_do_dia',:controller=>'relatorios',        :action=>'relatorio_vendas_do_dia';
  map.connect   '/relatorios/relatorio_fechamento_turno', :controller=>'relatorios',     :action=>'relatorio_fechamento_turno';
  map.connect   '/relatorios/livro_compra',               :controller=>'relatorios',        :action=>'livro_compra';
  map.connect   '/relatorios/livro_venda',                :controller=>'relatorios',        :action=>'livro_venda';
  map.connect   '/relatorios/livro_diario',               :controller=>'relatorios',        :action=>'livro_diario';
  map.connect   '/relatorios/livro_mayor',                :controller=>'relatorios',        :action=>'livro_mayor';
  map.connect   '/relatorios/relatorio_compras',           :controller=>'relatorios',        :action=>'relatorio_compras';
  map.connect   '/relatorios/relatorio_cobros',           :controller=>'relatorios',        :action=>'relatorio_cobros';
  map.connect   '/relatorios/balance',                    :controller=>'relatorios',        :action=>'balance';
  map.connect   '/relatorios/balance_general',            :controller=>'relatorios',        :action=>'balance_general';
  map.connect   '/relatorios/relogio_ponto',              :controller=>'relatorios',        :action=>'relogio_ponto';
  map.connect   '/relatorios/generar_acientos_contables', :controller=>'relatorios',        :action=>'generar_acientos_contables';
  map.connect   '/financas/extrato_bancario',             :controller=>'financas',          :action=>'extrato_bancario';
  map.connect   '/stocks/iventario',                      :controller=>'stocks',            :action=>'iventario';
  map.connect   '/stocks/new_st_final',                   :controller=>'stocks',            :action=>'new_st_final';
  map.connect   '/stocks/edit_st_final',                  :controller=>'stocks',            :action=>'edit_st_final';

  map.resources :relogio_pontos
  map.resources :adelantos_proveedors, :collection  => {:busca  => :get}
  map.resources :faturas, :collection  => {:busca  => :get}
  map.resources :pagos_financas
  map.resources :cobros_financas
  map.resources :sueldos_detalhes
  map.resources :sueldos
  map.resources :proventos
  map.resources :transferencia_depositos
  map.resources :sobrantes_faltantes
  map.resources :diario_habers
  map.resources :diario_debes
  map.resources :diarios
  map.resources :transferencia_contas
  map.resources :transferencia_entre_contas
  map.resources :ingressos
  map.resources :fechamento_turnos
  map.resources :bombas
  map.resources :nota_creditos_detalhes
  map.resources :nota_creditos
  map.resources :rubros
  map.resources :plano_de_contas
  map.resources :planos
  map.resources :personas,:collection   => {:busca_persona_pago          => :get,
                                            :busca_persona_cobro         => :get,
                                            :busca                       => :get,
                                            :busca_persona_compra        => :get,
                                            :busca_persona_nota_credito  => :get,
                                            :busca_persona_venda_financa => :get,
                                            :busca_persona_venda         => :get}

  map.resources :pagos_detalhes
  map.resources :pagos
  map.resources :cobros_detalhes
  map.resources :cobros,:collection  => { :filtro_busca_cliente          => :get,
                                          :filtro_divida_selecionadas    => :post,
                                          :busca                         => :get,
                                         }
  map.resources :turnos
  map.resources :tabela_preco_produtos
  map.resources :clientes,:collection    => {:relatorio_contas_receber => :get}
  map.resources :proveedores,:collection => {:relatorio_contas_pagar   => :get}
  map.resources :stocks,:collection      => {:relatorio_stock                   => :get,
                                             :stock_inicial                     => :get,
                                             :stock_final                       => :get,
                                             :rentabilidade                     => :get,
                                             :resultado_rentabilidade           => :get,
                                             :print_stock_final                 => :get,
                                             :dinamic_busca_stock_final         => :get,
                                             :dinamic_busca_stock_inicial       => :get,
                                             :resultado_iventario               => :get,
                                             :resultado_relatorio_consumo_bomba => :get}
                                         
  map.resources :financas,:collection      => {:relatorio_financas => :get,:resultado_extrato_bancario => :get}
  map.resources :ordem_servicos_executados
  map.resources :servicos_executados
  map.resources :ordem_servicos_produtos
  map.resources :servico_executados
  map.resources :servicos
  map.resources :ordem_servico_produtos
  map.resources :ordem_servicos
  map.resources :vendas_financas
  map.resources :vendas_produtos,:collection => { :busca_nota_credito_produto => :get }
  map.resources :manifestacao_de_bens
  map.resources :documentos
  map.resources :compras_documentos
  map.resources :compras_financas
  map.resources :contas
  map.resources :depositos
  map.resources :compras_produtos
  map.resources :compras, :collection  => {:busca_compra  => :get}
  map.resources :menus
  map.resources :logins
  map.resources :unidades
  map.resources :usuarios
  map.resources :moedas
  map.resources :cotacoes
  map.resources :clases
  map.resources :grupos
  map.resources :classes
  map.resources :cidades
  map.resources :estados
  map.resources :paises
  map.resources :produtos, :collection  => {:dinamic_busca_consulta_stock  => :get,                                            
                                            :dinamic_busca_compra_produto  => :get,
                                            :dinamic_busca_venda_produto   => :get,
                                            :produtos_selecionados         => :post,
                                            :fletes                        => :get,
                                            :busca_producao_produto                   => :get,
                                            :dinamic_busca_producao_produto           => :get,                                            
                                            :dinamic_busca                 => :get,
                                            :dinamic_busca_ordem_produto   => :get};

  map.resources :clientes
  
  map.resources :venda_produtos
  map.resources :vendas,     :collection  => { :filtro_faturas_pendentes              => :post,
                                               :busca_vendas                          => :get,
                                               :filtro_faturas_pendentes_comprovante  => :post,
                                               :update_faturas_pendentes              => :put }
  map.resources :relatorios, :collection  => { :resultado_relatorio_vendas_do_dia    => :get,
                                               :resultado_livro_compra               => :get,
                                               :resultado_livro_venda                => :get,
                                               :resultado_livro_diario               => :get,
                                               :resultado_livro_mayor                => :get,
                                               :resultado_balance                    => :get,
                                               :resultado_balance_general            => :get,
                                               :gastos                               => :get,
                                               :resultado_gastos                     => :get,
                                               :resultado_relatorio_compra           => :get,
                                               :resultado_relatorio_cobros           => :get,
                                               :resultado_relatorio_fechamento_turno => :get,
                                               :resultado_relogio_ponto              => :get,
                                               :resultado_generar_acientos_contables => :get }
  map.connect ':controller/:action.:format'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
