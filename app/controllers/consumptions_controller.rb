class ConsumptionsController < ApplicationController
  before_action :set_consumption, only: %i[ show edit update destroy ]
  before_action :build_form, only: [:edit, :update, :new, :create]
  before_action :authenticate_user!

  def index
    @consumptions = Consumption.all
  end

  def new
    @consumption = Consumption.new
  end

  def create
    respond_to do |format|
      if @form.submit
        format.html { redirect_to @consumption, notice: "Verbraucheintrag erstellt." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @form.submit
        format.html { redirect_to @consumption, notice: "Verbraucheintrag aktualisiert." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @consumption.destroy
    respond_to do |format|
      format.html { redirect_to consumptions_url, notice: "Consumption was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def build_form
    @form = Consumptions::ConsumptionForm.new(@consumption, params[:form])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_consumption
    @consumption = Consumption.find(params[:id])
  end
end
