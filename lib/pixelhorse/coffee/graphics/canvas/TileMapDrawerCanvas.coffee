class ph.TileMapDrawerCanvas extends ph.Drawable
  
  constructor: (@tilemap) ->
    super
    for spritename, sprite of @tilemap.sprites
      sprite.setParent(this)
    
  draw: (context) ->
    [x, y] = @getAbsolutePosition()
    for row, y in @tilemap.tiles
      for cell, x in row
        sprite = @tilemap.sprites[cell.image.sprite]
        sprite.setPosition(x*@tilemap.frameWidth, y*@tilemap.frameHeight)
        sprite.setFrameByRowAndCol(cell.image.row, cell.image.col)
        console.log("drawing frame row #{cell.image.row} col #{cell.image.col}")
        sprite.draw(context)
    @drawChildren(context)
