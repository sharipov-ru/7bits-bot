Wolfram = require('wolfram').createClient(process.env.HUBOT_WOLFRAM_APPID)

module.exports = (robot) ->
  robot.respond /(question|wfa) (.*)$/i, (msg) ->
    Wolfram.query msg.match[2], (e, result) ->
      if result and result.length > 0
        msg.send result[1]['subpods'][0]['value']
      else
        msg.send 'Hmm...not sure'
