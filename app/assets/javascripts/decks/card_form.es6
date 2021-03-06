class CardForm {
  constructor(htmlObject) {
    this.cardObject = $(htmlObject);
    this.ephemeral = this.cardObject.find(".card").hasClass("ephemeral");
    this.readiedCheckbox = this.cardObject.find(".card-readied-checkbox");
    this.alwaysDrawCheckbox = this.cardObject.find(".card-always-draw-checkbox");

    this.destroyButton = this.cardObject.find(".card-delete-checkbox");
    this.destroyButton.click(function(){
      if (this.ephemeral) {
        this.cardObject.remove();
      }
    }.bind(this));
    this.readiedCheckbox.change(this.update.bind(this));
  }

  // a card is readied if it is marked as readied or if readying is disabled for the deck
  isReadied() {
    return this.readiedCheckbox.is(':checked') || !this.readiedCheckbox.is(':visible');
  }

  // a card should be marked as 'readied' only if readied is toggleable and toggled on
  displayReadied() {
    return this.readiedCheckbox.is(':checked') && this.readiedCheckbox.is(':visible');
  }

  // only allowed to mark a card as 'always draw' if you can draw it
  // i.e. it is readied
  toggleReadyDependentFeatures() {
    this.alwaysDrawCheckbox.prop('disabled', !this.isReadied());
    this.cardObject.find(".card-footer").toggleClass('card-success', this.displayReadied());
  }

  update() {
    this.toggleReadyDependentFeatures();
  }
}
