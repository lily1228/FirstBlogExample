class User < ActiveRecord::Base
  has_and_belongs_to_many :roles
  has_many :articles
  before_create :setup_role
 
  private
  def setup_role
    if self.role_ids.empty?
      self.role_ids = [3]
    end
  end
  
  public
  def role?(role)
    return !!self.roles.find_by_name(role.to_s)
   end
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
end
