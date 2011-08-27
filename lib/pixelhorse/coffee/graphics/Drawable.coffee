class ph.Drawable
  
  constructor: () ->
    @drawables = []
    @viewport = null
    @x = 0
    @y = 0
     
  addDrawable: (drawable) ->
    drawable.setParent(this)
    @drawables.push(drawable)
    
  addViewport: (@viewport) ->
    
  setPosition: (@x, @y) ->
    
  setParent: (@parent) ->
    
  getAbsolutePosition: () ->
    positions = []
    if @parent and @parent instanceof ph.Drawable
      positions = [@x + @parent.x, @y + @parent.y]
    else
      positions = [@x, @y]
      
    offsets = @getViewportOffsets()
    positions[0] += Math.round(offsets[0])
    positions[1] += Math.round(offsets[1])
    
    return positions
      
  getViewportOffsets: () ->
    offsets = [0, 0]
    
    p = this
    loop 
      if p.viewport
        viewportOffset = p.viewport.getOffsets()
        offsets[0] -= viewportOffset[0]
        offsets[1] -= viewportOffset[1]
      break if p not instanceof ph.Drawable
      p = p.parent
      
    return offsets
    
  getViewportDimensions: () ->
    p = this
    loop 
      break if p not instanceof ph.Drawable
      p = p.parent
    [p.element.width, p.element.height]
  
  drawChildren: (context) ->
    for drawable in @drawables
      drawable.draw(context)