class CardsController < ApplicationController
  before_action :set_deck, except: [:destroy]
  before_action :authenticate_user!

  # GET /cards/new
  def new
    @card = Card.new(deck: @deck)
  end

  # POST /cards
  # POST /cards.json
  def create
    @card = Card.new(card_params)

    respond_to do |format|
      if @card.save
        format.html { redirect_to deck_path(@deck), notice: 'Card was successfully created.' }
        format.json { render :show, status: :created, location: @card }
      else
        format.html { render :new }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_deck
    @deck = Deck.find(params[:deck_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def card_params
    params.require(:card).permit(:name, :description, :deck_id, :readied)
  end
end
