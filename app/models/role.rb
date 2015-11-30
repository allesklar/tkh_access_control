class Role < ActiveRecord::Base

  has_many :powers, dependent: :destroy
  has_many :users, through: :powers

  has_many :abilities, dependent: :destroy
  has_many :permissions, through: :abilities

  scope :alphabetically, -> { order('name') }

end
