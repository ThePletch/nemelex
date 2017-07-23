# autogenerates a presenter of the appropriate type
module Presentable
  extend ActiveSupport::Concern

  included do
    def presenter(options = {})
      "#{self.class}Presenter".constantize.new(self, options)
    end
  end
end
