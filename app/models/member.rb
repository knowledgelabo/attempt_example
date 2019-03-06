class Member < ApplicationRecord
  belongs_to :division
  has_many :sales, dependent: :nullify
end
