class Presenter
  def self.presenter_for(target_class_name)
    class_eval do
      attr_reader target_class_name.to_sym, :options
    end
  end

  # todo make incorrect-naming error more useful here
  def self.target_class
    @target_class ||= /(\w+)Presenter/.match(self.to_s)[1].downcase
  end

  def initialize(target, options = {})
    instance_variable_set("@#{self.class.target_class}", target)
    @options = options
  end
end
