class CardPresenter < Presenter
  presenter_for :card

  def footer_classes
    ['text-center', ('card-success' if display_readied?)]
  end

  def classes
    [("ephemeral" if card.new_record?)]
  end

  def display_readied?
    [card.readied?, card.readyable?].all?
  end

  def readied_status
    card.readied? ? "Readied" : "Not readied"
  end

  def rendered_id
    card.try(:id) || "tmp"
  end

  def name_placeholder
    (card && card.new_record?) ? "New card" : "Name"
  end

  def data
    {"always-draw" => card.always_draw.to_s}
  end
end
