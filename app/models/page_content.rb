class PageContent < ApplicationRecord

  validates :title, presence: true
  validates :slug, presence: true, uniqueness: { case_sensitive: false }
  validates :content, presence: true
  
  def self.ransackable_attributes(auth_object = nil)
    %w[title slug content created_at updated_at]
  end
end
