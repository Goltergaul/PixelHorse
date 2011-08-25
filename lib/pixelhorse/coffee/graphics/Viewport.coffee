class ph.Viewport
  constructor: () ->
    @xOffset = @yOffset = 0 
    
  getOffsets: () ->
    [@xOffset, @yOffset]
    
  setOffset: (@xOffset, @yOffset) ->
    
