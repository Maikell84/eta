class HomeController < ApplicationController
  before_action :set_home, only: %i[ show edit update destroy ]

  # GET /home or /home.json
  def index
  end

end
