class User < ActiveRecord::Base

  has_secure_password( validations: false )

  # associations connected to tkh_content gem. Any page or comment model will do
  # FIXME - remove these dependencies. find other way.
  has_many :pages
  # disable this to temporarily fix Madrid bug. Madrid uses different comment schema
  # has_many :comments, dependent: :destroy, foreign_key: 'author_id'

  # authorization
  has_many :powers, dependent: :destroy
  has_many :roles, through: :powers

  has_many :permissions, through: :roles

  validates_presence_of :email
  validates_uniqueness_of :email, :case_sensitive => false

  attr_accessor :remember_me

  scope :alphabetically, -> { order('last_name, first_name') }
  scope :administrators, -> { joins(:roles).where('roles.name = ?', 'admin') }

  scope :by_recent, -> { order('updated_at desc') }

  before_create { generate_token(:auth_token) }

  # use the stringex gem to create slug | usually on the title or name attribute
  def to_param
    "#{id}-#{name.to_url}"
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def formal_name
    "#{last_name}, #{first_name}".strip
  end

  def friendly_name
    other_name.present? ? other_name : first_name
  end

  def spiritual_name
    if other_name.present?
      other_name
    elsif name.present?
      name
    else
      'anonymous'
    end
  end

  def visible_name_present? # used in tkh_access_control to determin whether to show name fields in login form
    name.present? || other_name.present?
  end

  def has_a_password?
    password_digest
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64(40)
    end while User.exists?(column => self[column])
  end

  def role_names
    roles.map(&:name)
  end

  # Check if a user has a role.
  def has_role?(role)
    role_names.include? role.to_s
  end

  def is_allowed_to?(permission)
    self.permissions.pluck(:name).include? permission
  end

end
