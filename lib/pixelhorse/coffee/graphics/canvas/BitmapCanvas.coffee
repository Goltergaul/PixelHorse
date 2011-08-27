class ph.BitmapCanvas extends ph.Drawable
  
  constructor: (@src) ->
    super
    self = this
    @image = ph.Images.load(@src, (image) =>
      @w = image.width
      @h = image.height
    )
    
  draw: (context) ->
    [x, y] = @getAbsolutePosition()
    context.drawImage(@image, x, y, @w, @h)
    @drawChildren(context)
