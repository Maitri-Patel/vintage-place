class Product < ApplicationRecord
  belongs_to :category
  validates :category, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["id", "name", "description", "price", "quantity_available", "category_id", "created_at", "updated_at"]
  end
  
  # Allowlists associations that can be searched through Ransack
  def self.ransackable_associations(auth_object = nil)
    ["category"]
  end
  
end
