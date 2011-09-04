###*
 * A Object that can be drawn. All deriving classes must have a draw() function.  
 * This is a abstract Class
 * @class Creates a new Drawable
###
class ph.Drawable
  
  constructor: () ->
    @drawables = []
    @viewport = null
    @invalidateSize()
    @x = @y = @w = @h = 0
    @wPercent = @hPercent = null
     
  ###*
   * Adds a child Drawable to this drawable
   *
   * @memberOf ph.Drawable#
   * @param {ph.Drawable} drawable the drawable to be added
  ###
  addDrawable: (drawable) ->
    drawable.setParent(this)
    @drawables.push(drawable)
    @invalidateSize()
    
  ###*
   * Adds a viewport to this drawable
   *
   * @memberOf ph.Drawable#
   * @param {ph.Viewport} viewport the viewport to be added
  ###
  addViewport: (@viewport) ->
    
  ###*
   * Set the position of this drawable
   *
   * @memberOf ph.Drawable#
   * @param {int} x
   * @param {int} y
  ###
  setPosition: (@x, @y) ->
    
  ###*
   * Set the parent of this drawable. Do not set this manually
   *
   * @private
   * @memberOf ph.Drawable#
   * @param {ph.Drawable} parent the drawable that is the parent of this drawable
  ###
  setParent: (@parent) ->
    
  ###*
   * Invalidates the size of this drawable. The correct size will be recalculated at the next screen draw.
   *
   * @memberOf ph.Drawable#
  ###
  invalidateSize: () ->
    @recalculateSize = true
    for drawable in @drawables
      drawable.invalidateSize()
    
  ###*
   * Set the width and height of this drawable
   *
   * @memberOf ph.Drawable#
   * @param {int} width
   * @param {int} height
  ###
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
      
  ###*
   * Recalculates the correct width and height of this drawable
   *
   * @private
   * @memberOf ph.Drawable#
  ###
  measure: () ->
    @recalculateSize = false
    @absDim = @getAbsoulteDimensionSumOfSiblings()
    if @wPercent
      blah = @parent.getWidth()
      @w = Math.round((@parent.getWidth() - @absDim.w) / 100 * @wPercent)
    
    if @hPercent
      @h =  Math.round((@parent.getHeight()- @absDim.h) / 100 * @hPercent)
     
  ###*
   * Calculates the absolute width and height of all siblings while 
   * omitting prozentual scaled siblings
   *
   * @memberOf ph.Drawable#
   * @returns {Object} Object with w and h property
  ###
  getAbsoulteDimensionSumOfSiblings: () ->
    w = h = 0
    if @parent
      for drawable in @parent.drawables
        if not drawable.wPercent
          w += drawable.getWidth()
        if not drawable.hPercent
          h += drawable.getHeight()
    
    {w: w, h: h}
      
  ###*
   * Calculates the absolute position on the screen depending on Position and Viewport of this
   * drawable and it's parents
   *
   * @memberOf ph.Drawable#
   * @returns {int[]} Array of x and y position
  ###
  getAbsolutePosition: () ->
    positions = [0, 0]
    
    p = this
    loop 
      positions[0] += p.x
      positions[1] += p.y
      break if not p.parent
      p = p.parent
      
    offsets = @getViewportOffsets()
    positions[0] += Math.round(offsets[0])
    positions[1] += Math.round(offsets[1])
    
    return positions
    
  ###*
   * Calculates the relative position from its parent origin
   *
   * @memberOf ph.Drawable#
   * @returns {int[]} Array of x and y position
  ###
  getPosition: () ->
    return [@x, @y]
      
  ###*
   * Calculates the pixel offset depending on the viewport of this
   * drawable and it's parents
   *
   * @memberOf ph.Drawable#
   * @returns {int[]} Array of x and y offsets in pixel
  ###
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
    
  #FIXME This currently does not get a Viewport size, but the scene size
  ###*
   * Calculates width and height of the containing viewport.
   *
   * @memberOf ph.Drawable#
   * @returns {int[]} Array of width and height
  ###
  getViewportDimensions: () ->
    p = this
    loop 
      break if not p.parent
      p = p.parent
    [p.element.width, p.element.height]
    
  ###*
   * Draws this object
   *
   * @memberOf ph.Drawable#
   * @param {Context2D}
  ###
  draw: (context) ->
    if @recalculateSize
      @measure()
  
  ###*
   * Draws this object's children
   *
   * @memberOf ph.Drawable#
   * @param {Context2D}
  ###
  drawChildren: (context) ->
    for drawable in @drawables
      drawable.draw(context)
      
  ###*
   * Get the width of this drawable
   *
   * @memberOf ph.Drawable#
   * @returns {int} width
  ###
  getWidth: () ->
    if @recalculateSize
      @measure()
    @w
   
  ###*
   * Get the height of this drawable
   *
   * @memberOf ph.Drawable#
   * @returns {int} height
  ###
  getHeight: () ->
    if @recalculateSize
      @measure()
    @h
    
  ###*
   * Set a new width
   *
   * @memberOf ph.Drawable#
   * @param {int} width
  ###
  setWidth: (@w) ->
    for drawable in @drawables
      drawable.invalidateSize()
     
  ###*
   * Set a new height
   *
   * @memberOf ph.Drawable#
   * @param {int} height
  ### 
  setHeight: (@h) ->
    for drawable in @drawables
      drawable.invalidateSize()
