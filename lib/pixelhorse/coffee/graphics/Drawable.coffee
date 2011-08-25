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
    if @parent
      positions = [@x + @parent.x, @y + @parent.y]
    else
      positions = [@x, @y]
      
    offsets = @getViewportOffsets()
    positions[0] += offsets[0]
    positions[1] += offsets[1]
    
    return positions
      
  getViewportOffsets: () ->
    offsets = [0, 0]
    
    p = this
    loop 
      if p.viewport
        viewportOffset = p.viewport.getOffsets()
        offsets[0] -= viewportOffset[0]
        offsets[1] -= viewportOffset[1]
      break if p.parent is null
      p = p.parent
      
    return offsets
  
  draw: (context) ->
    for drawable in @drawables
      drawable.draw(context)