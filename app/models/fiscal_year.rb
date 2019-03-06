class FiscalYear < ApplicationRecord
  has_many :sales, dependent: :destroy
end
