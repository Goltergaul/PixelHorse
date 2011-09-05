console.log(jasmine.Matchers)
jasmine.Matchers.prototype.toThrow = (expected) ->
  result = false
  exception = null
  if typeof this.actual != 'function' 
    throw new Error('Actual is not a function')
  
  try 
    @actual()
  catch e 
    exception = e
  
  if (exception) 
    result = (expected == jasmine.undefined || @env.equals_(exception.message || exception, expected.message || expected) || @env.equals_(exception.name, expected))
  

  _not = if @isNot then "not " else ""

  message = () ->
    if exception && (expected == jasmine.undefined || @env.equals_(exception.message || exception, expected.message || expected))
      message = if expected then expected.name || expected.message || expected else " an exception"
      return ["Expected function " + _not + "to throw", message, ", but it threw", exception.name || exception.message || exception].join(' ')
    else
      return "Expected function to throw an exception."

  return result
