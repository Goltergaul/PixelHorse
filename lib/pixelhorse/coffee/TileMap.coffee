class ph.TileMap
  constructor: (dataSrc, @loadedCallback, @tileSrc, @frameWidth, @frameHeight, @frameSpacingX = 0, @frameSpacingY = 0) ->
    ph.LoadManager.increaseLoadCount()
    jQuery.ajax(dataSrc, {
      dataType: "json",
      success: @initializeMap,
    })
    
  initializeMap: (@tiles) =>
    ph.LoadManager.increaseLoadedCount()
    @loadedCallback(this)
    return null