$ ->
  $animations = $('#banner, #services .siding, #services .aluminum')
  $animations.appear()
  $animations.on 'appear', ->
    offset = $(this).offset().top + Math.min(300, $(this).height()/2)
    if $(window).height() + $(window).scrollTop() > offset
      $(this).addClass('in-view')
  $.force_appear()

  # Center text in banner
  center_vertically = () ->
    $banner = $('#banner');
    $text = $('#banner .text');
    if $(window).width() > 768
      $text.css({marginTop: $banner.height()/2 - $text.height()/2 })
    else
      $text.css({marginTop:''}) # clear centering on mobile

  $('#banner').imagesLoaded ->
    center_vertically()
  $(window).on 'resize load', ->
    center_vertically()