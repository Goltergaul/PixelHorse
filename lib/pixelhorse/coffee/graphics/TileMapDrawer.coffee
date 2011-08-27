class ph.TileMapDrawer extends ph.Drawable
  
  constructor: (@tilemap) ->
    super
    for spritename, sprite of @tilemap.sprites
      sprite.setParent(this)
    
  draw: (context) ->
    [x, y] = @getAbsolutePosition()
    for row, y in @tilemap.tiles
      for cell, x in row
        
        # draw background if any
        if cell.bgImage
          bgSprite = @sprites[cell.bgImage.sprite]
          bgSprite.setPosition(x*@tilemap.frameWidth, y*@tilemap.frameHeight)
          bgSprite.setFrameByRowAndCol(cell.bgImage.row, cell.bgImage.col)
          bgSprite.draw(context)
       
        # draw foreground
        sprite = @sprites[cell.image.sprite]
        sprite.setPosition(x*@tilemap.frameWidth, y*@tilemap.frameHeight)
        sprite.setFrameByRowAndCol(cell.image.row, cell.image.col)
        sprite.draw(context)
          
    @drawChildren(context)
    
  getSpriteName: (name) ->
    "#{@tilemap.tileSrc}/#{name}.png"
