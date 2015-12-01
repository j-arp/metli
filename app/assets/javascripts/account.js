$(document).ready(function(){
  $('span.show-subscribe').click(function(){
    var story_id = $(this).attr('id')
    var selector = $('.toggable').filter('#'+ story_id)
    console.log('click')
    console.log(selector)
    selector.slideToggle();
  })
})
