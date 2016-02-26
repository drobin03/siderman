$ ->
  $home_graphic = $('#home_graphic')
  $home_graphic_contents = $home_graphic.find('> div')
  $bottom_left = $home_graphic.find('.bottom-left')
  $bottom_right = $home_graphic.find('.bottom-right')
  $superhero_graphic = $('#superhero-graphic')
  if $home_graphic.length > 0
    $(window).on 'load resize', ->
      width = $home_graphic.width()
      border_width = width / 100
      $home_graphic_contents.css('border-width', border_width + "px")
      $bottom_left.css('width', width * 0.573)
      $bottom_right.css('width', width * 0.4095)

      fill_height = 0; $superhero_graphic.find('img').each -> fill_height += ($(this).height() + (parseInt($(this).css('top')) || 0))
      fill_height = $superhero_graphic.height() - fill_height
      fill_offset_top = $superhero_graphic.find('.top').height() + parseInt($superhero_graphic.find('.top').css('top'))
      $superhero_graphic.find('.middle').css({ 'height': fill_height, 'top': fill_offset_top })