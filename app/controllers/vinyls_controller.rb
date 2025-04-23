class VinylsController < ApplicationController
  before_action :set_vinyl, only: %i[update destroy edit show]

  def index
    @vinyls = Vinyl.all
    generate_vinyl_colors(@vinyls)
  end

  def show
    @vinyl = Vinyl.find(params[:id])
  end

  def new
    @vinyl = Vinyl.new
    @slot_id = params[:slot_id] if params[:slot_id].present?

    if current_user.vinyl_box
      @all_slots = current_user.vinyl_box.slots
      @empty_slots = @all_slots.select { |slot| slot.vinyl.nil? }
    end
  end

  def create
    @vinyl = Vinyl.new(vinyl_params)
    @vinyl.user = current_user

    if @vinyl.save
      if params[:slot_id].present?
        slot = Slot.find(params[:slot_id])
        slot.update(vinyl: @vinyl) if slot && slot.vinyl.nil?
      end

      vinyl_box = current_user.vinyl_box || current_user.create_vinyl_box
      ensure_fresh_slot(vinyl_box)

      redirect_to root_path, notice: "Vinyle ajouté avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @vinyl.slot = Slot.find(params[:slot_id].to_i) if params[:slot_id].present?
    @all_slots = current_user.vinyl_box.slots
    @available_slots = current_user.vinyl_box.slots.includes(:vinyl).select { |slot| slot.vinyl_box.nil? }
  end

  def update
    @available_slots = current_user.vinyl_box.slots.includes(:vinyl).select { |slot| slot.vinyl.nil? }
    @all_slots = current_user.vinyl_box.slots
    if @vinyl.update(vinyl_params)
      redirect_to vinyl_path(@vinyl), notice: "Vinyle modifié avec succès."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    slot = Slot.find_by(vinyl: @vinyl)
    slot.update(vinyl: nil) if slot
    @vinyl.destroy

    redirect_to root_path, status: :see_other, notice: "Vinyle retiré avec succès."
  end

  private

  def ensure_fresh_slot(vinyl_box)
    empty_slots = vinyl_box.slots.includes(:vinyl).select { |slot| slot.vinyl.nil? }
    vinyl_box.slots.create if empty_slots.empty?
  end

  def set_vinyl
    @vinyl = Vinyl.find(params[:id])
  end

  def vinyl_params
    params.require(:vinyl).permit(:title, :artist, :genre, :release_year, :photo)
  end

  def generate_vinyl_colors(vinyls_collection)
    colors = [
      "#d16b6b", "#c0c06c", "#9ed19e", "#d577af", "#d6a6d6",
      "#5fa3a3", "#8c8c8c", "#70b170", "#d6b63c", "#4e5fd1",
      "#d13c3c", "#d15b7b", "#7b1a38", "#d4d4d4", "#6a9ec9",
      "#b18c5f", "#9966cc", "#a7d78c", "#d19c6b", "#6ac9a7"
    ]

    @vinyl_colors = {}
    vinyls_collection.each do |vinyl|
      color_index = vinyl.id.to_i % colors.length
      @vinyl_colors[vinyl.id] = colors[color_index]
    end
  end
end
