class ph.Drawable
  
  constructor: () ->
    @drawables = []
    @viewport = null
    @invalidateSize()
    @x = @y = @w = @h = 0
    @wPercent = @hPercent = null
     
  addDrawable: (drawable) ->
    drawable.setParent(this)
    @drawables.push(drawable)
    
  addViewport: (@viewport) ->
    
  setPosition: (@x, @y) ->
    
  setParent: (@parent) ->
    
  invalidateSize: () ->
    @recalculateSize = true
    for drawable in @drawables
      drawable.invalidateSize()
    
  setDimensions: (w, h) ->
    if typeof w is "string" and w.indexOf("%") != -1
      @wPercent = w.extractPercent()
    else
      @w = w
      @wPercent = null
      
    if typeof h is "string" and h.indexOf("%") != -1
      @hPercent = h.extractPercent()
    else
      @h = h
      @hPercent = null
      
  measure: (measuredWidth, measuredHeight) ->
    @recalculateSize = false
    if @wPercent
      @setWidth( Math.round(measuredWidth / 100 * @wPercent) )
    
    if @hPercent
      @setHeight( Math.round(measuredHeight / 100 * @hPercent) )
      
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
      break if not p.parent
      p = p.parent
      
    return offsets
    
  getViewportDimensions: () ->
    p = this
    loop 
      break if not p.parent
      p = p.parent
    [p.element.width, p.element.height]
    
  draw: (context) ->
    if @recalculateSize
      @measure()
  
  drawChildren: (context) ->
    for drawable in @drawables
      drawable.draw(context)
      
  getWidth: () ->
    @w
   
  getHeight: () ->
    @h
    
  setWidth: (@w) ->
    for drawable in @drawables
      drawable.invalidateSize()
      
  setHeight: (@h) ->
    for drawable in @drawables
      drawable.invalidateSize()
