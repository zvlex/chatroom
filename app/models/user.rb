class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :email, :password, :password_confirmation, presence: true, if: :new_record?
  validates :email, uniqueness: true
  validates :password, length: { minimum: 6 }, if: :new_record?
  validates :password, confirmation: true, if: :new_record?
end
