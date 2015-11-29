$(document).ready(function(){
  $('span.show-subscribe').click(function(){
    $(this).closest('.row').next('.toggable').slideToggle();
  })
})
