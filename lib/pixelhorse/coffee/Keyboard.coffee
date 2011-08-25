class ph.Keyboard
  constructor: () ->
    @pressed = []
    document.addEventListener("keydown", @onKeyDown)
    document.addEventListener("keyup", @onKeyUp)
    
  onKeyDown: (event) =>
    @pressed[event.which] = true
    console.log(event.which, String.fromCharCode(event.which);)
    
  onKeyUp: (event) =>
    delete @pressed[event.which]
