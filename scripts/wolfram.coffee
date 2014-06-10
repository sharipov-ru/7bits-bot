wolfram = require('wolfram-alpha').createClient(process.env.HUBOT_WOLFRAM_APPID, {})

module.exports = (robot) ->
  robot.respond /(question|wfa) (.*)$/i, (msg) ->

    searchTerm = msg.match[2]

    wolfram.query searchTerm, (err, result) ->
      if result and result.length > 0
        msg.send result[1]['subpods'][0]['text']
      else
        msg.send 'Hmm...not sure'
