class Permission < ActiveRecord::Base

  has_many :abilities, dependent: :destroy
  has_many :roles, through: :abilities

end
