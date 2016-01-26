$ ->
  $home_graphic = $('#home_graphic')
  $home_graphic_contents = $home_graphic.find('> div')
  $bottom_left = $home_graphic.find('.bottom-left')
  $bottom_right = $home_graphic.find('.bottom-right')
  if $home_graphic.length > 0
    $(window).on 'load resize', ->
      width = $home_graphic.width()
      border_width = width / 100
      $home_graphic_contents.css('border-width', border_width + "px")
      $bottom_left.css('width', width * 0.573)
      $bottom_right.css('width', width * 0.4095)