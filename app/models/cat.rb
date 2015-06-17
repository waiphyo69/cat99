class Cat < ActiveRecord::Base
  COLORS =[
    "white",
    "yellow",
    "black",
    "brown"
  ]

  SEX = [
    "M",
    "F"
  ]

  validates :color, inclusion: { in: COLORS}
  validates :sex, inclusion: { in: SEX}
  validates :name, presence: true
  validates :birth_date, presence: true
  validate :no_overlapping_approved_requests? => true

  belongs_to :owner, class_name: 'User', foreign_key: :user_id
  
  has_many(
  :cat_rental_requests,
  :class_name => "CatRentalRequest",
  :foreign_key => :cat_id,
  :dependent => :destroy
  )


end##########################
