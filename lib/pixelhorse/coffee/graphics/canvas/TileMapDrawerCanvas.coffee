class ph.TileMapDrawerCanvas extends ph.TileMapDrawer
  
  constructor: (@tilemap) ->
    super
    
    @sprites = {}
    for row in @tilemap.tiles
      for cell in row
        spritenames = [cell.image.sprite]
        
        # add Background Sprit if one is defined
        if cell.bgImage
          spritenames.push(cell.bgImage.sprite)
        for spritename in spritenames
          tileSrc = @getSpriteName(spritename)
          if !@sprites[spritename]
            try 
              sprite = ph.AssetManager.getAsset(tileSrc)
            catch e
              sprite = new ph.SpriteCanvas(tileSrc, @tilemap.frameWidth, @tilemap.frameHeight, @tilemap.frameSpacingX, @tilemap.frameSpacingY);
              ph.AssetManager.addAsset(sprite, tileSrc)
            finally
              sprite.setParent(this)
              @sprites[spritename] = sprite
      