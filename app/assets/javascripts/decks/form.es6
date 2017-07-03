$(document).on("turbolinks:load", function() {
  if (!(Nemelex.isInScope("decks", "edit") || Nemelex.isInScope("decks", "new"))) { return; }

  const deckForm = new DeckForm();

  $("#uses_deck,#readyable").change(deckForm.updateDeckInfo.bind(deckForm));
  deckForm.updateDeckInfo();

  $('[data-form-prepend]').click(function(e) {
    const obj = $($(this).attr('data-form-prepend'));
    obj.find('input, select, textarea').each(function() {
      $(this).attr('name', function() {
        return $(this).attr('name').replace('new_record', (new Date()).getTime());
      });
    });

    deckForm.cardsList.append(obj);
    deckForm.cardObjects.push(new CardForm(obj));
    deckForm.updateDeckInfo();
  });
});
