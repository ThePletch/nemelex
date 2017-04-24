class DecksController < ApplicationController
  before_action :set_deck, only: [:show, :edit, :update, :destroy, :play]
  before_action :authenticate_user!, except: [:show, :play]
  before_action :ensure_owned!, only: [:edit, :update, :destroy]

  # GET /decks
  # GET /decks.json
  def index
    @decks = current_user.decks
  end

  # GET /decks/1
  # GET /decks/1.json
  def show
  end

  def play
  end

  # GET /decks/new
  def new
    @deck = Deck.new
  end

  # GET /decks/1/edit
  def edit
  end

  # POST /decks
  # POST /decks.json
  def create
    @deck = Deck.new(deck_params)

    respond_to do |format|
      if @deck.save
        format.html { redirect_to deck_path(@deck), notice: 'Deck was successfully created.' }
        format.json { render :show, status: :created, location: @deck }
      else
        format.html { render :new }
        format.json { render json: @deck.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /decks/1
  # PATCH/PUT /decks/1.json
  def update
    respond_to do |format|
      if @deck.update(deck_params)
        format.html { redirect_to deck_path(@deck), notice: 'Deck was successfully updated.' }
        format.json { render :show, status: :ok, location: @deck }
      else
        format.html { render :edit }
        format.json { render json: @deck.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /decks/1
  # DELETE /decks/1.json
  def destroy
    @deck.destroy
    respond_to do |format|
      format.html { redirect_to decks_path, notice: 'Deck was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deck
      @deck = Deck.find(params[:id])
    end

    def ensure_owned!
      unless Deck.find(params[:id]).user == current_user
        redirect_to decks_path, alert: 'You can only modify decks you own.'

        return false
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def deck_params
      params.require(:deck).permit(:name, :description, :user_id, :initial_hand_size, cards_attributes: [:id, :name, :description, :readied, :_destroy])
    end
end
