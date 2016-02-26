navbar_height = 50
getUrlParameter = (sParam) ->
  sPageURL = decodeURIComponent(window.location.search.substring(1))
  sURLVariables = sPageURL.split('&')
  for urlVar in sURLVariables
    sParameterName = urlVar.split('=')
    if (sParameterName[0] == sParam)
      return true

$ ->
  $navbar = $('.navbar-fixed-top');
  $(window).on 'scroll', ->
    if $(window).scrollTop() > 150
      $navbar.addClass('small')
    else
      $navbar.removeClass('small')

  # Smooth scroll
  $('a[href*=#]:not([href=#])').click ->
    if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname)
      target = $(this.hash)
      target = if target.length then target else $('[name=' + this.hash.slice(1) +']')
      if (target.length)
        $('html,body').animate({
          scrollTop: target.offset().top - navbar_height
        }, 1000)
        false

  # Contact Form Message
  show_message = getUrlParameter('show_message')
  if(show_message)
    message = $('.email-message')
    message.removeClass('hidden')
    history.pushState("", document.title, window.location.pathname) # Remove query params
    window.setTimeout ->
      message.addClass('hidden')
    , 3000