//= require pickadate-3.5.5

(function($) {

  function optimizeDatePickingUi() {
    var dateInputs = $('input[type=date]');
    var hasDateInputs = (dateInputs.length > 0);
    if (!hasDateInputs) {
      return;
    }
    var supportsNativeDateInput = (dateInputs[0].type == "date");
    if (!supportsNativeDateInput) {
      $("input[type=date]").pickadate();
    }
  }

  $(document).ready(optimizeDatePickingUi);
})(jQuery);
