class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Create associations with Person model via user_person_joins
  has_many :user_person_joins
  has_many :people, through: :user_person_joins
  # Create associations with Location model via user_location_joins
  has_many :user_location_joins
  has_many :locations, through: :user_location_joins
  # Create many to one association with League
  belongs_to :league
end
