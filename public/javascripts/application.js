$(window).load(function (event) {
  
  $(".reply").click(function (event) {
    var li = $(this).closest("li");
    var form = $("> form", li);
    
    var enabled = (form.css("display") != "none");
    
    $(".comment form").hide();
    
    if (enabled) {
      form.hide();
    } else {
      form.show();
      $("> ol", li).show();
    }
    
    event.preventDefault();
  });
  
  $(".replies").click(function (event) {
    var li = $(this).closest("li");
    $("> ol", li).toggle();
    
    event.preventDefault();
  });
  
});
