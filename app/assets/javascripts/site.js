$(document).ready(function(){
  nav_loc =  $('nav').offset().top

  $(window).scroll(function () {
      if ( nav_loc - $(window).scrollTop() < 0 ){
        $('nav').addClass('top-bar-fixed')
      }

      else {
        $('nav').removeClass('top-bar-fixed')
      }
  });

})

// $(window).scroll(function(){
//   if  ($(window).scrollTop() == $(document).height() - $(window).height()){
//         //console.log($('nav').offset() )
//   }
// });
