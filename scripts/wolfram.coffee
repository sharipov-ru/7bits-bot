wolfram = require('wolfram-alpha').createClient(process.env.HUBOT_WOLFRAM_APPID, {})

module.exports = (robot) ->
  robot.respond /(question|wfa) (.*)$/i, (msg) ->

    searchTerm = msg.match[2]

    wolfram.query searchTerm, (err, results) ->
      if results and results.length > 0
        msg.send chooseBestResult(results)
      else
        msg.send 'Hmm...not sure'

    chooseBestResult = (results) ->
      bestResult = null

      # Try to find a map in results
      for result in results
        if result['title'] == 'Local map'
          bestResult = result['subpods'][0]['image']
          console.log(bestResult)
          break

      # Try to find a plot in results
      for result in results
        if result['title'] == 'Plots'
          bestResult = result['subpods'][0]['image']
          break

      # Try to find a geometric figure in results
      unless bestResult
        for result in results
          if result['title'] == 'Geometric figure'
            bestResult = result['primary']
            break

      if bestResult
        bestResult
      else
        results[1]['subpods'][0]['text']
