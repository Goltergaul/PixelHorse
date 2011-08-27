class ph.Images

  @load: (src, callback) ->
    image = new window.Image()
    ph.LoadManager.increaseLoadCount()
    image.onload = () ->
      if callback
        callback(image)
      ph.LoadManager.increaseLoadedCount()
    image.src = src
    return image
