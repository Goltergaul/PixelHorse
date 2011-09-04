gfxContext = null

describe "LinearLayout", () ->
  
  beforeEach () ->
    gfxContext = document.createElement('canvas').getContext("2d")
    
  it "should draw all its children", () ->
    layout = new ph.LinearLayout(ph.LinearLayout.HORIZONTAL)
    spyOn(layout, "drawChildren")
    
    layout.draw(gfxContext)
    
    expect(layout.drawChildren).toHaveBeenCalled()
  
  describe "measure()", () ->
    
    it "should align children horizontally", () ->
      d1 = new ph.Drawable()
      d1.setWidth(100)
      d2 = new ph.Drawable()
      d2.setWidth(50)
      d3 = new ph.Drawable()
      d3.setWidth(25)
      
      layout = new ph.LinearLayout(ph.LinearLayout.HORIZONTAL)
      layout.addDrawable(d1)
      layout.addDrawable(d2)
      layout.addDrawable(d3)
      
      layout.draw(gfxContext)
      
      expect(d1.getAbsolutePosition()).toEqual([0,0])
      expect(d2.getAbsolutePosition()).toEqual([100,0])
      expect(d3.getAbsolutePosition()).toEqual([150,0])
      
    it "should align children vertically", () ->
      d1 = new ph.Drawable()
      d1.setHeight(100)
      d2 = new ph.Drawable()
      d2.setHeight(50)
      d3 = new ph.Drawable()
      d3.setHeight(25)
      
      layout = new ph.LinearLayout(ph.LinearLayout.VERTICAL)
      layout.addDrawable(d1)
      layout.addDrawable(d2)
      layout.addDrawable(d3)
      
      layout.draw(gfxContext)
      
      expect(d1.getAbsolutePosition()).toEqual([0,0])
      expect(d2.getAbsolutePosition()).toEqual([0,100])
      expect(d3.getAbsolutePosition()).toEqual([0,150])
      
  describe "Integration Tests", () ->
    dom = scene = hLayout = vLayout = d1 = d2 = d3 = null
    
    beforeEach () ->
      dom = $("<div style='width:300px;height:400px'></div>")
      scene = new ph.Scene(dom)
      hLayout = new ph.LinearLayout(ph.LinearLayout.HORIZONTAL)
      vLayout = new ph.LinearLayout(ph.LinearLayout.VERTICAL)
      d1 = new ph.Drawable()
      d2 = new ph.Drawable()
      d3 = new ph.Drawable()
    
    it "should work to nest layouts", () ->
      d1.setDimensions(20,30)
      d2.setDimensions(30,60)
      d3.setDimensions(50,5) 
      
      hLayout.addDrawable(d1)
      vLayout.addDrawable(d2)
      vLayout.addDrawable(d3)
      hLayout.addDrawable(vLayout)
      scene.addDrawable(hLayout)
      
      scene.draw(gfxContext)
      
      expect(d1.getAbsolutePosition()).toEqual([0,0])
      expect(d2.getAbsolutePosition()).toEqual([20,0])
      expect(d3.getAbsolutePosition()).toEqual([20,60])
      
    it "should be possible to specify percent dimensions", () ->
      d1.setDimensions("20%", 100)
      d2.setDimensions("80%", 100)
      
      hLayout.setDimensions("100%", "100%")
      hLayout.addDrawable(d1)
      hLayout.addDrawable(d2)
      scene.addDrawable(hLayout)
      scene.draw(gfxContext)
      
      expect(d1.getAbsolutePosition()).toEqual([0,0])
      expect(d1.getWidth()).toEqual(60)
      expect(d2.getAbsolutePosition()).toEqual([60,0])
      expect(d2.getWidth()).toEqual(240)
      
    it "should be possible to mix percent and absolute dimensions", () ->
      d1.setDimensions("100%", 100)
      d2.setDimensions(100, 20)
      d3.setDimensions(110, 40)
      
      hLayout.setDimensions("100%", "100%")
      hLayout.addDrawable(d1)
      vLayout.setDimensions(70, "100%")
      hLayout.addDrawable(vLayout)
      vLayout.addDrawable(d2)
      vLayout.addDrawable(d3)
      scene.addDrawable(hLayout)
      scene.draw(gfxContext)
      
      expect(d1.getAbsolutePosition()).toEqual([0,0])
      expect(d1.getWidth()).toEqual(230)
      expect(d2.getAbsolutePosition()).toEqual([230,0])
      expect(d3.getAbsolutePosition()).toEqual([230,20])
      
    it "should work with nested layouts and percent dimensions", () ->
      d1.setDimensions("100%", 100)
      d2.setDimensions(100, 100)
      
      hLayout.setDimensions("100%", "100%")
      hLayout.addDrawable(d1)
      hLayout.addDrawable(d2)
      scene.addDrawable(hLayout)
      scene.draw(gfxContext)
      
      expect(d1.getAbsolutePosition()).toEqual([0,0])
      expect(d1.getWidth()).toEqual(200)
      expect(d2.getAbsolutePosition()).toEqual([200,0])
