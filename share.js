// Used by rspec-rails-examples for providing how to on
// proxying of 3rd party JS dependencies. This file is
// the 3rd party dependency.

(function(w, undefined) {

  var scriptElement = document.querySelector("script.social-widget");
  var buttonHtml = "<button>Share this</button>"
  scriptElement.insertAdjacentHTML('afterend', buttonHtml);

})(window);