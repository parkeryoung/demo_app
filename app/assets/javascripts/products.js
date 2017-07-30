$(document).ready(function(){
  $(document).on('turbolinks:load', function() {
    $endDate = $("#product_end_date");
    $endDate.datepicker();

    $("#show_discontinued").on("change", function(e){
      $.ajax('/products/partial_index', {
        data: {
          show_discontinued: $(e.target).is(':checked')
        },
        success: function(data) {
          $(".products").html(data);
        }
      })
    });
  });
});
