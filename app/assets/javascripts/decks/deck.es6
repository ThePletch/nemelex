class Deck {
  constructor(cards, initialHandSize, readyable, usesDeck) {
    // keep the set of all cards somewhere so we can reference it without worrying about
    // its state
    this.allCards = cards.slice(0);
    this.deck = cards;
    this.hand = [];
    this.discardPile = [];
    this.initialHandSize = initialHandSize;
    this.usesDeck = usesDeck;

    this.render();
  }

  deal() {
    this.reshuffle();
    for (let i = 0; i < this.initialHandSize - this.alwaysDrawCards().length; i += 1) {
      this.draw();
    }

    this.render();
  }

  reshuffle() {
    if (this.usesDeck) {
      this.hand = this.alwaysDrawCards();
      this.deck = this.allCards.slice(0).filter(c => !c.alwaysDraw);
    } else {
      this.hand = this.allCards.slice(0)
      this.deck = [];
    }

    this.discardPile = [];

    this.render();
  }

  // todo error handling
  draw() {
    const randomCardIndex = Math.floor((Math.random() * this.deck.length));

    this.hand = this.hand.concat(this.deck.splice(randomCardIndex, 1));

    this.render();
  }

  // todo error handling
  discard(card) {
    const cardIndex = this.hand.indexOf(card);
    this.discardPile = this.discardPile.concat(this.hand.splice(cardIndex, 1));

    this.render();
  }

  restore(card) {
    const cardIndex = this.discardPile.indexOf(card);
    this.hand = this.hand.concat(this.discardPile.splice(cardIndex, 1));

    this.render();
  }

  alwaysDrawCards() {
    return this.allCards.slice(0).filter(c => c.alwaysDraw);
  }

  isDrawable() {
    return this.deck.length > 0;
  }

  render() {
    this.deck.map(x => { return x.renderInDeck(); });

    this.hand.map(x => { return x.renderInHand(); });

    this.discardPile.map(x => { return x.renderDiscarded(); });
  }
}
