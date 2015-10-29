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
    var error = $('.error_new_task');
    error.empty();

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
      showDetails(new_task.find('.show_details'));
      renderEditForm(new_task.find('.edit_task'));
    }).fail(function(jqXHR){
      error.prepend(jqXHR.responseText);
    });
  });

// POST BUDGET ON THE SAME PAGE
  $('#new_budget').submit(function(event){
    event.preventDefault();
    var error = $('.error_new_budget');
    error.empty();
    var formUrl = $(this).attr('action');
    var postData = $(this).serializeArray();

    $.ajax({
      url: formUrl,
      method: "POST",
      data: postData,
    }).done(function(data) {
      var new_budget = $(data);
      $('.budget').prepend(new_budget);
      editAmount(new_budget.find('.edit_budget'));
      var quantityOfdays = parseInt(new_budget.find('td.price').length);
      var new_total_amount = new_budget.find('.edit_budget input[name="budget[total]"]').val() * quantityOfdays
      $('.total_amount').text(new_total_amount)
      // installResetBudget(new_budget.find('.deleteBudget'))
      installDelete(new_budget.find('.delete'));
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

  installDelete($('.delete'));
  weather();
  showDetails($('.show_details'));
  renderEditForm($('.edit_task'));
  addActivityToTasks($('.add'));
  editAmount($('.edit_budget'));
  newWardrobe($('.new_wardrobe'));
  installDeleteWardrobeItems($('.delete_wardrobe_item'));
  installResetBudget($('.deleteBudget'));
});

function removeDetails(element) {
  element.click(function(){
  event.preventDefault();
  element.parents('.details').hide();
  $('#new_task_field').show();
  $('.error_edit_task').empty();
  // element.parents('.details').hide( 400 );
  });
}

function installDelete(element) {
  element.click(function(){
  event.preventDefault();

  var button = $(this);
  var url = $(this).children('a').attr('href');
    $.ajax({
      url: url,
      method: "DELETE"
    }).done(function(data) {
      var total_budget = data.total_budget
      $('.total_amount').text(total_budget)
      button.parent().parent().hide( 400 );
      var editForm = $('.edit_task_form');
      var details = $('.task_details');
      var edit_error = $('.error_edit_task');
      details.empty();
      editForm.empty();
      edit_error.empty();
      $('#new_task_field').show();
    });
  });
}

// SHOW TASK DETAILS ON THE SAME PAGE
function showDetails(element) {
  element.click(function(){
  event.preventDefault();
  var details = $('.task_details');
  details.empty();

  var url = $(this).children('a').attr('href');

    $.ajax({
      url: url,
      method: "GET"
    }).done(function(data) {
      var details = $(data);
      $('.task_details').prepend(details);
      removeDetails(details.find('.remove'));
    }).fail(function(jqXHR){
      error.prepend(jqXHR.responseText);
    });
  });
}

function renderEditForm(element) {
  element.click(function(){
  event.preventDefault();
  var error = $('.error_edit_task');
  error.empty();
  $('.error_new_task').empty();

  var editForm = $('.edit_task_form');
  editForm.empty();

  var url = $(this).children('a').attr('href');
    $.ajax({
      url: url,
      method: "GET"
    }).done(function(data) {
      var form = $(data);
      $('.edit_task_form').prepend(form);
      var form_id = $(form.find('.edit_task')[0]).attr('id');
      $('#new_task_field').hide();

      $('#' + form_id).submit(function(event){
      event.preventDefault();


      var formUrl = $(this).attr('action');
      var postData = $(this).serializeArray();

        $.ajax({
          url: formUrl,
          method: "PUT",
          data: postData,
        }).done(function(data) {
          var error = $('.error_edit_task');
          error.empty();
          var edit_task = $(data);
          var task_id = edit_task.attr('id');
          var old_task = $('.all_tasks').find('#' + task_id );
          old_task.hide();
          $('.all_tasks').prepend(edit_task);
          installDelete(edit_task.find('.delete'));
          showDetails(edit_task.find('.show_details'));
          renderEditForm(edit_task.find('.edit_task'));
          editForm.empty();
          $('#new_task_field').show();

        }).fail(function(jqXHR){
          error.empty();
          error.prepend(jqXHR.responseText);
        });
      });
      removeDetails(form.find('.remove'));

    }).fail(function(jqXHR){
      error.prepend(jqXHR.responseText);
    });
  });
}

function editAmount(element) {
  $(element).find('input[type=submit]').on('click', function(event) {
    event.preventDefault();
    var form = $(this).parents('form.edit_budget');
    var sum_id = form.parents('td').siblings('td.price')

    var formUrl = form.attr('action');
    var previousLink = formUrl.split("/");
    previousLink.pop();
    previousLink.push($(sum_id).text());
    var newUrl = previousLink.join("/");
    var postData = form.serializeArray();
    postData.push({name: 'commit', value: $(this).val()})

    $.ajax({
      url: newUrl,
      method: "PUT",
      data: postData,
    }).done(function(data) {
      var edit_amount = data.amount;
      var new_total_amount = data.total_amount;

      $('.total_amount').text(new_total_amount);
      $(sum_id).replaceWith($('<td class="price">' + edit_amount + '</td>'));

    }).fail(function(jqXHR){
      error.empty();
      error.prepend(jqXHR.responseText);
    });
  });
};

function installResetBudget(element) {
  element.click(function(){
  event.preventDefault();

  var button = $(this);
  var url = $(this).children('a').attr('href');
    $.ajax({
      url: url,
      method: "DELETE"
    }).done(function(data) {
      button.parents('tr').siblings().hide();
      console.log(data)
      $('.total_amount').text(data)
    });
  });
}

// NEW WARDROBE ITEM POST
function newWardrobe(element) {
  element.submit(function(){
    event.preventDefault();
    var error = $('.error_new_wardrobe');
    error.empty();

    var form_id = $(this).parents('tr').attr('id');
    var day = $(this).parents('td').siblings('td.wardrobe_day')
    var formUrl = $(this).attr('action');
    var postData = $(this).serializeArray();

    $.ajax({
      url: formUrl,
      method: "POST",
      data: postData,
    }).done(function(data) {
      var new_wardrobe= $(data);
      $('#' + form_id).append(new_wardrobe);
      installDeleteWardrobeItems(new_wardrobe.find('.delete_wardrobe_item'))

    }).fail(function(jqXHR){
      error.empty();
      error.prepend(jqXHR.responseText);
    });
  });
  };

  // Delete Wardrobe
  function installDeleteWardrobeItems(element) {
    element.click(function(){
      event.preventDefault();

      var button = $(this);
      var url = $(this).children('a').attr('href');
        $.ajax({
          url: url,
          method: "DELETE"
        }).done(function() {
          button.parent().hide( 400 );
        });
      });
  }

// POST NEW TASK FROM THINGS ON THE SAME PAGE
function addActivityToTasks(element) {
  element.click(function(event){
    event.preventDefault();
    var this_element = $(this);
    var price = (this_element.parents('tr').children('.price').text());

    var url = $(this).children('a').attr('href');
    $.ajax({
      url: url,
      method: "POST",
    }).done(function(data) {
      var new_task = $(data);
      var activity_id = this_element.parents('tr').attr('id');
      var activity = $('.popular_things_todo').find('#' + activity_id );
      this_element.toggleClass('added')
      // activity.hide(600);
      $('.all_tasks').prepend(new_task);

      var budget = $("#money").attr('data-val');
      var setNewBudget = $('#money').attr('data-val', parseInt(price) + parseInt(budget));
      budget = setNewBudget;
      $('#money').text($("#money").attr('data-val'));
      installDelete(new_task.find('.delete'));
      showDetails(new_task.find('.show_details'));
      renderEditForm(new_task.find('.edit_task'));

    }).fail(function(jqXHR){
      console.log("error")
      // error.prepend(jqXHR.responseText);
    });
  });
}

function weather() {
  $.simpleWeather({
    woeid: '2357536', //2357536
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
