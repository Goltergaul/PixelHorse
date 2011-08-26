class ph.BitmapCanvas extends ph.Drawable
  
  constructor: (@src) ->
    super
    @image = new Image()
    @image.src = @src
    @w = @image.width
    @h = @image.height
    
  draw: (context) ->
    [x, y] = @getAbsolutePosition()
    context.drawImage(@image, x, y, @w, @h)
    @drawChildren(context)
