$( document ).ready(function() {
  $('#profile_image').on('change', function(evt){
    var files = evt.target.files
    $.each(files, function(index, file){
      var reader = new FileReader();
      reader.onload = (function(theFile) {
        return function(e) {
          // Render thumbnail.
          $('#profile_image').append('<div class="image"></div>');
          $("#image").html('<img class="thumb" src="' + e.target.result +'" title="' + file.name +'" height="100" width="100"/>');
          $("#image img").css("margin", "0");
        };
      })(file);
      reader.readAsDataURL(file);
    })
  })
});