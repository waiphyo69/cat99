class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = self.current_user.id
    if @cat.save
      redirect_to cat_url(@cat.id)
    else
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    if current_user.cats.include?(@cat)
      render :edit
    else
      redirect_to cats_url
    end
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      redirect_to cat_url(@cat.id)
    else
      render :edit
    end
  end

  private
  def cat_params
    params.require(:cat).permit(:name, :color, :birth_date, :sex, :description)
  end

end
