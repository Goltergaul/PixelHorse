class ph.SpriteCanvas extends ph.BitmapCanvas
  constructor: (bitmapSrc, @frameWidth, @frameHeight, @frameSpacingX = 0, @frameSpacingY = 0) ->
    super(bitmapSrc)
    @currentFrame = 0
    
  getFrameRowAndColFromFrameNumber: (frame) ->
    framesPerRow = @w / (@frameWidth + @frameSpacingX)
    row = Math.floor(frame / framesPerRow) + 1
    col = frame - ((row - 1) * framesPerRow) + 1
    return [row, col]
    
  setFrameByRowAndCol: (row, col) ->
    framesPerRow = Math.floor(@w / (@frameWidth + @frameSpacingX))
    @currentFrame = row * framesPerRow + col
    
  draw: (context) ->
    [x, y] = @getAbsolutePosition()
    framePosition = @getFrameRowAndColFromFrameNumber(@currentFrame)
    sx = (@frameWidth + @frameSpacingX) * framePosition[1] - @frameWidth
    sy = (@frameHeight + @frameSpacingY) * framePosition[0] - @frameHeight
    context.drawImage(@image, sx, sy, @frameWidth, @frameHeight, x, y, @frameWidth, @frameHeight)
    @drawChildren(context)
