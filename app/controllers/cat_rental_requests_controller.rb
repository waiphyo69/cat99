class CatRentalRequestsController < ApplicationController
  def index
    @cat = Cat.find_by_id(params[:cat_id])
    @requests = CatRentalRequest.where(cat_id: params[:cat_id])
  end

  def new
    @request = CatRentalRequest.new
    render :new
  end

  def create
    @request = CatRentalRequest.new(request_params)
    if @request.save
      redirect_to cat_cat_rental_requests_url(params[:cat_rental_request][:cat_id])
    else
      render :new
    end
  end


  private
  def request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date, :status)
  end

end
