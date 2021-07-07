class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update]
  before_action :build_edit_form, only: [:edit, :update]


  def index
    @users = User.all
  end

  def edit
  end

  def update
    respond_to do |format|
      if @form.submit
        format.html { redirect_to edit_user_path(@user), notice: "Benutzerprofil aktualisiert." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def build_edit_form
    @form = Users::UsersForm.new(@user, params[:form])
  end

  def set_user
    @user = current_user
  end
end
