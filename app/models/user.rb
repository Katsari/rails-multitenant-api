# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  multi_tenant :tenant

  belongs_to :role

  validates :username, :email, :name, presence: true
  validates :email, :username, uniqueness: { case_sensitive: false }
end
