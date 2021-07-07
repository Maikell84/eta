class AshesController < ApplicationController
  before_action :set_ash, only: %i[ show edit update destroy ]
  before_action :build_form, only: [:edit, :update, :new, :create]

  def index
    @pagy, @ashes = pagy(Ash.all.order(created_at: :desc))
  end

  def new
    @ash = Ash.new
  end

  def create
    respond_to do |format|
      if @form.submit
        format.html { redirect_to @ash, notice: "Ascheeintrag erstellt." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @form.submit
        format.html { redirect_to @ash, notice: "Lagereintrag aktualisiert." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ash.destroy
    respond_to do |format|
      format.html { redirect_to storages_url, notice: "Ash was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def build_form
    @form = Ashes::AshesForm.new(@ash, params[:form])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_ash
    @ash = Ash.find(params[:id])
  end
end
