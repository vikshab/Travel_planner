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
/*
A quick mock-up I made after seeing the nav bar at this site: http://snipcart.com/
*/

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
