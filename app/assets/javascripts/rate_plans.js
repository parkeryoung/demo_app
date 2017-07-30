$(document).ready(function(){
  $(document).on('turbolinks:load', function() {
    $dates = $("#rate_plan_end_date, #rate_plan_start_date");
    $dates.datepicker();
  });
});
