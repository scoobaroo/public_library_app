class User < ActiveRecord::Base
  has_secure_password
  def self.confirm(params)
    @user = User.find_by({email: params[:email]})
    @user.try(:authenticate, params[:password])
  end
  validates :email, uniqueness: true
  has_many :library_users
  has_many :libraries, through: :library_users, dependent: :destroy
end
