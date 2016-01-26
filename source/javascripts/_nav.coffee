$ ->
  $navbar = $('.navbar-fixed-top');
  $(window).on 'scroll', ->
    if $(window).scrollTop() > 150
      $navbar.addClass('small')
    else
      $navbar.removeClass('small')
