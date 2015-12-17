$(document).ready(function(){

  $('input#complete-story').click(function(){

    if( $(this).is(':checked') ) {
      $('#action-fields').fadeOut('fast')
    }

    else {
      $('#action-fields').fadeIn('fast')
    }
  })

  $('table.sortable').tablesorter();
  
});
