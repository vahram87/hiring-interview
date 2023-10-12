class Manager < ApplicationRecord
  has_many :transactions

  def full_name
    "#{first_name} #{last_name}"
  end
end
