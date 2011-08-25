class ph.Scene
  
  constructor: (parent) ->
    parent = $(parent)
    @width = parent.width()
    @height = parent.height()
    
    @element = document.createElement("canvas")
    @element.width = @width
    @element.height = @height
    parent.append(@element)
    
    @gfxContext = @element.getContext("2d")

  addDrawable: (drawable) ->
    drawable.setParent(null)
    @drawables.push(drawable)

  draw: (dt) =>
    @gfxContext.clearRect(0, 0, @width, @height)
    for drawable in @drawables
      drawable.draw(@gfxContext)
