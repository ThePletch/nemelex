window.Nemelex = window.Nemelex || {};

Nemelex.isInScope = function(controller, index) {
  return $("body." + controller + "." + index).length == 1;
};
