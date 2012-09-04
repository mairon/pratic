class Provento < ActiveRecord::Base

  validates_presence_of :descripcion,
                        :cod_contabil


end
