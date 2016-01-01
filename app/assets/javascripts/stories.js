$(document).ready(function(){

  if ( document.getElementById('active-story-list') ){
    console.log($('div#active-story-list div.story-list-item:lt(3)'));
    $('div#active-story-list div.story-list-item:lt(3)').show().removeClass('story-not-shown').addClass('story-shown')

    if ( $('div#active-story-list div.story-not-shown').size() > 0 ) {
        $('div#active-story-list').find('button').fadeIn()
      }

  }



  if ( document.getElementById('completed-story-list') ){
    $('div#completed-story-list div.story-list-item:lt(3)').show().removeClass('story-not-shown').addClass('story-shown')

    if ( $('div#completed-story-list div.story-not-shown').size() > 0 ) {
      $('div#completed-story-list').find('button').fadeIn()
    }

  }



  $('button.show-more').bind('click', function(){
    var button = $(this)
    var target = $(this).attr('target')
    var container =

    $('div#'+target +  ' div.story-not-shown:lt(3)').fadeIn('slow').addClass('story-shown').removeClass('story-not-shown')

    var number_remaining = $('div#'+target+  ' div.story-not-shown').size()
    console.log(number_remaining);

    if ( number_remaining == 0)  {
      //button.fadeOut()
    }
  })


})
