class Risk < ActiveRecord::Base
  serialize :covariates, HashSerializer
  store_accessor :covariates, :vehicles_category
end
