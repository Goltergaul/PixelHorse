class ph.BitmapCanvas extends ph.Drawable
  
  constructor: (@src) ->
    super
    self = this
    @image = ph.Images.load(@src, (image) =>
      @setWidth(image.width)
      @setHeight(image.height)
    )
    
  draw: (context) ->
    super(context)
    [x, y] = @getAbsolutePosition()
    context.drawImage(@image, x, y, @w, @h)
    @drawChildren(context)
