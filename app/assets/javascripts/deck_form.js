class DeckForm {
  constructor() {
    this.handSizeField = $("#deck_initial_hand_size");
    this.handTooltip = $("#no-deck-tooltip");
    this.usesDeckCheckbox = $("#uses_deck");
    this.readyableCheckbox = $("#readyable");
    this.cardsList = $("#cards-list");
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

  toggleReadyableCheckboxes() {
    const isReadyable = this.readyableCheckbox.is(':checked');
    if (isReadyable) {
      $(".readyable-toggle").show();
    } else {
      $(".readyable-toggle").hide();
    }
  }

  updateDeckInfo() {
    this.toggleHandSizeField();
    this.toggleReadyableCheckboxes();
  }
}

$(".decks-new,.decks-edit").ready(function() {
  const deckForm = new DeckForm();

  $("#uses_deck").change(deckForm.toggleHandSizeField.bind(deckForm));
  $("#readyable").change(deckForm.toggleReadyableCheckboxes.bind(deckForm));
  deckForm.updateDeckInfo();

  $('[data-form-prepend]').click(function(e) {
    const obj = $($(this).attr('data-form-prepend'));
    obj.find('input, select, textarea').each(function() {
      $(this).attr('name', function() {
        return $(this).attr('name').replace('new_record', (new Date()).getTime());
      });
    });
    deckForm.cardsList.append(obj);
  });
});
