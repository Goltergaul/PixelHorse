class ph.TextCanvas extends ph.Drawable
  
  constructor: (@text) ->
    super
    
  draw: (context) ->
    [x, y] = @getAbsolutePosition()
    context.fillText(@text, x, y)
    @drawChildren(context)
