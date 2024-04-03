class PageContent < ApplicationRecord
    # Defines attributes that can be searchable in Active Admin
  def self.ransackable_attributes(auth_object = nil)
    %w[title slug content created_at updated_at]
  end
end
