class Category < ApplicationRecord
    has_many :products, dependent: :destroy

    def self.ransackable_attributes(auth_object = nil)
        %w[name created_at updated_at]
    end
end
