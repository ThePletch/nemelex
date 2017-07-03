// todo refactor this into a form class, has grown in complexity
$(document).on("turbolinks:load", function() {
  if (!Nemelex.isInScope("decks", "play")) { return; }

  let cards = [];
  $(".card").each((n, c) => { cards.push(new Card($(c).data("id"))); });

  window.deck = new Deck(cards,
    $("#deck").data("initial-hand-size"),
    $("#deck").data("readyable"),
    $("#deck").data("uses-deck"));

  const updateDrawButton = function() {
    $("#draw").prop('disabled', !deck.isDrawable());
  }

  $("#cards").mouseleave(_ => {
    cards.forEach(function(c) {
      c.description.slideUp();
    });
  });

  $("#deal").click(_ => {
    deck.deal();
    updateDrawButton();
  });

  $("#draw").click(_ => {
    deck.draw();
    updateDrawButton();
  });

  deck.deal();
});
