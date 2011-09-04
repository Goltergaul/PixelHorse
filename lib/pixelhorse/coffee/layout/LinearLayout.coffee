###*
 * A LinearLayout aligns its children horizontally or vertically
 * @class Creates a new LinearLayout
 * @extends ph.Drawable
 * @param {ph.LinearLayout.VERTICAL|ph.LinearLayout.HORIZONTAL} direction The Layout direction
###
class ph.LinearLayout extends ph.Drawable
  ###*
    * @lends ph.Drawable.prototype
  ###

  @VERTICAL = "VERTICAL"
  @HORIZONTAL = "HORIZONTAL"
  
  ###*
   * @constructs
  ###
  constructor: (@direction) ->
    super
  
  ###*
   * Calculates the right offsets of the children to
   * draw them aligned vertically or horizontally
   *
   * @private
   * @memberOf ph.LinearLayout#
  ###
  measure: () ->
    super()
    x = y = 0
    for drawable in @drawables
      drawable.setPosition(x, y)
      if @direction is ph.LinearLayout.VERTICAL
        y += drawable.getHeight()
      else
        x += drawable.getWidth()
      
  ###*
   * Draws the linear Layout
   *
   * @memberOf ph.LinearLayout#
   * @param context A 2D drawing Context
  ###  
  draw: (context) ->
    super context
    @drawChildren(context)
