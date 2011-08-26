fs     = require 'fs'
{exec} = require 'child_process'
util   = require 'util'

prodSrcCoffeeDir     = 'lib/pixelhorse/coffee'
#testSrcCoffeeDir     = 'lib/pixelhorse/coffee/test'

prodTargetJsDir      = 'lib/pixelhorse'
testTargetJsDir      = 'lib/pixelhorse'

prodTargetFileName   = 'pixelhorse'
prodTargetCoffeeFile = "#{prodSrcCoffeeDir}/#{prodTargetFileName}.coffee"
prodTargetJsFile     = "#{prodTargetJsDir}/#{prodTargetFileName}.js"

prodCoffeeOpts = "--output #{prodTargetJsDir} --compile #{prodTargetCoffeeFile}"
testCoffeeOpts = "--output #{testTargetJsDir}"

# files must be in right order!
prodCoffeeFiles = [
    'PixelHorse'
    'graphics/Drawable'
    'graphics/Scene'
    'graphics/Viewport'
    'graphics/canvas/BitmapCanvas'
    'graphics/canvas/SpriteCanvas'
    'graphics/canvas/TextCanvas'
    'graphics/canvas/TileMapDrawerCanvas'
    'AssetManager'
    'ClockGenerator'
    'Keyboard'
    'TileMap'
]




task 'build', 'Build a single JavaScript file from prod files', ->
    util.log "Building #{prodTargetJsFile}"
    appContents = new Array remaining = prodCoffeeFiles.length
    util.log "Appending #{prodCoffeeFiles.length} files to #{prodTargetCoffeeFile}"

    for file, index in prodCoffeeFiles then do (file, index) ->
        fs.readFile "#{prodSrcCoffeeDir}/#{file}.coffee"
                  , 'utf8'
                  , (err, fileContents) ->
            util.log err if err

            appContents[index] = fileContents
            util.log "[#{index + 1}] #{file}.coffee"
            process() if --remaining is 0

    process = ->
        fs.writeFile prodTargetCoffeeFile
                   , appContents.join('\n\n')
                   , 'utf8'
                   , (err) ->
            util.log err if err

            exec "coffee #{prodCoffeeOpts}", (err, stdout, stderr) ->
                util.log err if err
                message = "Compiled #{prodTargetJsFile}"
                util.log message
                fs.unlink prodTargetCoffeeFile, (err) -> util.log err if err
                
task 'watch', 'Watch prod source files and build changes', ->
    util.log "Watching for changes in #{prodSrcCoffeeDir}"

    for file in prodCoffeeFiles then do (file) ->
        stats = fs.statSync("#{prodSrcCoffeeDir}/#{file}.coffee")
        fs.watchFile "#{prodSrcCoffeeDir}/#{file}.coffee", (curr, prev) ->
            if +curr.mtime isnt +prev.mtime
                util.log "Saw change in #{prodSrcCoffeeDir}/#{file}.coffee"
                invoke 'build'