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
    this.reshuffle();
    for (var i = 0; i < this.initialHandSize; i++) {
      this.draw();
    }

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

  restore(card) {
    let cardIndex = this.discardPile.indexOf(card);
    this.hand = this.hand.concat(this.discardPile.splice(cardIndex, 1));

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
    this.restoreButton = this.jq.find(".restore");
    this.discardButton = this.jq.find(".discard");
    this.description = this.jq.find(".card-text");

    this.discardButton.click(_ => {
      deck.discard(this);
    });
    this.restoreButton.click(_ => {
      deck.restore(this);
    })

    this.description.slideUp(0);
    this.jq.find(".card-title").hover(_ => {
      this.description.slideDown();
    }, _ => {
      this.description.slideUp();
    });
  }

  renderInHand() {
    this.cardObject.removeClass('card-inverse card-dark');
    this.restoreButton.hide();
    this.discardButton.show();
    this.jq.show();
  }

  renderInDeck() {
    this.jq.hide();
  }

  renderDiscarded() {
    this.cardObject.addClass('card-inverse card-dark');
    this.restoreButton.show();
    this.discardButton.hide();
    this.jq.show();
  }
}

$(".decks-play").ready(function() {
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
