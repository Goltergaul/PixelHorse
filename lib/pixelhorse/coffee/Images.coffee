class ph.Images

  @load: (@src, callback) ->
    image = new window.Image()
    ph.LoadManager.increaseLoadCount()
    image.onload = () ->
      ph.LoadManager.increaseLoadedCount()
    image.src = @src
    return image
