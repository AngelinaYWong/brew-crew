class BrewsController < ApplicationController
  def index
    @brews = Brew.all
    render :index
  end

  def show
    @brew = Brew.all.find(params[:id])
    render :show
  end

  def new
    @brew = Brew.new
    render :new # The form
  end

  def create
    @brew = Brew.create(brew_params)
    # binding.pry

    if !@brew.id.nil?
      redirect_to brew_path(@brew)
    else
      render :new
    end
  end

  def edit
    @brew = find_brew
    render :edit
  end

  def update
    @brew = find_brew
    @brew.update(brew_params)

    redirect_to brew_path(@brew)
    # redirect_to @brew
  end

  def destroy
    @brew = find_brew
    @brew.destroy
    binding.pry

    # redirect_to :index
    redirect_to brews_path
  end

  def strongest
    @brews = Brew.all.sort_by do |brew| brew.strength end.reverse
    render 'brews/index.html.erb'
  end

  private
  def brew_params
    params.require(:brew).permit(:blend_name, :origin, :notes, :strength)
  end

  def find_brew
    brew = Brew.find(params[:id])
  end
end
