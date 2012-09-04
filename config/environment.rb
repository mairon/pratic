ENV['RAILS_ENV'] ||= 'production'
RAILS_GEM_VERSION = '2.3.8' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  #CONTROLE DE EMPRESA
#  $empresa = 'E01'
#  $empresa_nome = 'AGROEXPRESS S.A.'
  $empresa = 'E03'
  $empresa_nome = 'Sudamericana S.R.L.'

  config.load_paths << "#{RAILS_ROOT}/app/sweepers"
  config.time_zone = 'UTC'  
  config.gem 'spreadsheet'
  config.gem 'pdfkit'
  config.i18n.default_locale = 'pt-BR'
  config.middleware.use "PDFKit::Middleware"

end
require 'brazilian-rails'
require "will_paginate"
require "pdfkit"


