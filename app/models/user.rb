class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :disclaimer_agreement, acceptance: true
  validates :terms_and_conditions_agreement, acceptance: true

  has_many :messages, dependent: :destroy
  has_many :posts, dependent: :destroy
end
