class ph.Images extends ph.Loadable

  @load: (@src, callback) ->
    image = new window.Image()
    ph.Loadable.increaseLoadCount()
    image.onload = () ->
      ph.Loadable.increaseLoadedCount()
    image.src = @src
    return image
