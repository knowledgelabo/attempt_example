class Sale < ApplicationRecord
  belongs_to :fiscal_year, dependent: :destroy
  belongs_to :member
end
