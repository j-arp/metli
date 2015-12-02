$(document).ready(function(){
  console.log('jq loaded')
  $('span.show-subscribe').click(function(){

    console.log('click')
    var story_id = $(this).attr('id')
    var selector = $('.toggable').filter('#'+ story_id)
    console.log(selector)
    selector.slideToggle();
  })
})
