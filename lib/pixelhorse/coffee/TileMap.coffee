class ph.TileMap
  constructor: (dataSrc, @callback, @tileSrc, @frameWidth, @frameHeight, @frameSpacingX = 0, @frameSpacingY = 0) ->
    jQuery.ajax(dataSrc, {
      dataType: "json",
      success: @initializeMap,
    })
    
  initializeMap: (data) =>
    @tiles = data
    @sprites = {}
    for row in @tiles
      for cell in row
        spritename = cell.image.sprite
        tileSrc = @getSpriteName(spritename)
        if !@sprites[spritename]
          try 
            sprite = ph.AssetManager.getAsset(tileSrc)
          catch e
            sprite = new ph.SpriteCanvas(tileSrc, @frameWidth, @frameHeight, @frameSpacingX, @frameSpacingY);
            ph.AssetManager.addAsset(sprite, tileSrc)
          finally
            @sprites[spritename] = sprite
        
    @callback()
    return null
    
  getSpriteName: (name) ->
    "#{@tileSrc}/#{name}.bmp"
