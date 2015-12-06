$(document).ready(function(){
  $('#message-box #close-message-x').click(function(){
    messageBox.log("clear box")
    messageBox.clear()
  })

  if ( $('#message-box #message-text').text().trim().length ){
    $('#message-box').fadeIn();
  }

  messageBox = {
    set: function(msg, format){
      if ( format == 'undefined'){
          format = 'normal';
        }

      this.log("set message")
      $('#message-box #message-text').text(msg);
      $('#message-box').fadeIn();
      },

    clear: function(){
      $('#message-box').fadeOut();
      $('#message-box #message-text').text("");
      },

    log: function(m){
      console.log(m);
      }
  }

});
