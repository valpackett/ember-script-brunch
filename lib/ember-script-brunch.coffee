es = require 'ember-script'

# based on https://github.com/brunch/coffee-script-brunch/blob/master/src/index.coffee

normalizeChecker = (item) ->
  switch toString.call(item)
    when '[object RegExp]'
      (string) -> item.test string
    when '[object Function]'
      item
    else
      -> false

module.exports = class EmberScriptCompiler
  brunchPlugin: yes
  type: 'javascript'
  extension: 'em'

  constructor: (@config) ->
    return

  compile: (data, path, callback) ->
    try
      normalizedVendor = normalizeChecker @config?.conventions?.vendor
      bare = not normalizedVendor path
      result = es.em2js data, {bare}
    catch err
      error = err
    finally
      callback error, result
