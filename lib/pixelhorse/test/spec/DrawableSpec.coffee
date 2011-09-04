describe "Drawable", () ->
  it "should construct a new Drawable correctly", () ->
    d = new ph.Drawable()
    expect(d.recalculateSize).toBeTruthy()
    expect(d.drawables).toEqual([])
    expect(d.viewport).toBeNull()
    expect(d.x).toEqual(0)
    expect(d.y).toEqual(0)
    expect(d.w).toEqual(0)
    expect(d.h).toEqual(0)
    expect(d.wPercent).toBeNull()
    expect(d.hPercent).toBeNull()

  it "should set the parent property if a drawable is added to another", () ->
    d1 = new ph.Drawable()
    d2 = new ph.Drawable()
    
    spyOn(d1, 'invalidateSize')
    expect(d2.parent).toBeUndefined()
    
    d1.addDrawable(d2)
    
    expect(d2.parent).toEqual(d1)
    expect(d1.invalidateSize).toHaveBeenCalled()

  it "should invalidate size recursively", () ->
    d1 = new ph.Drawable()
    d2 = new ph.Drawable()
    d1.addDrawable(d2)
    d1.recalculateSize = d2.recalculateSize = false
    spyOn(d2, 'invalidateSize').andCallThrough()
    
    d1.invalidateSize()
    
    expect(d2.invalidateSize).toHaveBeenCalled()
    expect(d1.recalculateSize).toBeTruthy()
    expect(d2.recalculateSize).toBeTruthy()
    
  it "should get the Dimensions of the currently used viewport", () ->
    d1 = new ph.Drawable()
    d2 = new ph.Drawable()
    d1.addDrawable(d2)
    v1 = new ph.Viewport()
    d1.addViewport(v1)
    
    expect(d2.getViewportDimensions).toEqual([v1.getWidth(), v2.getWidth()])
    
  describe "setDimensions()", () ->
    
    it "should set width and height directly if they are {int}", () ->
      d1 = new ph.Drawable()
      d1.setDimensions(200, 300)
      
      expect(d1.w).toEqual(200)
      expect(d1.h).toEqual(300)
      expect(d1.wPercent).toBeNull()
      expect(d1.hPercent).toBeNull()
      
    it "should set percent width and/or height if a param is {string}", () ->
      d1 = new ph.Drawable()
      d1.setDimensions("50%", 300)
      
      expect(d1.h).toEqual(300)
      expect(d1.wPercent).toEqual(50)
      expect(d1.hPercent).toBeNull()
      
      d1.setDimensions(50, "10%")
      
      expect(d1.w).toEqual(50)
      expect(d1.wPercent).toBeNull()
      expect(d1.hPercent).toEqual(10)
      
  it "should recalculate size on draw if necessary", () ->
    d1 = new ph.Drawable()
    spyOn(d1, 'measure').andCallThrough()
    
    d1.draw()
    expect(d1.measure).toHaveBeenCalled()
    
    # after having recalculated it must not do so again
    d1.measure.reset()
    d1.draw()
    expect(d1.measure.wasCalled).toBeFalsy()
    
  it "should draw all childrens", () ->
    d1 = new ph.Drawable()
    d2 = new ph.Drawable()
    d1.addDrawable(d2)
    
    spyOn(d2, 'draw')
    context = document.createElement('canvas').getContext("2d")
    d1.drawChildren(context)
    expect(d2.draw).toHaveBeenCalledWith(context)
    
  it "should invalidate size to set width or height", () ->
    d1 = new ph.Drawable()
    d2 = new ph.Drawable()
    d1.addDrawable(d2)
    d1.recalculateSize = false
    d2.recalculateSize = false
    d1.setWidth(100)
    
    expect(d1.recalculateSize).toBeFalsy()
    expect(d2.recalculateSize).toBeTruthy()
    
    d1.recalculateSize = false
    d2.recalculateSize = false
    d1.setHeight(100)
    
    expect(d1.recalculateSize).toBeFalsy()
    expect(d2.recalculateSize).toBeTruthy()
          
  describe "getAbsolutePosition()", () ->
    
    it "should work without a parent", () ->
      d1 = new ph.Drawable()
      expect(d1.getAbsolutePosition()).toEqual([0,0])
      
      d1.setPosition(10,20)
      expect(d1.getAbsolutePosition()).toEqual([10,20])
      
    it "should take an viewport into account", () ->
      d1 = new ph.Drawable()
      d1.setPosition(10,20)
      spyOn(d1, 'getViewportOffsets').andReturn([50,100])
      
      expect(d1.getAbsolutePosition()).toEqual([60,120])
      
    it "should take into account viewports and offsets of its parents", () ->
      d1 = new ph.Drawable()
      d2 = new ph.Drawable()
      d1.addDrawable(d2)
      
      d1.setPosition(10, 20)
      d2.setPosition(5,8)
      spyOn(d2, 'getViewportOffsets').andReturn([60,70])
      
      expect(d2.getAbsolutePosition()).toEqual([75,98])
      
  describe "getViewportOffsets()", () ->
    
    it "should sum up all viewport offsets", () ->
      d1 = new ph.Drawable()
      d2 = new ph.Drawable()
      d1.addDrawable(d2)
      
      v1 = new ph.Viewport()
      v1.setOffset(100,200)
      v2 = new ph.Viewport()
      v2.setOffset(300,600)
      
      d1.addViewport(v1)
      d2.addViewport(v2)
      
      expect(d2.getViewportOffsets()).toEqual([-400,-800])
