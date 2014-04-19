class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable, :registerable, :validatable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable

  validates_uniqueness_of :email


end
