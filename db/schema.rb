# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111114120017) do

  create_table "adelantos_proveedors", :force => true do |t|
    t.date     "data"
    t.decimal  "cotacao",                        :precision => 15, :scale => 2
    t.integer  "moeda"
    t.integer  "conta_id"
    t.string   "conta_nome",      :limit => 150
    t.integer  "persona_id"
    t.string   "persona_nome",    :limit => 150
    t.integer  "documento_id"
    t.string   "documento_nome",  :limit => 100
    t.string   "cheque",          :limit => 50
    t.date     "diferido"
    t.decimal  "valor_dolar",                    :precision => 15, :scale => 2
    t.decimal  "valor_guarani",                  :precision => 15, :scale => 2
    t.string   "concepto",        :limit => 150
    t.integer  "usuario_created"
    t.integer  "usuario_updated"
    t.integer  "unidade_created"
    t.integer  "unidade_updated"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bombas", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "usuario_created"
    t.integer  "unidade_created"
    t.integer  "usuario_updated"
    t.integer  "unidade_updated"
    t.integer  "deposito_id"
    t.string   "deposito_nome",   :limit => 200
    t.string   "nome",            :limit => 200
  end

  create_table "cidades", :force => true do |t|
    t.string   "nome"
    t.integer  "estado_id"
    t.string   "estado"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "usuario_created"
    t.integer  "usuario_updated"
    t.integer  "paise_id"
    t.integer  "unidade_created"
    t.integer  "unidade_updated"
  end

  create_table "clases", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "descricao",       :limit => 100
    t.integer  "usuario_created"
    t.integer  "usuario_updated"
    t.integer  "unidade_created"
    t.integer  "unidade_updated"
  end

  create_table "clientes", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "usuario_created"
    t.integer  "usuario_updated"
    t.integer  "unidade_created"
    t.integer  "unidade_updated"
    t.integer  "tabela_id"
    t.string   "tabela",              :limit => 200
    t.date     "vencimento"
    t.integer  "persona_id"
    t.string   "persona_nome",        :limit => 200
    t.integer  "venda_id"
    t.string   "documento_nome",      :limit => 100
    t.string   "documento_numero",    :limit => 100
    t.integer  "cota",                                                              :default => 0
    t.date     "data"
    t.date     "original"
    t.decimal  "divida_dolar",                       :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "divida_guarani",                     :precision => 15, :scale => 2, :default => 0.0
    t.date     "recebido"
    t.decimal  "cobro_dolar",                        :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "cobro_guarani",                      :precision => 15, :scale => 2, :default => 0.0
    t.integer  "liquidacao"
    t.integer  "conta_id"
    t.string   "conta_nome",          :limit => 150
    t.string   "cheque",              :limit => 150
    t.date     "diferido"
    t.string   "tipo",                :limit => 20
    t.integer  "conta_created"
    t.integer  "conta_updated"
    t.integer  "turno_created"
    t.integer  "turno_updated"
    t.integer  "cobro_id"
    t.integer  "estado"
    t.string   "documento_numero_01", :limit => 5
    t.string   "documento_numero_02", :limit => 5
    t.string   "numero_ordem"
  end

  add_index "clientes", ["persona_id", "liquidacao", "tipo"], :name => "cliente_id"

  create_table "cobros", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "usuario_created"
    t.integer  "usuario_updated"
    t.integer  "unidade_created"
    t.integer  "unidade_updated"
    t.date     "data"
    t.decimal  "cotacao",                        :precision => 15, :scale => 2
    t.integer  "persona_id"
    t.string   "persona_nome",    :limit => 200
    t.integer  "conta_id"
    t.string   "conta_nome",      :limit => 150
    t.string   "cheque",          :limit => 100
    t.date     "diferido"
    t.decimal  "valor_dolar",                    :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "valor_guarani",                  :precision => 15, :scale => 2, :default => 0.0
    t.integer  "turno_created"
    t.integer  "turno_updated"
    t.integer  "moeda"
    t.string   "ruc",             :limit => 100
    t.string   "documento_nome",  :limit => 150
    t.integer  "documento_id"
    t.string   "descricao"
  end

  create_table "cobros_detalhes", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "usuario_created"
    t.integer  "usuario_updated"
    t.integer  "unidade_created"
    t.integer  "unidade_updated"
    t.integer  "turno_created"
    t.integer  "turno_updated"
    t.integer  "cobro_id"
    t.date     "vencimento"
    t.integer  "persona_id"
    t.string   "persona_nome",        :limit => 200
    t.string   "documento_nome",      :limit => 150
    t.string   "documento_numero",    :limit => 150
    t.integer  "cota"
    t.date     "data"
    t.decimal  "cobro_dolar",                        :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "cobro_guarani",                      :precision => 15, :scale => 2, :default => 0.0
    t.integer  "liquidacao"
    t.decimal  "anterior_dolar",                     :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "anterior_guarani",                   :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "saldo_dolar",                        :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "saldo_guarani",                      :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "valor_dolar",                        :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "valor_guarani",                      :precision => 15, :scale => 2, :default => 0.0
    t.integer  "estado"
    t.integer  "venda_id"
    t.string   "documento_numero_01", :limit => 5
    t.string   "documento_numero_02", :limit => 5
  end

  create_table "cobros_financas", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "conta_id"
    t.string   "conta_nome",       :limit => 150
    t.integer  "persona_id"
    t.string   "persona_nome",     :limit => 200
    t.string   "descricao",        :limit => 200
    t.date     "data"
    t.decimal  "valor_dolar",                     :precision => 15, :scale => 2
    t.decimal  "valor_guarani",                   :precision => 15, :scale => 2
    t.integer  "documento_id"
    t.string   "documento_nome",   :limit => 150
    t.string   "documento_numero", :limit => 50
    t.string   "cheque",           :limit => 50
    t.date     "diferido"
    t.integer  "usuario_created"
    t.integer  "unidade_created"
    t.integer  "unidade_updated"
    t.integer  "cobro_id"
  end

  create_table "compras", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "usuario_created"
    t.integer  "usuario_updated"
    t.integer  "unidade_id"
    t.date     "data"
    t.integer  "persona_id"
    t.string   "persona_nome",             :limit => 200
    t.integer  "tipo"
    t.decimal  "cotacao",                                 :precision => 15, :scale => 2
    t.integer  "tipo_compra"
    t.integer  "moeda"
    t.decimal  "frete_dolar",                             :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "frete_guarani",                           :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "desconto_dolar",                          :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "desconto_guarani",                        :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "despacho_dolar",                          :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "despacho_guarani",                        :precision => 15, :scale => 2, :default => 0.0
    t.string   "numero_envoce",            :limit => 50
    t.decimal  "iva_total_dolar",                         :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "iva_total_guarani",                       :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "valor_imponible",                         :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "outros_dolar",                            :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "outros_guarani",                          :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "seguro_dolar",                            :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "seguro_guarani",                          :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "iva_despacho_dolar",                      :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "iva_despacho_guarani",                    :precision => 15, :scale => 2, :default => 0.0
    t.integer  "despachante_id"
    t.string   "despachante_nome",         :limit => 200
    t.string   "persona_ruc",              :limit => 100
    t.integer  "documento_id"
    t.string   "documento_nome",           :limit => 200
    t.string   "documento_numero",         :limit => 100
    t.string   "documento_numero_01",      :limit => 5
    t.string   "documento_numero_02",      :limit => 5
    t.string   "documento_timbrado",       :limit => 100
    t.integer  "conta_id"
    t.string   "conta_nome",               :limit => 200
    t.string   "cheque",                   :limit => 100
    t.decimal  "total_dolar",                             :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "total_guarani",                           :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "exentas_dolar",                           :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "exentas_guarani",                         :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "cota_dolar_01",                           :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "cota_guarani_01",                         :precision => 15, :scale => 2, :default => 0.0
    t.date     "data_cota_01"
    t.decimal  "cota_dolar_02",                           :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "cota_guarani_02",                         :precision => 15, :scale => 2, :default => 0.0
    t.date     "data_cota_02"
    t.decimal  "cota_dolar_03",                           :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "cota_guarani_03",                         :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "cota_dolar_04",                           :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "cota_guarani_04",                         :precision => 15, :scale => 2, :default => 0.0
    t.date     "data_cota_04"
    t.decimal  "cota_dolar_05",                           :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "cota_guarani_05",                         :precision => 15, :scale => 2, :default => 0.0
    t.date     "data_cota_05"
    t.decimal  "cota_dolar_06",                           :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "cota_guarani_06",                         :precision => 15, :scale => 2, :default => 0.0
    t.date     "data_cota_06"
    t.date     "data_cota_03"
    t.decimal  "gravadas_10_dolar",                       :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "gravadas_10_guarani",                     :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "gravadas_05_dolar",                       :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "gravadas_05_guarani",                     :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "imposto_10_dolar",                        :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "imposto_10_guarani",                      :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "imposto_05_dolar",                        :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "imposto_05_guarani",                      :precision => 15, :scale => 2, :default => 0.0
    t.integer  "unidade_created"
    t.integer  "unidade_updated"
    t.date     "diferido"
    t.integer  "cota_dolar",                                                             :default => 0
    t.integer  "cota_guarani",                                                           :default => 0
    t.integer  "entrega_dolar",                                                          :default => 0
    t.integer  "entrega_guarani",                                                        :default => 0
    t.integer  "plano_de_conta_id"
    t.integer  "plano_de_conta_descricao"
    t.integer  "rubro_id"
    t.string   "rubro_descricao"
    t.string   "rubro_cod_contabil"
    t.string   "descricao"
    t.integer  "sueldo_id"
  end

  create_table "compras_custos", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "compra_id"
    t.integer  "documento_id"
    t.string   "documento_nome",         :limit => 200
    t.string   "documento_numero",       :limit => 100
    t.integer  "persona_id"
    t.string   "persona_nome",           :limit => 200
    t.integer  "moeda"
    t.date     "data"
    t.decimal  "cotacao",                               :precision => 15, :scale => 2, :default => 0.0
    t.integer  "produto_id"
    t.integer  "deposito_id"
    t.decimal  "quantidade",                            :precision => 15, :scale => 3, :default => 0.0
    t.decimal  "porcentagem",                           :precision => 15, :scale => 6
    t.decimal  "custo_contabil_dolar",                  :precision => 15, :scale => 6, :default => 0.0
    t.decimal  "custo_contabil_guarani",                :precision => 15, :scale => 6, :default => 0.0
    t.decimal  "custo_produto_dolar",                   :precision => 15, :scale => 6, :default => 0.0
    t.decimal  "custo_produto_guarani",                 :precision => 15, :scale => 6, :default => 0.0
    t.string   "produto_nome",           :limit => 200
    t.decimal  "total_contabil_dolar",                  :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "total_contabil_guarani",                :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "total_produto_dolar",                   :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "total_produto_guarani",                 :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "imposto_10_dolar",                      :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "imposto_10_guarani",                    :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "imposto_05_dolar",                      :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "imposto_05_guarani",                    :precision => 15, :scale => 2, :default => 0.0
  end

  create_table "compras_documentos", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "usuario_created"
    t.integer  "usuario_updated"
    t.integer  "compra_id"
    t.integer  "documento_id"
    t.string   "documento_nome",      :limit => 150
    t.string   "documento_numero",    :limit => 100
    t.integer  "persona_id"
    t.string   "persona_nome",        :limit => 200
    t.string   "persona_ruc",         :limit => 200
    t.string   "persona_timbrado",    :limit => 200
    t.date     "data"
    t.integer  "moeda_id"
    t.decimal  "exentas_dolar",                      :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "exentas_guarani",                    :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "gravadas_10_dolar",                  :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "gravadas_10_guarani",                :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "gravadas_05_dolar",                  :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "gravadas_05_guarani",                :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "imposto_10_dolar",                   :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "imposto_10_guarani",                 :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "imposto_05_dolar",                   :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "imposto_05_guarani",                 :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "total_dolar",                        :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "total_guarani",                      :precision => 15, :scale => 2, :default => 0.0
    t.integer  "contabilidade_id"
    t.decimal  "cotacao",                            :precision => 15, :scale => 2
    t.integer  "tipo"
    t.integer  "unidade_created"
    t.integer  "unidade_updated"
    t.string   "tipo_documento",      :limit => 50
    t.integer  "moeda"
    t.string   "documento_numero_01", :limit => 5,                                  :default => "1"
    t.string   "documento_numero_02", :limit => 5,                                  :default => "1"
    t.integer  "conta_id"
    t.string   "conta_nome",          :limit => nil
    t.string   "cheque",              :limit => 100
    t.string   "tabela",              :limit => 200
    t.integer  "tabela_id"
    t.integer  "tipo_compra"
  end

  create_table "compras_financas", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "usuario_created"
    t.integer  "usuario_updated"
    t.integer  "unidade_created"
    t.integer  "unidade_updated"
    t.integer  "compra_id"
    t.integer  "persona_id"
    t.string   "persona_nome",        :limit => 200
    t.string   "persona_ruc",         :limit => 100
    t.integer  "documento_id"
    t.string   "documento_nome",      :limit => 200
    t.string   "documento_numero",    :limit => 100
    t.date     "data"
    t.integer  "moeda"
    t.decimal  "cotacao",                            :precision => 15, :scale => 2, :default => 0.0
    t.integer  "tipo"
    t.date     "vencimento"
    t.decimal  "valor_dolar",                        :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "valor_guarani",                      :precision => 15, :scale => 2, :default => 0.0
    t.integer  "conta_id"
    t.string   "conta_nome",          :limit => 200
    t.string   "cheque",              :limit => 100
    t.integer  "cota"
    t.string   "documento_numero_01", :limit => 5
    t.string   "documento_numero_02", :limit => 5
    t.string   "tabela",              :limit => 200
    t.integer  "tabela_id"
    t.decimal  "total_dolar",                        :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "total_guarani",                      :precision => 15, :scale => 2, :default => 0.0
    t.integer  "entrega_dolar"
    t.integer  "entrega_guarani"
    t.date     "diferido"
    t.string   "descricao"
  end

  create_table "compras_produtos", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "usuario_created"
    t.integer  "usuario_updated"
    t.integer  "produto_id"
    t.integer  "compra_id"
    t.string   "produto_nome",              :limit => 200
    t.decimal  "unitario_dolar",                           :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "unitario_guarani",                         :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "total_dolar",                              :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "total_guarani",                            :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "iva_taxa",                                 :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "iva_dolar",                                :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "iva_guarani",                              :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "custo_contabil_dolar",                     :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "custo_contabil_guarani",                   :precision => 15, :scale => 2, :default => 0.0
    t.integer  "deposito_id"
    t.string   "deposito_nome",             :limit => 200
    t.decimal  "frete_dolar",                              :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "desconto_dolar",                           :precision => 15, :scale => 2, :default => 0.0
    t.date     "data"
    t.integer  "unidade_created"
    t.integer  "unidade_updated"
    t.integer  "cotacao"
    t.string   "fabricante_cod",            :limit => 50
    t.string   "codigo",                    :limit => 50
    t.integer  "moeda"
    t.decimal  "despacho_dolar",                           :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "despacho_guarani",                         :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "frete_guarani",                            :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "desconto_guarani",                         :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "porcentagem_produto",                      :precision => 15, :scale => 6, :default => 0.0
    t.decimal  "iva_total_dolar",                          :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "iva_total_guarani",                        :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "outros_dolar",                             :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "outros_guarani",                           :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "custo_produto_dolar",                      :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "custo_produto_dolar_iva",                  :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "custo_produto_guarani_iva",                :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "custo_produto_guarani",                    :precision => 15, :scale => 2, :default => 0.0
    t.integer  "clase_id"
    t.integer  "grupo_id"
    t.integer  "sub_grupo_id"
    t.decimal  "quantidade",                               :precision => 15, :scale => 3, :default => 0.0
    t.decimal  "seguro_dolar",                             :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "seguro_guarani",                           :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "iva_despacho_dolar",                       :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "iva_despacho_guarani",                     :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "porcentagem",                              :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "preco_venda_guarani",                      :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "preco_venda_dolar",                        :precision => 15, :scale => 2, :default => 0.0
    t.integer  "tipo_compra"
  end

  create_table "contas", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "usuario_created"
    t.integer  "usuario_updated"
    t.string   "nome",            :limit => 200
    t.string   "numero",          :limit => 100
    t.string   "direcao",         :limit => 200
    t.integer  "unidade_id"
    t.integer  "tipo"
    t.string   "encarregado",     :limit => 100
    t.integer  "cidade_id"
    t.string   "cidade",          :limit => 200
    t.integer  "unidade_created"
    t.integer  "unidade_updated"
    t.string   "cod_contabil",    :limit => 50
    t.integer  "rubro_id"
    t.string   "rubro_nome"
  end

  create_table "depositos", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "usuario_created"
    t.integer  "usuario_updated"
    t.string   "nome",            :limit => 200
    t.integer  "unidade_id"
    t.string   "bairro",          :limit => 200
    t.string   "complemento",     :limit => 300
    t.integer  "cidade_id"
    t.string   "direcao",         :limit => 200
    t.string   "cidade",          :limit => 200
  end

  create_table "diario_debes", :force => true do |t|
    t.integer  "diario_id"
    t.date     "data"
    t.decimal  "cotacao",                        :precision => 15, :scale => 2
    t.decimal  "valor_dolar",                    :precision => 15, :scale => 2
    t.decimal  "valor_guarani",                  :precision => 15, :scale => 2
    t.integer  "persona_id"
    t.string   "persona_nome",    :limit => 150
    t.integer  "produto_id"
    t.string   "produto_nome",    :limit => 150
    t.integer  "unidade_id"
    t.string   "unidade_nome",    :limit => 150
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tabela_id"
    t.string   "tabela_nome",     :limit => 150
    t.integer  "usuario_created"
    t.integer  "unidade_created"
    t.integer  "usuario_updated"
    t.integer  "unidade_updated"
    t.string   "contabilidade",   :limit => 50
    t.string   "descricao",       :limit => 150
    t.integer  "rubro_id"
  end

  create_table "diario_habers", :force => true do |t|
    t.integer  "diario_id"
    t.date     "data"
    t.decimal  "cotacao",                        :precision => 15, :scale => 2
    t.decimal  "valor_dolar",                    :precision => 15, :scale => 2
    t.decimal  "valor_guarani",                  :precision => 15, :scale => 2
    t.integer  "persona_id"
    t.string   "persona_nome",    :limit => 150
    t.integer  "produto_id"
    t.string   "produto_nome",    :limit => 150
    t.integer  "unidade_id"
    t.string   "unidade_nome",    :limit => 150
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tabela_id"
    t.string   "tabela_nome",     :limit => 150
    t.integer  "usuario_created"
    t.integer  "unidade_created"
    t.integer  "usuario_updated"
    t.integer  "unidade_updated"
    t.string   "contabilidade",   :limit => 50
    t.string   "descricao",       :limit => 150
    t.integer  "rubro_id"
  end

  create_table "diarios", :force => true do |t|
    t.date     "data"
    t.decimal  "cotacao",                         :precision => 15, :scale => 2
    t.integer  "numero"
    t.decimal  "debito_dolar",                    :precision => 15, :scale => 2
    t.decimal  "credito_dolar",                   :precision => 15, :scale => 2
    t.integer  "documento_id"
    t.string   "documento_nome",   :limit => 150
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tabela_id"
    t.string   "tabela_nome",      :limit => 150
    t.decimal  "credito_guarani",                 :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "debito_guarani",                  :precision => 15, :scale => 2, :default => 0.0
    t.string   "descricao",        :limit => 200
    t.integer  "usuario_created"
    t.integer  "unidade_created"
    t.integer  "usuario_updated"
    t.integer  "unidade_updated"
    t.string   "documento_numero", :limit => 150
  end

  create_table "documentos", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nome",            :limit => 200
    t.integer  "usuario_created"
    t.integer  "usuario_updated"
    t.integer  "unidade_created"
    t.integer  "unidade_updated"
  end

  create_table "estados", :force => true do |t|
    t.string   "nome"
    t.integer  "paise_id"
    t.string   "pais"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "usuario_created"
    t.integer  "usuario_updated"
    t.integer  "unidade_created"
    t.integer  "unidade_updated"
  end

  create_table "faturas", :force => true do |t|
    t.date     "data"
    t.string   "documento_numero_01", :limit => 10
    t.string   "documento_numero_02", :limit => 10
    t.string   "documento_numero",    :limit => 50
    t.integer  "usuario_created"
    t.integer  "usuario_updated"
    t.integer  "unidade_created"
    t.integer  "unidade_updated"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "vendedor_id"
    t.string   "vendedor_nome",       :limit => 150
    t.integer  "status"
    t.integer  "venda_id"
    t.integer  "tabela_id"
    t.string   "tabela",              :limit => 150
    t.integer  "persona_id"
    t.string   "persona_nome",        :limit => 150
  end

  create_table "fechamento_turnos", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "data"
    t.decimal  "inicio",                         :precision => 15, :scale => 3, :default => 0.0
    t.decimal  "final",                          :precision => 15, :scale => 3, :default => 0.0
    t.string   "turno_nome",      :limit => 150
    t.integer  "bomba_id"
    t.string   "bomba_nome",      :limit => 150
    t.integer  "deposito_id"
    t.string   "deposito_nome",   :limit => 150
    t.integer  "usuario_created"
    t.integer  "unidade_created"
    t.integer  "usuario_updated"
    t.integer  "unidade_updated"
    t.integer  "turno_id"
  end

  create_table "financas", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "usuario_created"
    t.integer  "usuario_updated"
    t.integer  "unidade_created"
    t.integer  "unidade_updated"
    t.integer  "tabela_id"
    t.string   "tabela",              :limit => 150
    t.integer  "conta_id"
    t.string   "conta_nome",          :limit => 200
    t.date     "data"
    t.decimal  "entrada_dolar",                      :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "saida_dolar",                        :precision => 15, :scale => 2, :default => 0.0
    t.integer  "persona_id"
    t.string   "persona_nome",        :limit => 200
    t.integer  "compra_id"
    t.date     "vencimento"
    t.string   "cheque",              :limit => 100
    t.decimal  "entrada_guarani",                    :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "saida_guarani",                      :precision => 15, :scale => 2, :default => 0.0
    t.integer  "venda_id"
    t.string   "documento_nome",      :limit => 100
    t.string   "documento_numero",    :limit => 100
    t.integer  "tipo"
    t.date     "diferido"
    t.string   "documento_numero_01", :limit => 5
    t.string   "documento_numero_02", :limit => 5
    t.integer  "documento_id"
    t.integer  "estado"
    t.string   "concepto"
    t.date     "original"
  end

  create_table "grupos", :force => true do |t|
    t.string   "descricao"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "usuario_created"
    t.integer  "usuario_updated"
    t.integer  "unidade_created"
    t.integer  "unidade_updated"
  end

  create_table "ingressos", :force => true do |t|
    t.date     "data"
    t.integer  "conta_id"
    t.string   "conta_nome",      :limit => 100
    t.integer  "rubro_id"
    t.string   "rubro_nome",      :limit => 150
    t.string   "rubro_codigo",    :limit => 50
    t.string   "concepto",        :limit => 200
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "usuario_created"
    t.integer  "usuario_updated"
    t.integer  "unidade_created"
    t.integer  "unidade_updated"
    t.decimal  "cotacao",                        :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "valor_dolar",                    :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "valor_guarani",                  :precision => 15, :scale => 2, :default => 0.0
    t.integer  "moeda"
    t.integer  "documento_id"
    t.string   "documento_nome",  :limit => 150
  end

  create_table "logins", :force => true do |t|
    t.integer  "unidade_id"
    t.string   "unidade_nome"
    t.integer  "usuario_id"
    t.string   "usuario_nome"
    t.string   "usuario_senha"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tipo"
    t.string   "conta_nome",    :limit => 200
    t.integer  "conta_id"
    t.string   "turno_nome",    :limit => 250
    t.integer  "turno_id"
  end

  create_table "manifestacao_de_bens", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "usuario_created"
    t.integer  "usuario_updated"
    t.integer  "persona_id"
    t.string   "persona_nome",     :limit => 200
    t.string   "tipo",             :limit => 50
    t.string   "caracteristicas",  :limit => 100
    t.decimal  "valor_dolar",                     :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "valor_guarani",                   :precision => 15, :scale => 2, :default => 0.0
    t.string   "escrivania",       :limit => 100
    t.string   "escritura",        :limit => 50
    t.string   "numero",           :limit => 50
    t.integer  "hipotecado"
    t.string   "favorecido",       :limit => 100
    t.integer  "rango"
    t.decimal  "hipoteca_dolar",                  :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "hipoteca_guarani",                :precision => 15, :scale => 2, :default => 0.0
  end

  create_table "menus", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "moedas", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "data"
    t.decimal  "dolar_compra",    :precision => 15, :scale => 2
    t.decimal  "dolar_venda",     :precision => 15, :scale => 2
    t.integer  "usuario_created"
    t.integer  "usuario_updated"
    t.integer  "unidade_created"
    t.integer  "unidade_updated"
  end

  create_table "nota_creditos", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "usuario_created"
    t.integer  "usuario_updated"
    t.integer  "unidade_created"
    t.integer  "unidade_updated"
    t.date     "data"
    t.decimal  "cotacao",                            :precision => 15, :scale => 2, :default => 0.0
    t.integer  "persona_id"
    t.string   "persona_nome",        :limit => 200
    t.string   "ruc",                 :limit => 100
    t.string   "direcao",             :limit => 150
    t.string   "cidade",              :limit => 200
    t.string   "telefone",            :limit => 50
    t.integer  "vendedor_id"
    t.string   "vendedor",            :limit => 200
    t.integer  "tipo"
    t.integer  "moeda"
    t.string   "concepto",            :limit => 100
    t.integer  "operacao"
    t.decimal  "total_dolar",                        :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "total_guarani",                      :precision => 15, :scale => 2, :default => 0.0
    t.integer  "conta_id"
    t.string   "conta_nome",          :limit => 200
    t.string   "cheque",              :limit => 100
    t.date     "diferido"
    t.integer  "documento_id"
    t.string   "documento_nome",      :limit => 150
    t.string   "documento_numero",    :limit => 100
    t.string   "documento_numero_01", :limit => 5
    t.string   "documento_numero_02", :limit => 5
    t.integer  "cidade_id"
  end

  create_table "nota_creditos_detalhes", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "usuario_created"
    t.integer  "usuario_updated"
    t.integer  "unidade_created"
    t.integer  "unidade_updated"
    t.integer  "nota_credito_id"
    t.integer  "produto_id"
    t.string   "produto_nome",        :limit => 200
    t.decimal  "quantidade",                         :precision => 15, :scale => 3, :default => 0.0
    t.decimal  "unitario_dolar",                     :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "unitario_guarani",                   :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "total_dolar",                        :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "total_guarani",                      :precision => 15, :scale => 2, :default => 0.0
    t.integer  "deposito_id"
    t.string   "deposito_nome",       :limit => 100
    t.string   "documento_nome",      :limit => 150
    t.string   "documento_numero",    :limit => 100
    t.string   "documento_numero_01", :limit => 5
    t.string   "documento_numero_02", :limit => 5
    t.string   "codigo",              :limit => 150
    t.string   "fabricante_cod",      :limit => 150
    t.decimal  "iva_dolar",                          :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "iva_guarani",                        :precision => 15, :scale => 2, :default => 0.0
    t.date     "data"
    t.decimal  "taxa",                               :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "cotacao",                            :precision => 15, :scale => 2, :default => 0.0
    t.integer  "venda_id"
  end

  create_table "pagos", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "usuario_created"
    t.integer  "usuario_updated"
    t.integer  "unidade_created"
    t.integer  "unidade_updated"
    t.date     "data"
    t.decimal  "cotacao",                        :precision => 15, :scale => 2
    t.integer  "persona_id"
    t.string   "persona_nome",    :limit => 200
    t.integer  "conta_id"
    t.string   "conta_nome",      :limit => 150
    t.string   "cheque",          :limit => 100
    t.date     "diferido"
    t.decimal  "valor_dolar",                    :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "valor_guarani",                  :precision => 15, :scale => 2, :default => 0.0
    t.integer  "turno_created"
    t.integer  "turno_updated"
    t.integer  "moeda"
    t.string   "ruc",             :limit => 100
    t.integer  "compra_id"
    t.string   "documento_nome",  :limit => 150
    t.integer  "documento_id"
    t.string   "descricao"
    t.string   "document_numero", :limit => 100
  end

  create_table "pagos_detalhes", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "usuario_created"
    t.integer  "usuario_updated"
    t.integer  "unidade_created"
    t.integer  "unidade_updated"
    t.integer  "turno_created"
    t.integer  "turno_updated"
    t.integer  "pago_id"
    t.date     "vencimento"
    t.integer  "persona_id"
    t.string   "persona_nome",        :limit => 200
    t.string   "documento_nome",      :limit => 150
    t.string   "documento_numero",    :limit => 150
    t.integer  "cota"
    t.date     "data"
    t.decimal  "pago_dolar",                         :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "pago_guarani",                       :precision => 15, :scale => 2, :default => 0.0
    t.integer  "liquidacao"
    t.decimal  "anterior_dolar",                     :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "anterior_guarani",                   :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "saldo_dolar",                        :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "saldo_guarani",                      :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "valor_dolar",                        :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "valor_guarani",                      :precision => 15, :scale => 2, :default => 0.0
    t.integer  "estado"
    t.integer  "compra_id"
    t.string   "documento_numero_01", :limit => 5
    t.string   "documento_numero_02", :limit => 5
    t.decimal  "cotacao",                            :precision => 15, :scale => 2
  end

  create_table "pagos_financas", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pago_id"
    t.integer  "conta_id"
    t.string   "conta_nome",       :limit => 150
    t.integer  "persona_id"
    t.string   "persona_nome",     :limit => 200
    t.string   "descricao",        :limit => 200
    t.date     "data"
    t.decimal  "valor_dolar",                     :precision => 15, :scale => 2
    t.decimal  "valor_guarani",                   :precision => 15, :scale => 2
    t.integer  "documento_id"
    t.string   "documento_nome",   :limit => 150
    t.string   "documento_numero", :limit => 50
    t.string   "cheque",           :limit => 50
    t.date     "diferido"
    t.integer  "usuario_created"
    t.integer  "unidade_created"
    t.integer  "unidade_updated"
    t.string   "document_numero",  :limit => 100
  end

  create_table "paises", :force => true do |t|
    t.string   "nome"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "usuario_created"
    t.integer  "usuario_updated"
    t.integer  "unidade_created"
    t.integer  "unidade_updated"
  end

  create_table "personas", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nome",                :limit => 300
    t.string   "direcao",             :limit => 300
    t.string   "bairro",              :limit => 300
    t.string   "cidade",              :limit => 200
    t.string   "telefone",            :limit => 50
    t.date     "data"
    t.string   "direcao_complemento", :limit => 400
    t.string   "ruc",                 :limit => 20
    t.integer  "tipo_fornecedor",                                                   :default => 0
    t.integer  "tipo_cliente",                                                      :default => 0
    t.integer  "tipo_vendedor",                                                     :default => 0
    t.integer  "tipo_funcionario",                                                  :default => 0
    t.integer  "estado",                                                            :default => 0
    t.integer  "tipo",                                                              :default => 0
    t.integer  "tipo_fabricante",                                                   :default => 0
    t.integer  "cidade_id"
    t.string   "classificacao",       :limit => 10
    t.integer  "usuario_created"
    t.integer  "usuario_updated"
    t.integer  "unidade_created"
    t.integer  "unidade_updated"
    t.string   "chapa",               :limit => 20
    t.integer  "tipo_transportadora"
    t.string   "departamento",        :limit => 150
    t.date     "data_entrada"
    t.decimal  "salario",                            :precision => 15, :scale => 2
    t.decimal  "salario_minimo",                     :precision => 15, :scale => 2
    t.decimal  "comissao",                           :precision => 15, :scale => 2
    t.decimal  "ci",                                 :precision => 15, :scale => 2
    t.string   "cod_contabil"
    t.decimal  "ips",                                :precision => 15, :scale => 2
    t.string   "ch",                  :limit => 20
    t.integer  "tipo_mairista"
  end

  create_table "plano_de_contas", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "unidade_created"
    t.integer  "unidade_updated"
    t.integer  "usuario_created"
    t.integer  "usuario_updated"
    t.string   "descricao",       :limit => 200
    t.string   "codigo",          :limit => 20
    t.integer  "cod_contabil"
  end

  create_table "produtos", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nome",                      :limit => 200
    t.string   "embalagem",                 :limit => 30
    t.string   "referencia",                :limit => 20
    t.string   "barra",                     :limit => 20
    t.string   "fabricante_cod",            :limit => 30
    t.integer  "fabricante_id"
    t.decimal  "taxa",                                     :precision => 15, :scale => 2, :default => 0.0
    t.integer  "grupo_id"
    t.integer  "clase_id"
    t.string   "codigo",                    :limit => 20
    t.string   "fabricante",                :limit => 200
    t.integer  "usuario_created"
    t.integer  "usuario_updated"
    t.decimal  "preco_venda_dolar",                        :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "preco_venda_guarani",                      :precision => 15, :scale => 2, :default => 0.0
    t.date     "data"
    t.decimal  "cotacao",                                  :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "custo_produto_dolar",                      :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "custo_produto_guarani",                    :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "custo_produto_dolar_iva",                  :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "custo_produto_guarani_iva",                :precision => 15, :scale => 2, :default => 0.0
    t.integer  "tipo",                                                                    :default => 0
    t.decimal  "quantidade",                               :precision => 15, :scale => 2, :default => 0.0
    t.integer  "numero_bomba",                                                            :default => 0
    t.decimal  "porcentagem",                              :precision => 15, :scale => 2, :default => 0.0
    t.integer  "unidade_created"
    t.integer  "unidade_updated"
    t.string   "cod_contabil",              :limit => 50
    t.integer  "stock_minimo"
    t.integer  "stock_maximo"
    t.decimal  "peso",                                     :precision => 15, :scale => 3
    t.integer  "cod_velho"
    t.decimal  "preco_maiorista_guarani",                  :precision => 15, :scale => 2
    t.decimal  "preco_maiorista_dolar",                    :precision => 15, :scale => 2
    t.decimal  "desconto",                                 :precision => 15, :scale => 2
  end

  create_table "proveedores", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "usuario_created"
    t.integer  "usuario_updated"
    t.integer  "unidade_created"
    t.integer  "unidade_updated"
    t.integer  "tabela_id"
    t.string   "tabela",               :limit => 200
    t.date     "vencimento"
    t.string   "documento_nome",       :limit => 100
    t.string   "documento_numero",     :limit => 100
    t.integer  "cota",                                                               :default => 0
    t.date     "data"
    t.date     "original"
    t.decimal  "divida_dolar",                        :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "divida_guarani",                      :precision => 15, :scale => 2, :default => 0.0
    t.date     "pagamento"
    t.decimal  "pago_dolar",                          :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "pago_guarani",                        :precision => 15, :scale => 2, :default => 0.0
    t.integer  "liquidacao"
    t.string   "persona_nome",         :limit => 200
    t.integer  "persona_id"
    t.integer  "compra_id"
    t.date     "diferido"
    t.integer  "conta_id"
    t.string   "conta_nome",           :limit => 150
    t.string   "cheque",               :limit => 100
    t.integer  "tipo"
    t.integer  "pago_id"
    t.integer  "estado"
    t.integer  "turno_created"
    t.integer  "turno_updated"
    t.string   "documento_numero_01",  :limit => 5
    t.string   "documento_numero_02",  :limit => 5
    t.decimal  "total_divida_dolar",                  :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "total_divida_guarani",                :precision => 15, :scale => 2, :default => 0.0
  end

  create_table "proventos", :force => true do |t|
    t.integer  "usuario_created"
    t.integer  "unidade_created"
    t.integer  "usuario_updated"
    t.integer  "unidade_updated"
    t.string   "descripcion"
    t.string   "cod_contabil"
    t.integer  "estado"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relogio_pontos", :force => true do |t|
    t.date     "data"
    t.time     "hora"
    t.integer  "status"
    t.integer  "turno_id"
    t.string   "turno_nome",    :limit => 150
    t.integer  "usuario_id"
    t.string   "usuario_nome",  :limit => 150
    t.string   "usuario_senha", :limit => 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rubros", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "usuario_created"
    t.integer  "usuario_updated"
    t.integer  "unidade_created"
    t.integer  "unidade_updated"
    t.integer  "plano_de_conta_id"
    t.string   "plano_de_conta_descricao", :limit => 200
    t.string   "descricao",                :limit => 200
    t.string   "codigo",                   :limit => 50
  end

  create_table "servicos", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "usuario_created"
    t.integer  "usuario_updated"
    t.string   "nome",            :limit => 200
    t.integer  "tipo"
    t.decimal  "valor",                          :precision => 15, :scale => 2, :default => 0.0
  end

  create_table "sobrantes_faltantes", :force => true do |t|
    t.date     "data"
    t.integer  "usuario_created"
    t.integer  "unidade_created"
    t.integer  "usuario_updated"
    t.integer  "unidade_updated"
    t.integer  "produto_id"
    t.string   "produto_nome"
    t.integer  "deposito_id"
    t.string   "deposito_nome"
    t.integer  "tipo"
    t.decimal  "quantidade",       :precision => 15, :scale => 3
    t.decimal  "unitario_dolar",   :precision => 15, :scale => 2
    t.decimal  "unitario_guarani", :precision => 15, :scale => 2
    t.decimal  "total_dolar",      :precision => 15, :scale => 2
    t.decimal  "total_guarani",    :precision => 15, :scale => 2
    t.string   "concepto"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "cotacao",          :precision => 15, :scale => 2
    t.string   "codigo"
  end

  create_table "stocks", :force => true do |t|
    t.integer  "usuario_created"
    t.integer  "usuario_updated"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "produto_id"
    t.date     "data"
    t.integer  "status"
    t.decimal  "entrada",                               :precision => 15, :scale => 3, :default => 0.0
    t.decimal  "saida",                                 :precision => 15, :scale => 3, :default => 0.0
    t.decimal  "unitario_dolar",                        :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "unitario_guarani",                      :precision => 15, :scale => 2, :default => 0.0
    t.string   "tabela",                 :limit => 200
    t.integer  "tabela_id"
    t.decimal  "custo_contabil_dolar",                  :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "custo_contabil_guarani",                :precision => 15, :scale => 2, :default => 0.0
    t.integer  "deposito_id"
    t.string   "deposito_nome",          :limit => 150
    t.integer  "unidade_created"
    t.integer  "unidade_updated"
    t.string   "produto_nome",           :limit => 200
    t.integer  "compra_id"
    t.string   "fabricante_cod",         :limit => 50
    t.string   "codigo",                 :limit => 50
    t.integer  "venda_id"
    t.decimal  "frete_dolar",                           :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "frete_guarani",                         :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "desconto_dolar",                        :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "desconto_guarani",                      :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "outros_dolar",                          :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "outros_guarani",                        :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "despacho_dolar",                        :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "despacho_guarani",                      :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "iva_dolar",                             :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "iva_guarani",                           :precision => 15, :scale => 2, :default => 0.0
    t.integer  "ordem_servico_id"
    t.integer  "tipo"
    t.decimal  "quantidade_bomba",                      :precision => 15, :scale => 2, :default => 0.0
    t.integer  "numero_bomba"
    t.integer  "clase_id"
    t.integer  "grupo_id"
    t.integer  "turno_created"
    t.integer  "turno_updated"
    t.integer  "conta_created"
    t.integer  "conta_updated"
    t.integer  "nota_credito_id"
    t.decimal  "promedio_dolar",                        :precision => 15, :scale => 2
    t.decimal  "promedio_guarani",                      :precision => 15, :scale => 2
  end

  add_index "stocks", ["produto_id"], :name => "stock_produto_id"

  create_table "sueldos", :force => true do |t|
    t.integer  "usuario_created"
    t.integer  "unidade_created"
    t.integer  "usuario_updated"
    t.integer  "unidade_updated"
    t.integer  "mes"
    t.integer  "ano"
    t.integer  "persona_id"
    t.string   "persona_nome"
    t.integer  "rubro_id"
    t.string   "rubro_nome"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "salario",         :precision => 15, :scale => 2
    t.decimal  "salario_minimo",  :precision => 15, :scale => 2
    t.decimal  "comissao",        :precision => 15, :scale => 2
    t.decimal  "ci",              :precision => 15, :scale => 2
    t.decimal  "ips",             :precision => 15, :scale => 2
    t.integer  "compra_id"
  end

  create_table "sueldos_detalhes", :force => true do |t|
    t.integer  "usuario_created"
    t.integer  "unidade_created"
    t.integer  "usuario_updated"
    t.integer  "unidade_updated"
    t.integer  "sueldo_id"
    t.date     "data"
    t.decimal  "cotacao",                              :precision => 15, :scale => 2
    t.decimal  "valor_guarani",                        :precision => 15, :scale => 2
    t.decimal  "valor_dolar",                          :precision => 15, :scale => 2
    t.integer  "conta_id"
    t.string   "conta_nome"
    t.integer  "provento_id"
    t.string   "provento_descripcion"
    t.string   "provento_cod_contabil"
    t.integer  "persona_id"
    t.string   "persona_nome"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "estado"
    t.integer  "documento_id"
    t.string   "documento_nome",        :limit => 200
    t.integer  "rubro_id"
    t.string   "rubro_nome",            :limit => 150
    t.integer  "rubro_cod_contabil"
    t.string   "descricao"
    t.integer  "compra_id"
    t.integer  "dias_tr"
  end

  create_table "tabela_preco_produtos", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "usuario_created"
    t.integer  "usuario_updated"
    t.integer  "unidade_created"
    t.integer  "unidade_updated"
    t.integer  "produto_id"
    t.string   "produto_nome",        :limit => 200
    t.string   "fabricante_cod",      :limit => 30
    t.integer  "fabricante_id"
    t.string   "fabricante",          :limit => 200
    t.decimal  "taxa",                               :precision => 15, :scale => 2, :default => 0.0
    t.string   "codigo",              :limit => 200
    t.datetime "data"
    t.decimal  "preco_venda_guarani",                :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "preco_venda_dolar",                  :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "cotacao",                            :precision => 15, :scale => 2, :default => 0.0
    t.string   "tabela",              :limit => 100
    t.integer  "tabela_id"
  end

  create_table "transferencia_contas", :force => true do |t|
    t.date     "data"
    t.decimal  "cotacao",                        :precision => 15, :scale => 2
    t.integer  "ingreso_id"
    t.string   "ingreso_nome",    :limit => 100
    t.integer  "ingreso_moeda"
    t.integer  "destino_id"
    t.string   "destino_nome",    :limit => 100
    t.integer  "destino_moeda"
    t.decimal  "valor_dolar",                    :precision => 15, :scale => 2
    t.decimal  "valor_guarani",                  :precision => 15, :scale => 2
    t.integer  "documento_id"
    t.string   "documento_nome",  :limit => 150
    t.string   "concepto",        :limit => 200
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "usuario_created"
    t.integer  "unidade_created"
    t.integer  "usuario_updated"
    t.integer  "unidade_updated"
  end

  create_table "transferencia_deposito_produtos", :force => true do |t|
    t.date     "data"
    t.integer  "transferencia_deposito_id"
    t.integer  "produto_id"
    t.string   "produto_nome"
    t.decimal  "quantidade",                :precision => 15, :scale => 2
    t.decimal  "decimal",                   :precision => 15, :scale => 2
    t.decimal  "unitario_dolar",            :precision => 15, :scale => 2
    t.decimal  "unitario_guarani",          :precision => 15, :scale => 2
    t.integer  "deposito_origem_id"
    t.string   "deposito_origem_nome"
    t.integer  "deposito_destino_id"
    t.string   "deposito_destino_nome"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transferencia_depositos", :force => true do |t|
    t.date     "data"
    t.integer  "usuario_created"
    t.integer  "unidade_created"
    t.integer  "usuario_updated"
    t.integer  "unidade_updated"
    t.integer  "produto_id"
    t.string   "produto_nome"
    t.string   "codigo"
    t.decimal  "quantidade",                           :precision => 15, :scale => 3
    t.string   "concepto"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "deposito_origem_id"
    t.string   "deposito_origem_nome",  :limit => 150
    t.integer  "deposito_destino_id"
    t.string   "deposito_destino_nome", :limit => 150
    t.decimal  "unitario_guarani",                     :precision => 15, :scale => 2
    t.decimal  "unitario_dolar",                       :precision => 15, :scale => 2
  end

  create_table "turnos", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nome",            :limit => 200
    t.integer  "usuario_created"
    t.integer  "usuario_updated"
    t.integer  "unidade_created"
    t.integer  "unidade_updated"
  end

  create_table "unidades", :force => true do |t|
    t.string   "unidade_nome"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "usuario_created"
    t.integer  "usuaario_updated"
  end

  create_table "usuarios", :force => true do |t|
    t.string   "usuario_nome"
    t.string   "usuario_senha"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tipo"
    t.integer  "usuario_created"
    t.integer  "usuario_updated"
    t.integer  "vendedor_id"
    t.string   "vendedor_nome",   :limit => 150
  end

  add_index "usuarios", ["usuario_nome", "usuario_senha", "id"], :name => "busca"

  create_table "vendas", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tipo"
    t.date     "data"
    t.integer  "moeda"
    t.string   "ruc",                 :limit => 50
    t.string   "persona_nome",        :limit => 200
    t.string   "telefone",            :limit => 50
    t.integer  "persona_id"
    t.integer  "usuario_created"
    t.integer  "usuario_updated"
    t.decimal  "cotacao",                            :precision => 15, :scale => 2
    t.integer  "unidade_created"
    t.integer  "unidade_updated"
    t.integer  "conta_created"
    t.integer  "conta_updated"
    t.integer  "turno_created"
    t.integer  "turno_updated"
    t.string   "direcao",             :limit => 150
    t.string   "bairro",              :limit => 150
    t.integer  "cidade_id"
    t.string   "cidade_nome",         :limit => 200
    t.string   "documento_numero",    :limit => 100
    t.string   "documento_numero_01", :limit => 5
    t.string   "documento_numero_02", :limit => 5
    t.integer  "documento_id"
    t.integer  "fatura"
    t.string   "documento_nome",      :limit => 150
    t.string   "numero_ordem",        :limit => 20
    t.decimal  "quantidade",                         :precision => 15, :scale => 3
    t.decimal  "total_dolar",                        :precision => 15, :scale => 3, :default => 0.0
    t.decimal  "total_guarani",                      :precision => 15, :scale => 3, :default => 0.0
    t.decimal  "exentas",                            :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "gravada_05",                         :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "imposto_05",                         :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "gravada_10",                         :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "imposto_10",                         :precision => 15, :scale => 2, :default => 0.0
    t.integer  "tipo_ordem"
    t.integer  "conta_id"
    t.string   "conta_nome"
    t.integer  "vendedor_id"
    t.string   "vendedor_nome",       :limit => 150
    t.date     "diferido"
    t.string   "ch",                  :limit => 20
    t.integer  "turno_id"
    t.string   "turno_nome"
    t.integer  "transportadora_id"
    t.string   "transportadora_nome"
    t.string   "fatura_ruc",          :limit => 100
    t.string   "fatura_nome",         :limit => 200
  end

  add_index "vendas", ["data"], :name => "busca_data"

  create_table "vendas_financas", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "usuario_created"
    t.integer  "usuario_updated"
    t.integer  "unidade_created"
    t.integer  "unidade_updated"
    t.integer  "venda_id"
    t.integer  "cota"
    t.date     "vencimento"
    t.integer  "conta_id"
    t.string   "conta_nome",            :limit => 200
    t.string   "cheque",                :limit => 100
    t.date     "diferido"
    t.decimal  "valor_dolar_contado",                  :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "valor_guarani_contado",                :precision => 15, :scale => 2, :default => 0.0
    t.integer  "persona_id"
    t.string   "persona_nome",          :limit => 200
    t.decimal  "cotacao",                              :precision => 15, :scale => 2, :default => 0.0
    t.date     "data"
    t.integer  "conta_created"
    t.integer  "conta_updated"
    t.integer  "turno_created"
    t.integer  "turno_updated"
    t.decimal  "valor_dolar_credito",                  :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "valor_guarani_credito",                :precision => 15, :scale => 2, :default => 0.0
    t.string   "direcao",               :limit => 200
    t.string   "bairro",                :limit => 200
    t.string   "ruc",                   :limit => 50
    t.integer  "cidade_id"
    t.string   "cidade_nome",           :limit => 150
    t.string   "fatura_numero",         :limit => 50
    t.string   "documento_nome",        :limit => 150
    t.string   "documento_numero",      :limit => 150
    t.integer  "tipo"
    t.string   "documento_numero_01",   :limit => 5
    t.string   "documento_numero_02",   :limit => 5
    t.integer  "moeda"
    t.integer  "documento_id"
    t.integer  "fatura"
    t.string   "numero_ordem",          :limit => 50
    t.integer  "tipo_ordem"
    t.integer  "transportadora_id"
    t.string   "transportadora_nome",   :limit => 200
    t.string   "ch",                    :limit => 20
    t.integer  "vendedor_id"
    t.string   "vendedor_nome",         :limit => 150
    t.string   "chofer",                :limit => 150
    t.string   "chapa",                 :limit => 150
    t.string   "kilometragem",          :limit => 150
    t.string   "fatura_nome",           :limit => 200
    t.string   "fatura_ruc",            :limit => 100
  end

  create_table "vendas_produtos", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "usuario_created"
    t.integer  "usuario_updated"
    t.integer  "unidade_created"
    t.integer  "unidade_updated"
    t.integer  "venda_id"
    t.integer  "produto_id"
    t.string   "produto_nome",     :limit => 200
    t.decimal  "unitario_dolar",                  :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "unitario_guarani",                :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "total_dolar",                     :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "total_guarani",                   :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "iva_dolar",                       :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "iva_guarani",                     :precision => 15, :scale => 2, :default => 0.0
    t.string   "codigo",           :limit => 100
    t.string   "fabricante_cod",   :limit => 100
    t.decimal  "cotacao",                         :precision => 15, :scale => 2, :default => 0.0
    t.date     "data"
    t.decimal  "quantidade",                      :precision => 15, :scale => 3, :default => 0.0
    t.decimal  "saldo",                           :precision => 15, :scale => 3, :default => 0.0
    t.integer  "conta_created"
    t.integer  "conta_updated"
    t.integer  "turno_created"
    t.integer  "turno_updated"
    t.decimal  "taxa",                            :precision => 15, :scale => 2, :default => 0.0
    t.integer  "tipo"
    t.integer  "clase_id"
    t.integer  "grupo_id"
    t.string   "barra",            :limit => 100
    t.integer  "moeda"
    t.integer  "persona_id"
    t.string   "persona_nome",     :limit => 200
    t.string   "deposito_nome",    :limit => 150
    t.integer  "deposito_id"
    t.integer  "bomba_id"
    t.string   "bomba_nome",       :limit => 100
    t.string   "numero_ordem",     :limit => 50
    t.integer  "tipo_ordem"
  end

  add_index "vendas_produtos", ["venda_id", "total_guarani", "iva_guarani"], :name => "busca_venda_id"

end
