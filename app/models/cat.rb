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

  has_many(
  :cat_rental_requests,
  :class_name => "CatRentalRequest",
  :foreign_key => :cat_id,
  :dependent => :destroy
  )


  def overlapping_requests
    overlaps = []
    requests = cat_rental_requests
    (requests.length - 1).times do |idx1|
        (idx1+1..requests.length).times do |idx2|
          if requests[idx1].start_date > requests[idx2].end_date ||
            requests[idx2].start_date > requests[idx1].end_date
            overlaps << request[idx1] << request[idx2]
          end
        end
      end
    overlaps.uniq
  end

  def no_overlapping_approved_requests?
    !overlapping_requests.any?{ |request| request.status == "approved"}
  end


end##########################
