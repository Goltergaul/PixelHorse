class ph.Drawable
  
  constructor: () ->
    @drawables = []
    @x = 0
    @y = 0
     
  addDrawable: (drawable) ->
    drawable.setParent(this)
    @drawables.push(drawable)
    
  setPosition: (@x, @y) ->
    
  setParent: (@parent) ->
    
  getAbsolutePosition: () ->
    if @parent
      [@x + @parent.x, @y + @parent.y]
    else
      [@x, @y]
  
  draw: (context) ->
    for drawable in @drawables
      drawable.draw(context)