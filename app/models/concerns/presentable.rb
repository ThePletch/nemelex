# autogenerates a presenter of the appropriate type
module Presentable
  extend ActiveSupport::Concern

  included do
    def presenter(options = {})
      @presentable_presenter ||= "#{self.class}Presenter".constantize.new(self, options)
    end
  end
end
