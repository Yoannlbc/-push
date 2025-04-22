class VinylBoxesController < ApplicationController
  before_action :authenticate_user!

  def index
    @vinyls = current_user.vinyls.limit(5)
    generate_vinyl_colors(current_user.vinyls)
  end

  def new
    @vinyl_box = VinylBox.new
  end

  def show
    @user = current_user
    @vinyl_box = @user.vinyl_box || @user.create_vinyl_box

    ensure_slots(@vinyl_box, 10)

    if params[:query].present?
      sql_subquery = "vinyls.artist ILIKE :query OR vinyls.title ILIKE :query OR vinyls.genre ILIKE :query"
      @vinyls = @user.vinyls.where(sql_subquery, query: "%#{params[:query]}%")
    else
      @vinyls = @user.vinyls
    end

    @carousel_vinyls = @user.vinyls.limit(3)

    @all_slots = @vinyl_box.slots.includes(:vinyl)
    @filled_slots = @all_slots.select { |slot| slot.vinyl.present? }
    @empty_slots = @all_slots.select { |slot| slot.vinyl.nil? }

    generate_vinyl_colors(@user.vinyls)
  end

  private

  def generate_vinyl_colors(vinyls_collection)
    colors = [
      "#d16b6b", "#c0c06c", "#9ed19e", "#d577af", "#d6a6d6",
      "#5fa3a3", "#8c8c8c", "#70b170", "#d6b63c", "#4e5fd1",
      "#d13c3c", "#d15b7b", "#7b1a38", "#d4d4d4", "#6a9ec9",
      "#b18c5f", "#9966cc", "#a7d78c", "#d19c6b", "#6ac9a7"
    ]

    @vinyl_colors = {}
    vinyls_collection.each_with_index do |vinyl, index|
    color_index = Digest::MD5.hexdigest(vinyl.title + vinyl.artist.to_s).to_i(16) % colors.length
    @vinyl_colors[vinyl.id] = colors[color_index]
    end
  end

  def ensure_slots(vinyl_box, total_slots)

    filled_slots_count = vinyl_box.slots.joins(:vinyl).count
    required_slots = [total_slots, filled_slots_count + 1].max

    current_slots_count = vinyl_box.slots.count
    if current_slots_count < required_slots

      (required_slots - current_slots_count).times do
        vinyl_box.slots.create
      end
    end
  end
end
