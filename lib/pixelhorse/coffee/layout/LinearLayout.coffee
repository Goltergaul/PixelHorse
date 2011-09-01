class ph.LinearLayout extends ph.Drawable
  @VERTICAL = "VERTICAL"
  @HORIZONTAL = "HORIZONTAL"
  
  constructor: (@direction) ->
    super
  
  addDrawable: (drawable) ->
    super(drawable)
    @invalidateSize()
    
  measure: () ->
    [minWidth, minHeight] = @calculateMinDimensions()
    widthLeft = Math.max(@getWidth() - minWidth, 0)
    heightLeft = Math.max(@getHeight() - minHeight, 0)
    super(widthLeft, heightLeft)
    [x, y] = @getAbsolutePosition()
    for drawable in @drawables
      drawable.setPosition(x, y)
      
      if @direction is ph.LinearLayout.VERTICAL
        y += drawable.getHeight()
      else
        x += drawable.getWidth()
        
    @recalculateSize = false
    
  calculateMinDimensions: () ->
    minWidth = minHeight = 0
    for drawable in @drawables
      if not drawable.wPercent
        minWidth += drawable.getWidth()
        
      if not drawable.hPercent
        minHeight += drawable.getHeight()

    [minWidth, minHeight]

  draw: (context) ->
    super context      
    @drawChildren(context)
