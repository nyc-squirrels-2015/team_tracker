var errorMod = (function(){

  var errorDiv = '.error'

  var showError = function(message){
    $(errorDiv).html("<p>" + message + "<p>")
    $(errorDiv).toggle(true)
  }

  var hideError = function(){
    $(errorDiv).toggle(false)
  }

  return {
    show: showError,
    hide: hideError
  }
})();
