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
    this.alwaysDraw = this.cardObject.data("always-draw");

    this.discardButton.click(_ => {
      deck.discard(this);
    });
    this.restoreButton.click(_ => {
      deck.restore(this);
    })

    this.description.slideUp(0);
    this.cardObject.hover(_ => {
      this.description.slideDown();
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
};
