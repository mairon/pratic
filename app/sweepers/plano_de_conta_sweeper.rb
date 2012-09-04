class PlanoDeContaSweeper < ActionController::Caching::Sweeper
  observe PlanoDeConta

  def after_save(plano_de_conta)
    expire_cache(plano_de_conta)
  end

  def after_destroy(plano_de_conta)
    expire_cache(plano_de_conta)
  end

  def expire_cache(plano_de_conta)
    expire_fragment 'plano_de_conta_index'
  end
end