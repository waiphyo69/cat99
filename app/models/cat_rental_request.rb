class CatRentalRequest < ActiveRecord::Base

  STATUS = [
    "pending",
    "approved",
    "denied"
  ]

  validates :status, inclusion: { in: STATUS}
  validate :no_overlapping_approved_requests

  belongs_to(
  :cat,
  :class_name => 'Cat',
  :foreign_key => :cat_id,
  :primary_key => :id
  )


  # def overlapping_requests
  #   overlaps = []
  #   requests = self.cat.cat_rental_requests
  #   (0..requests.length - 2).each do |idx1|
  #       (idx1+1..requests.length-1).each do |idx2|
  #         if !(requests[idx1].start_date > requests[idx2].end_date ||
  #           requests[idx2].start_date > requests[idx1].end_date)
  #           puts idx2
  #           overlaps << request[idx1] << request[idx2]
  #         end
  #       end
  #     end
  #   overlaps.uniq
  # end

  # def approved_requests
  #   self.cat.cat_rental_requests.select{ |request| request.status == "approved"}
  # end

  def other_approved_requests
    # self.cat.cat_rental_requests.select {|request| (request.id != self.id) &&
    #   (request.status == "approved")}
    self.cat.cat_rental_requests.find_by_sql([<<-SQL, self.cat_id])
    SELECT
      cat_rental_requests.*
    FROM
      cat_rental_requests JOIN cats ON cats.id = cat_rental_requests.cat_id
    WHERE
      (cat_rental_requests.status = "approved")
      AND (cats.id = ?)
    SQL
  end

  def no_overlapping_approved_requests
    other_approved_requests.each do |request|
      if !(start_date > request.end_date || end_date < request.start_date)
        errors[:cat_id] << "error!!!!"
      end
    end
  end
end
