parseThumbnailElements = ($gallery) ->
  items = $gallery.find('> a').map ->
    size = $(this).attr('data-size').split('x')
    {
      src: $(this).attr('href'),
      w: parseInt(size[0], 10),
      h: parseInt(size[1], 10),
      msrc: $(this).find('img').attr('src'),
      $el: $(this) # save link to element for getThumbBoundsFn
    }

# triggers when user clicks on thumbnail
onThumbnailsClick = (e) ->
  e.preventDefault()

  # find root element of slide

  $clickedGallery = $(this).parent()
  index = parseInt($(this).attr('data-index'))

  if index >= 0
    # open PhotoSwipe if valid index found
    openPhotoSwipe( index, $clickedGallery )

# parse picture index and gallery index from URL (#&pid=1&gid=2)
photoswipeParseHash = ->
  hash = window.location.hash.substring(1)
  params = {}

  return params if (hash.length < 5)

  url_vars = hash.split('&')
  for url_var in url_vars
    continue if (!url_var)
    pair = url_var.split('=')
    continue if (pair.length < 2)
    params[pair[0]] = pair[1]

  params.gid = parseInt(params.gid, 10) if (params.gid)

  return params

openPhotoSwipe = (index, $galleryElement, disableAnimation, fromURL) ->
  pswpElement = $('.pswp')[0]

  items = parseThumbnailElements($galleryElement)

  # define options (if needed)
  options = {
    # define gallery index (for URL)
    showHideOpacity: true,
    shareEl: false,
    galleryUID: $galleryElement.attr('data-pswp-uid'),
    getThumbBoundsFn: (index) ->
      # See Options -> getThumbBoundsFn section of documentation for more info
      thumbnail = items[index].$el.find('img')[0] # find thumbnail
      pageYScroll = window.pageYOffset || document.documentElement.scrollTop
      rect = thumbnail.getBoundingClientRect()

      return {x:rect.left, y:rect.top + pageYScroll, w:rect.width}
  }

  # PhotoSwipe opened from URL
  if (fromURL)
    if (options.galleryPIDs)
        # parse real index when custom PIDs are used
        # http://photoswipe.com/documentation/faq.html#custom-pid-in-url
        for item,i in items
          if item.pid == index
            options.index = i
            break
    else
      # in URL indexes start from 1
      options.index = parseInt(index, 10) - 1
  else
    options.index = parseInt(index, 10)

  # exit if index not found
  return if options.index == undefined

  options.showAnimationDuration = 0 if(disableAnimation)

  # Pass data to PhotoSwipe and initialize it
  gallery = new PhotoSwipe( pswpElement, PhotoSwipeUI_Default, items, options);
  gallery.init()


$ ->
  $('.image-gallery').each (i) ->
    # loop through all gallery elements and bind events
    $(this).attr('data-pswp-uid', i+1)
    $(this).find('> a').click(onThumbnailsClick)

  # Parse URL and open gallery if it contains #&pid=3&gid=1
  hashData = photoswipeParseHash()
  if hashData.pid && hashData.gid
    openPhotoSwipe( hashData.pid ,  $('.image-gallery[data-pswp-uid=' + hashData.gid.toString() + ']'), true, true )

  $grid = $('.image-gallery')
  $grid.packery({
    itemSelector: 'a',
    gutter: 10
  });
  $grid.imagesLoaded().progress ->
    $grid.packery()