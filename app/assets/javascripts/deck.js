class Deck {
  constructor(cards, initialHandSize) {
    // keep the set of all cards somewhere so we can reference it without worrying about
    // its state
    this.allCards = cards.slice(0);
    this.deck = cards;
    this.hand = [];
    this.discardPile = [];
    this.initialHandSize = initialHandSize;

    this.render();
  }

  deal() {
    console.log("DEAL");
    this.reshuffle();
    console.log(this.deck);
    console.log(this.hand);
    for (var i = 0; i < this.initialHandSize; i++) {
      this.draw();
    }
    console.log(this.hand);

    this.render();
  }

  reshuffle() {
    this.hand = [];
    this.deck = this.allCards.slice(0);
    this.discardPile = [];

    this.render();
  }

  // todo error handling
  draw() {
    let randomCardIndex = Math.floor((Math.random() * this.deck.length));

    this.hand = this.hand.concat(this.deck.splice(randomCardIndex, 1));

    this.render();
  }

  // todo error handling
  discard(card) {
    let cardIndex = this.hand.indexOf(card);
    this.discardPile = this.discardPile.concat(this.hand.splice(cardIndex, 1));

    this.render();
  }

  render() {
    this.deck.map(x => { x.renderInDeck(); });

    this.hand.map(x => { x.renderInHand(); });

    this.discardPile.map(x => { x.renderDiscarded(); });
  }
}

class Card {
  constructor(id) {
    this.id = id;
    this.jq = $(`#card-${id}`);
    // any color changes need to be applied to the card object, hence it being
    // tracked separately
    this.cardObject = this.jq.find(".card");
    this.discardedMarker = this.jq.find(".discarded");
    this.discardButton = this.jq.find(".discard");

    this.discardButton.click(_ => {
      console.log(window.deck);
      window.deck.discard(this);
    });
  }

  renderInHand() {
    this.cardObject.removeClass('card-inverse card-warning');
    this.discardedMarker.hide();
    this.discardButton.show();
    this.jq.show();
  }

  renderInDeck() {
    this.jq.hide();
  }

  renderDiscarded() {
    this.cardObject.addClass('card-inverse card-warning');
    this.discardedMarker.show();
    this.discardButton.hide();
    this.jq.show();
  }
}

$(".decks-play").ready(function() {
  console.log(this);
  let cards = [];
  $(".card").each((n, c) => { cards.push(new Card($(c).data("id"))); });

  window.deck = new Deck(cards, $("#deck").data("initial-hand-size"));

  $("#deal").click(_ => {
    deck.deal();
  })

  $("#draw").click(_ => {
    deck.draw();
  })
});
