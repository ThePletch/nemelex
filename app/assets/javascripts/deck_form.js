class DeckForm {
  constructor() {
    this.descriptionField = $('#deck-type-description');
    this.handSizeField = $("#deck_initial_hand_size");
    this.handTooltip = $("#no-deck-tooltip");
    this.deckTypeSelector = $("#deck_type");
    this.cardsList = $("#cards-list");
  }

  selectedDeckType() {
    return this.deckTypeSelector.find(':selected');
  }

  switchDeckTypeDescription() {
    this.descriptionField.html(this.selectedDeckType().attr('description'));
  }

  toggleHandSizeField() {
    const typeUsesDeck = this.selectedDeckType().attr('uses_deck') == "true"
    this.handSizeField.prop('disabled', !typeUsesDeck);
    if (typeUsesDeck) {
      this.handTooltip.hide();
    } else {
      this.handTooltip.show();
    }
  }

  toggleReadyableCheckboxes() {
    const typeIsReadyable = this.selectedDeckType().attr('readyable') == "true"
    if (typeIsReadyable) {
      $(".readyable-toggle").show();
    } else {
      $(".readyable-toggle").hide();
    }
  }

  updateDeckInfo() {
    this.switchDeckTypeDescription();
    this.toggleHandSizeField();
    this.toggleReadyableCheckboxes();
  }
}

$(".decks-new,.decks-edit").ready(function() {
  const deckForm = new DeckForm();

  $("#deck_type").change(deckForm.updateDeckInfo.bind(deckForm));
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
