class VinylsController < ApplicationController
  before_action :set_vinyl, only: %i[update destroy edit show]


  def index
    @vinyls = Vinyl.all
  end

  def show
    @vinyl = Vinyl.find(params[:id])
  end

  def new
    @vinyl = Vinyl.new
  #     @all_slots = @vinyl_box.slots.includes(:vinyl)
  # @available_slots = @all_slots.select { |slot| slot.vinyl.nil? }

  # # Créer des slots supplémentaires si aucun n'est disponible
  # if @available_slots.empty?
  #   5.times do |i|
  #     position = (@all_slots.maximum(:position) || 0) + 1 + i
  #     @vinyl_box.slots.create(position: position)
  #   end
  #   @all_slots = @vinyl_box.slots.reload.includes(:vinyl)
  #   @available_slots = @all_slots.select { |slot| slot.vinyl.nil? }
  # end
  end

  def create
    @vinyl = Vinyl.new(vinyl_params)
    @vinyl.user = current_user
    # @all_slots = current_user.vinyl_box.slots
    # @available_slots = current_user.vinyl_box.slots.includes(:vinyl).select { |slot| slot.vinyl.nil? }
    if @vinyl.save
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
    @vinyl.destroy
    redirect_to root_path, status: :see_other, notice: "Vinyle retiré avec succès."
  end

  private

  def set_vinyl
    @vinyl = Vinyl.find(params[:id])
  end

  def vinyl_params
    params.require(:vinyl).permit(:title, :artist, :genre, :release_year, :photo, :slot_id)
  end
end
