class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :disclaimer_agreement, acceptance: true
  validates :terms_and_conditions_agreement, acceptance: true

  has_many :messages, dependent: :destroy
  has_many :posts, dependent: :destroy

  def disclaimer_agreement_value
    if disclaimer_agreement != true
      errors.add(:disclaimer_agreement, "Disclaimer agreement must be selected")
    end
  end

  def terms_and_conditions_agreement_value
    if terms_and_conditions_agreement != true
      errors.add(:terms_and_conditions_agreement, "Disclaimer agreement must be selected")
    end
  end
end
