class StoragesController < ApplicationController
  before_action :set_storage, only: %i[ show edit update destroy ]
  before_action :build_form, only: [:edit, :update, :new, :create]
  before_action :authenticate_user!

  def index
    @storages = Storage.order('created_at ASC')
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
  def set_consumption
    @storage = Storage.find(params[:id])
  end
end
