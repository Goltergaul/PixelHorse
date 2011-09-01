class ph.TileMapDrawer extends ph.Drawable
  
  constructor: (@tilemap) ->
    super
    for spritename, sprite of @tilemap.sprites
      sprite.setParent(this)
    
  draw: (context) ->
    super(context)
    indexes = @getVisibleTileIndexes()
    `for(y = indexes.startRow; y < indexes.endRow; y++) {`
    row = @tilemap.tiles[y]
    continue if not row
    `for(x = indexes.startCol; x < indexes.endCol; x++) {`
    cell = row[x]
    continue if not cell
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
    `}}`
          
    @drawChildren(context)
    
  getSpriteName: (name) ->
    "#{@tilemap.tileSrc}/#{name}.png"

  getVisibleTileIndexes: () ->
    [x, y] = @getAbsolutePosition()
    [w, h] = @getViewportDimensions()
    @tilemap.getTileIndexesFromRect(x, y, w, h)
