# encoding: UTF-8
module Extenso 
  @@unidade = {
    0 => "CERO",
    1 => "UN",
    2 => 'DOS',
    3 => "TRES",
    4 => "CUATRO",
    5 => "CINCO",
    6 => "SEIS",
    7 => "SIETE",
    8 => "OCHO",
    9 => "NUEVE",
  }
  @@dezena = {
    10 => "DIEZ",
    11 => "ONCE",
    12 => "DOCE",
    13 => "TRECE",
    14 => "CATORCE",
    15 => "QUINCE",
    16 => "DIECISEIS",
    17 => "DIECISIETE",
    18 => "DIECIOCHO ",
    19 => "DIECINUEVE",
    20 => "VEINTE",
    30 => "TREINTA",
    40 => "CUARENTA",
    50 => "CINCUENTA",
    60 => "SESENTA",
    70 => "SETENTA",
    80 => "OCHENTA",
    90 => "NOVENTA" }
  @@centena = {100 => "CIEN",
    200 => "DOSCIENTOS",
    300 => "TRESCIENTOS",
    400 => "CUATRO",
    500 => 'QUINIENTOS',
    600 => "SEISCIENTOS",
    700 => "SETECIENTOS",
    800 => "OCHOCIENTOS",
    900 => "NOVECIENTOS"}
  
  # Escreve o numero por extenso.
  # 
  # Exemplo:
  #  1.por_extenso ==> 'um'
  #  100.por_extenso ==> 'cem'
  #  158.por_extenso ==> 'cento e cinquenta e oito'
  def por_extenso
    Extenso.por_extenso(self)
  end
  
  # Alias para o metodo por_extenso
  alias_method :to_extenso, :por_extenso
  
  # Escreve o numero por extenso.
  # 
  # Exemplo:
  #  Extenso.por_extenso(1) ==> "um"
  #  Extenso.por_extenso(100) ==> "cem"
  #  Extenso.por_extenso(158) ==> "cento e cinquenta e oito"  
  def Extenso.por_extenso(numero)
    negativo=(numero<0)? "menos " : ""
    n=numero.to_i.abs
    return case n
    when 0..9 then negativo + @@unidade[n].to_s
    when 10..19 then negativo + @@dezena[n].to_s
    when 20..99
      v=n % 10
      if  v== 0
        negativo + @@dezena[n].to_s
      else
        "#{negativo}#{@@dezena[n-v]} y #{por_extenso(v)}"
      end
    when 100
      negativo+"CIEN"
    when 101..999
      v=n % 100
      if  v== 0
        negativo + @@centena[n].to_s
      else
        "#{negativo}#{@@centena[n-v]} Y #{por_extenso(v)}"
      end
    when 1000..999999
      m,c=n/1000,n%1000
      %(#{negativo}#{por_extenso(m)} MIL#{c > 0 ? " Y #{por_extenso(c)}":''})
    when 1_000_000..999_999_999
      mi,m=n/1_000_000,n%1_000_000
      %(#{negativo}#{por_extenso(mi)} MIL#{mi > 1 ? 'LONES':'LON'}#{m > 0 ? " Y #{por_extenso(m)}" : ''})
    when 1_000_000_000..999_999_999_999
      bi,mi=n/1_000_000_000,n%1_000_000_000
      %(#{negativo}#{por_extenso(bi)} BIL#{bi > 1 ? 'LONES':'LON'}#{mi > 0 ? " Y #{por_extenso(mi)}" : ''})
    when 1_000_000_000_000..999_999_999_999_999
      tri,bi=n/1_000_000_000_000,n%1_000_000_000_000
      %(#{negativo}#{por_extenso(tri)} TRIl#{tri > 1 ? 'LONES':'LON'}#{bi > 0 ? " Y #{por_extenso(bi)}" : ''})
    else
      raise "Valor excede o permitido: #{n}"
    end
  end
end

module ExtensoReal
  include Extenso
 
  # Escreve por extenso em reais.
  # 
  # Exemplo:
  #  1.por_extenso_em_reais ==> 'um real'
  #  (100.58).por_extenso_em_reais ==> 'cem reais e cinquenta e oito centavos'
  def por_extenso_em_reais
    ExtensoReal.por_extenso_em_reais(self)
  end
  
  # Alias para por_extenso_em_reais
  alias_method :to_extenso_real, :por_extenso_em_reais

  # Escreve o numero por extenso em reais.
  # 
  # Exemplo:
  #  Extenso.por_extenso_em_reais(1) ==> "um real"
  #  Extenso.por_extenso_em_reais(100) ==> "cem reais"
  #  Extenso.por_extenso_em_reais(100.58) ==> "cem reais e cinquenta e oito centavos"  
  def ExtensoReal.por_extenso_em_reais(valor)
    negativo=(valor<0)? " negativo" : ""
    negativos=(valor<0)? " negativos" : ""
    valor = valor.abs
    return 'grátis' if valor == 0
    case valor
    when Integer
      extenso = Extenso.por_extenso(valor)
      if extenso =~ /^(.*)(ão$|ões$)/
        complemento = 'de '
      else
        complemento = ''
      end
      %(#{extenso} #{valor <= 1 ? "real#{negativo}": "#{complemento}reais#{negativos}"})
    when Float
      real,cents=("%.2f" % valor).split(/\./).map{ |m| m.to_i}
      valor_cents=Extenso.por_extenso(cents%100)
      valor_cents+= case cents.to_i%100
      when 0 then ""
      when 1 then " centavo"
      when 2..99 then " centavos"
      end

      if real.to_i > 0
        "#{ExtensoReal.por_extenso_em_reais(real.to_i)}#{cents > 0 ? ' Y' + valor_cents + negativos : real.to_i > 1 ? negativos : negativo }"
      else
        if (cents.to_i%100)==1
           "#{valor_cents}#{negativo}"
        else
           "#{valor_cents}#{negativos}"
        end
      end
    else
      ExtensoReal.por_extenso_em_reais(valor.to_s.strip.gsub(/[^\d]/,'.').to_f)
    end
  end
end

Numeric.send(:include, ExtensoReal)

