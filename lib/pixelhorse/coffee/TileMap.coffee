class ph.TileMap
  constructor: (dataSrc, @loadedCallback, @tileSrc, @frameWidth, @frameHeight, @frameSpacingX = 0, @frameSpacingY = 0) ->
    
    @tiles = {}
    @sprites = {}
    
    if dataSrc
      ph.LoadManager.increaseLoadCount()
      jQuery.ajax(dataSrc, {
        dataType: "json",
        success: @initializeMap,
      })
    
  initializeMap: (@tiles) =>
    ph.LoadManager.increaseLoadedCount()
    @loadedCallback(this)
    return null
    
  getTileIndexesFromRect: (x, y, w, h) ->
    row = Math.floor(y*-1 / @frameHeight)
    col = Math.floor(x*-1 / @frameWidth)
    endRow = Math.ceil(row + h / @frameHeight + 1)
    endCol = Math.ceil(col + w / @frameWidth + 1)
    {startRow: row, startCol: col, endRow: endRow, endCol: endCol}
