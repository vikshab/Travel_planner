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
  remove();
  installDelete();
  weather();

});

function remove() {
  $('.delete').click(function(){
  event.preventDefault();
  var button = $(this);
  console.log(button);
  $(this).parent().parent().hide( 400 );
});
}
// function removeDeleted() {
//   $('.delete').click(function(){
//   event.preventDefault();
//   var button = $(this);
//   console.log(button);
//   $(this).parent().parent().hide( 400 );
// });
// }

function installDelete() {
  $('.delete').click(function(){
  event.preventDefault();

  var button = $(this);
  var url = $(this).children('a').attr('href');
    $.ajax({
      url: url,
      method: "DELETE"
    }).done(function() {
      remove();
    });
  });
}

function weather() {
  $.simpleWeather({
    // woeid: '2357536', //2357536
    location: $('.destination_input').text(),
    unit: 'f',
    success: function(weather) {
      // if(weather.temp > 75) {
      //   $('.weather').animate({background: '#F7AC57'});
      // } else {
      //
      //   $('#logo').animate({background: '#0091c2'});
      // }
      var icon = $('<h1 class="icon-'+weather.code+'"></h1>');
      var degree = $('<p class="temp">'+weather.temp+'&deg;</p>');
      // html += '<p>'+weather.city+' '+weather.region+'</p>';
      var currently =  $('<p class="currently">'+weather.currently+'</p>');
      // html += '<li>'+weather.tempAlt+'&deg;C</li></ul>';
      // var timestamp = moment(weather.updated);
      // html += '<p class="updated">Updated '+moment(timestamp).fromNow()+'</p>';

      var result = $(".weather").append(icon, degree, currently);
    },
    error: function(error) {
      $(".weather").html('<p>'+error+'</p>');
    }
  });
  return result
}
