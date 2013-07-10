$(document).ready(function() {
    $('#new_tweet-form').on('submit', function(e){
    e.preventDefault();
    $.post('/new_tweet', $(this).serialize()).done(function(response){
      $('#new_tweets').html(response)
    });
  });
});
