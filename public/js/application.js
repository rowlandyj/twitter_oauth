$(document).ready(function() {
    $('#new_tweet-form').on('submit', function(e){
    e.preventDefault();
    $.post('/new_tweet', $(this).serialize()).done(function(response){
      console.log(response);
      
      var id = setInterval(function(){

        $.get('/status/'+response).done(function(status){
          console.log(status);
          if (status === "success" ) {
            $('#new_tweets').html(status);
            clearInterval(id);
          }
        });

      },3000);
    
    });
  });
});
