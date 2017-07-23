class Presenter
  def self.presenter_for(target_class_name)
    @@target_class_name = target_class_name

    class_eval do
      attr_reader target_class_name.to_sym, :options
    end
  end

  def initialize(target, options = {})
    instance_variable_set("@#{@@target_class_name}", target)
    @options = options
  end
end
