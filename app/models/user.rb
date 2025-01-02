class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist 

  has_many :orders, dependent: :destroy
  after_initialize :set_default_role, if: :new_record?


  validates :first_name, :last_name, presence: true
  validates :role, inclusion: { in: %w[user admin] }


  def admin?
    role == "admin"
  end
  
  private
  def set_default_role
    self.role ||= 'user'
  end
end
