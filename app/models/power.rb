class Power < ActiveRecord::Base

  belongs_to :user, touch: true
  belongs_to :role

end
