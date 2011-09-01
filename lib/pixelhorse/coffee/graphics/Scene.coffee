class ph.Scene extends ph.Drawable
  
  constructor: (parent) ->
    super
    
    parent = $(parent)
    @w = parent.width()
    @h = parent.height()
    
    @element = document.createElement("canvas")
    @element.width = @w
    @element.height = @h
    parent.append(@element)
    
    @gfxContext = @element.getContext("2d")
    

  draw: () =>
    @gfxContext.clearRect(0, 0, @width, @height)
    super(@gfxContext)
    @drawChildren(@gfxContext)
