$(document).ready(function(){

  $('span.show-subscribe').click(function(){
    //console.log('click')
    //console.log($(this).closest('.row'))
    //console.log($(this).closest('.row').next('.toggable'))
    $(this).closest('.row').next('.toggable').slideToggle();
  })

})
