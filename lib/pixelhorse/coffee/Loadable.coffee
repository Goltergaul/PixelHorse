class ph.Loadable
  @objectCount = 0
  @objectLoadedCount = 0
  
  @getLoadingPercent: () ->
    @objectLoadedCount / @objectCount * 100
    
  @increaseLoadCount: () ->
    @objectCount++
    
  @increaseLoadedCount: () ->
    @objectLoadedCount++;
