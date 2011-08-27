class ph.TileMap
  constructor: (dataSrc, @loadedCallback, @tileSrc, @frameWidth, @frameHeight, @frameSpacingX = 0, @frameSpacingY = 0) ->
    ph.Loadable.increaseLoadCount()
    jQuery.ajax(dataSrc, {
      dataType: "json",
      success: @initializeMap,
    })
    
  initializeMap: (@tiles) =>
    ph.Loadable.increaseLoadedCount()
    @loadedCallback(this)
    return null