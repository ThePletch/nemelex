class DeckForm {
  constructor() {
    this.handSizeField = $("#deck_initial_hand_size");
    this.handTooltip = $("#no-deck-tooltip");
    this.usesDeckCheckbox = $("#uses_deck");
    this.readyableCheckbox = $("#readyable");
    this.cardsList = $("#cards-list");
    this.cardObjects = this.cardsList.find(".card-wrapper").map(function(i, e){
      return new CardForm(e);
    }).toArray();
  }

  toggleHandSizeField() {
    const usesDeck = this.usesDeckCheckbox.is(':checked');
    this.handSizeField.prop('disabled', !usesDeck);
    if (usesDeck) {
      this.handTooltip.hide();
    } else {
      this.handTooltip.show();
    }
  }

  toggleReadiedCheckboxes() {
    const isReadyable = this.readyableCheckbox.is(':checked');
    if (isReadyable) {
      $(".readied-toggle").show();
    } else {
      $(".readied-toggle").hide();
    }
  }

  toggleAlwaysDrawCheckboxes() {
    const isUsingDeck = this.usesDeckCheckbox.is(':checked');
    if (isUsingDeck) {
      $(".always-draw-toggle").show();
    } else {
      $(".always-draw-toggle").hide();
    }
  }

  updateDeckInfo() {
    this.toggleHandSizeField();
    this.toggleReadiedCheckboxes();
    this.toggleAlwaysDrawCheckboxes();
    this.cardObjects.forEach(function(e) {
      e.update();
    });
  }
}
