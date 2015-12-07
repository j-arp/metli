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
          //refresh()
          to_html(response, "new")
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
          feed_to_html(response)
        })
        .error(function(response){
          console.log(response)
          alert('An error occured')
        })
    }

    function feed_to_html(feed){
      container = $('div.current-comments')
      container.html("")

      for (c in feed){
        comment = {
          content: feed[c].content,
          ts_date: feed[c].date,
          ts_time: feed[c].time,
          user: feed[c].user.name
          }

          to_html(comment, "old")
        }

    }

    function to_html(comment, status){
      console.log(comment)
        container = $('div.current-comments')
        html = '<p class="comment-text">' + comment.content + '</p><p class="comment-by">by ' + comment.user + ' on ' + comment.ts_date + ' at ' + comment.ts_time + '</p>'
        if ( status == "new") {
          full_html = '<span class="new-comment">" + html + "</span>'
        }

        else {
          full_html = html
        }

        container.append(full_html)
    }
})
