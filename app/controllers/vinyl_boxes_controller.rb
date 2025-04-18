class VinylBoxesController < ApplicationController
  before_action :authenticate_user!

  def index
    @vinyls = current_user.vinyls.limit(5)
  end

  def new
    @vinyl_box = VinylBox.new
  end

  def show
    @user = current_user
    @vinyl_box = @user.vinyl_box || @user.create_vinyl_box

    if params[:query].present?
      sql_subquery = "vinyls.artist ILIKE :query OR vinyls.title ILIKE :query OR vinyls.genre ILIKE :query"
      @vinyls = @user.vinyls.where(sql_subquery, query: "%#{params[:query]}%")
    else
      @vinyls = @user.vinyls.limit(10)
    end

    @carousel_vinyls = @user.vinyls.limit(3)

    # @all_slots = @vinyl_box.slots.includes(:vinyl)
    # @available_slots = @all_slots.select { |slot| slot.vinyl.nil? }
  end
end
