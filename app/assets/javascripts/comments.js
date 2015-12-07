$(document).ready(function(){
  if ( document.getElementById('comment-box') ){

    refresh()

    $('#submit-comment').on('click', function(){
      console.log($('#submit-comment'))
      addComment()
    })

    function refresh(){
      getComments(chapterId())
    }

    function reset(){
      $('#content').val("")
    }

    function chapterId(){
      var chapterId = $('#comment-box').attr('chapter-id')
      return chapterId
    }

    function addComment(){
      console.log('posting to comment: ' + $('#content').val())
      var jqxhr = $.ajax({
        type: "POST",
        url: '/comments/',
        dataType: 'JSON',
        data: {
            chapter_id: chapterId(),
            content: $('#content').val()
          }
        })
        .success(function(response){
          messageBox.set("comment has been submitted.")
          refresh()
          reset()
        })
        .error(function(response){
          console.log(response)
          alert('An error occured')
        })
    }
    }

    function getComments(chapter_id){

      var jqxhr = $.ajax({
        type: "GET",
        url: '/comments/'+ chapter_id,
        dataType: 'JSON'
        })
        .success(function(response){
          to_html(response)
        })
        .error(function(response){
          console.log(response)
          alert('An error occured')
        })
    }

    function to_html(feed){
      //console.log(feed)
      container = $('div.current-comments')
      container.html("")

      for (c in feed){
        comment = {
          content: feed[c].content,
          ts_date: feed[c].date,
          ts_time: feed[c].time,
          user: feed[c].user.name
          }

          html = '<p class="comment-text">' + comment.content + '</p><p class="comment-by">by ' + comment.user + ' on ' + comment.ts_date + ' at ' + comment.ts_time + '</p>'
          container.append(html)

      }
    }
})
