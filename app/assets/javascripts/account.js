$(document).ready(function(){
  console.log('jq loaded')

  $('span.show-subscribe').click(function(){

    console.log('click')
    var story_id = $(this).attr('id')
    var selector = $('.toggable').filter('#'+ story_id)
    console.log(selector)
    selector.slideToggle();
  })

  $('span#show-all-stories').bind('click', function(){
    $('div.no-chapters').fadeIn();
  })

  $('.privs').on('change', function(){

    user_id = $(this).attr('user')
    story_id = $(this).attr('story')

    if ($(this).is(':checked')){
      promote(user_id, story_id);
    }
    else{
      console.log('reledgage user')
      relegate(user_id, story_id);;
    }
  })

function promote(){

  var jqxhr = $.ajax({
    type: "POST",
    url: '/manage/subscribers/promote',
    dataType: 'JSON',
    data: {
        user_id: user_id,
        story_id: story_id,
        priviledged: true,
        action: 'promote'
      }
    })
    .success(function(response){
      messageBox.set("User has been promoted.")
    })
    .error(function(response){
      console.log(response)
      alert('An error occured')
    })
}

function relegate(){

  var jqxhr = $.ajax({
    type: "POST",
    url: '/manage/subscribers/relegate',
    dataType: 'JSON',
    data: {
        user_id: user_id,
        story_id: story_id,
        priviledged: false,
        action: 'promote'
      }
    })
    .success(function(response){
      console.log(response)
      messageBox.set("User has been relegated.")
    })
    .error(function(response){
      console.log(response)
      alert('An error occured')
    })
}
})
