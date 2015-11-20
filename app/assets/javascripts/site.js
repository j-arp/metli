$(document).ready(function(){
  nav_loc =  $('nav').offset().top

  $(window).scroll(function () {
      console.log(Math.round(nav_loc))
      console.log(Math.round(nav_loc))
      console.log($(window).scrollTop())
      console.log(Math.round($(window).scrollTop()))
      //console.log(nav_loc - $(window).scrollTop());

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
