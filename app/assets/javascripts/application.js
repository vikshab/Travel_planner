// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require jquery
//= require bootstrap-sprockets
//= require bootstrap-datepicker
//
$(document).ready(function() {

// DISABLED BUTTON
  if($('#text_field').val() ==  "")
    $('#submitButtonId').attr('disabled', true);

    $('#text_field').keyup(function(){
      if($('#text_field').val() !=  "")
         $('#submitButtonId').attr('disabled', false);
      else
     $('#submitButtonId').attr('disabled', true);
   });

// POST NEW TRIP ON THE SAME PAGE
  $('#new_trip').submit(function(event){
  event.preventDefault();
  var error = $('.error_new_trip');
  error.empty();

  var formUrl = $(this).attr('action');
  var postData = $(this).serializeArray();

    $.ajax({
      url: formUrl,
      method: "POST",
      data: postData,
    }).done(function(data) {
      // console.log(data)
      var new_trip = $(data);
      $('.all_trips').prepend(new_trip);
      installDelete(new_trip.find('.delete'));
    }).fail(function(jqXHR){
      error.prepend(jqXHR.responseText);

    });

  });

  // POST NEW TASK ON THE SAME PAGE
    $('#new_task').submit(function(event){
    event.preventDefault();
    // var error = $('.error_new_trip');
    // error.empty();

    var formUrl = $(this).attr('action');
    var postData = $(this).serializeArray();

      $.ajax({
        url: formUrl,
        method: "POST",
        data: postData,
      }).done(function(data) {
        var new_task = $(data);
        $('.all_tasks').prepend(new_task);
        installDelete(new_task.find('.delete'));
      }).fail(function(jqXHR){
        error.prepend(jqXHR.responseText);

      });

    });



// SCROLLING
var $window   = $(window),
    height    = $window.height(),
    width     = $window.width(),
    navheight = $('#nav_wrap').height();

  function sticky(){
    var scrollTop = $window.scrollTop();
    if (scrollTop > (height - navheight)) {
      $('#nav_wrap').addClass('sticky');
      $('nav').addClass('nav_animate');
      setTimeout(function(){
        $('#user_name').css({
          'left': 3 + '%',
          'transition':'.5s'
        });
        $('#logo').css({
          'left': 3 + '%',
          'transition':'.5s'
        });
        $('#social').css({
          'right': 5 + '%',
          'transition':'.5s'
        });
      }, 200);

    } else {
      $('#nav_wrap').removeClass('sticky');
      $('nav').removeClass('nav_animate');
      setTimeout(function(){
        $('#user_name').css({
          'left':-150,
          'transition':'.5s'
        });
        $('#logo').css({
          'left':-150,
          'transition':'.5s'
        });
        $('#social').css({
          'right':-150,
          'transition':'.5s'
        });
      }, 200);
    }
  }

  $window.on('scroll', sticky);

//Navigational Menu
  $('nav a').click(function(a){
    var menuPlace = $(this).index();
    a.preventDefault();
    $('html, body').animate({
      scrollTop : $('section').eq(menuPlace).offset().top - $('nav').height()
    }, 700);
  });

  // remove();
  installDelete($('.delete'));
  weather();
  // disableButtonIfFieldsAreEmpty();
  // addNewTrip();
  // hideAllTrips();
  // showAllTrips();
  // addNewTask();
  // hideCalendar();
  // installShowTasks();
  // createTask();
});

// function remove() {
//   $('.remove').click(function(){
//   event.preventDefault();
//   var button = $(this);
//   $(this).parent().parent().hide( 400 );
// });
// }

function hideAllTrips() {
  $('.hide_all_trips').click(function(){
  event.preventDefault();
  $(this).siblings('#trips_table').hide(400);
  $(this).hide(400);
  })
}

function showAllTrips() {
  $('.show_all_trips').click(function(){
    $(this).siblings().show(400);
  })
}

// function disableButtonIfFieldsAreEmpty() {
  // if($('#text_field').val() ==  "")
  //   $('#submitButtonId').attr('disabled', true);
  //
  //   $('#text_field').keyup(function(){
  //     if($('#text_field').val() !=  "")
  //        $('#submitButtonId').attr('disabled', false);
  // else
  //    $('#submitButtonId').attr('disabled', true);
  //  });
// }

function installDelete(element) {
  element.click(function(){
  event.preventDefault();

  var button = $(this);
  var url = $(this).children('a').attr('href');
    $.ajax({
      url: url,
      method: "DELETE"
    }).done(function() {
      button.parent().parent().hide( 400 );
      // remove();
    });
  });
}

function weather() {
  $.simpleWeather({
    // woeid: '2357536', //2357536
    location: $('.destination_input').text(),
    unit: 'f',
    success: function(weather) {
      var icon = $('<h1 class="icon-'+weather.code+'"></h1>');
      var degree = $('<p class="temp">'+weather.temp+'&deg;</p>');
      var city = $('<p>'+weather.city+' '+weather.region+'</p>');
      var currently =  $('<p class="currently">'+weather.currently+'</p>');
      var result = $(".weather").append(icon, degree, currently);
    },
    error: function(error) {
      $(".weather").html('<p>'+error+'</p>');
    }
  });
}
