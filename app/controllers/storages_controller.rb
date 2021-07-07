class StoragesController < ApplicationController
  before_action :set_storage, only: %i[ show edit update destroy ]
  before_action :build_form, only: [:edit, :update, :new, :create]

  def index
    @pagy, @storages = pagy(Storage.all.order(created_at: :desc))
  end

  def new
    @storage = Storage.new
  end

  def create
    respond_to do |format|
      if @form.submit
        format.html { redirect_to @storage, notice: "Lagereintrag erstellt." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @form.submit
        format.html { redirect_to @storage, notice: "Lagereintrag aktualisiert." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @storage.destroy
    respond_to do |format|
      format.html { redirect_to storages_url, notice: "Storage was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def build_form
    @form = Storages::StoragesForm.new(@storage, params[:form])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_storage
    @storage = Storage.find(params[:id])
  end
end
