class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.find_all_by(query_params)
    where(query_params)
    .order(:id)
  end
end
