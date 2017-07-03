class DecksController < ApplicationController
  before_action :set_deck, only: [:show, :edit, :update, :destroy, :play]
  before_action :authenticate_user!, except: [:show, :play]
  before_action :ensure_owned!, only: [:edit, :update, :destroy]

  # GET /decks
  def index
    @decks = current_user.decks
  end

  # GET /decks/1
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
  def create
    @deck = Deck.new(deck_params)

    if @deck.save
      redirect_to deck_path(@deck), notice: 'Deck was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /decks/1
  def update
    if @deck.update(deck_params)
      redirect_to deck_path(@deck), notice: 'Deck was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /decks/1
  # DELETE /decks/1.json
  def destroy
    @deck.destroy
    redirect_to decks_path, notice: 'Deck was successfully destroyed.'
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
      params.require(:deck).permit(:name, :description, :user_id, :initial_hand_size, :uses_deck, :readyable, cards_attributes: [:id, :name, :description, :readied, :always_draw, :_destroy])
    end
end
