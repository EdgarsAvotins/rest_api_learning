require 'json'
require_relative 'features/support/api'

thumbnail = {'url' => 'https://media.giphy.com/media/8oh42nM14t50Q/giphy-facebook_s.jpg'}
fields = []
fields.push({'name' => 'fieldname', 'value' => 'fieldvalue'})
embed = []
embed.push('title' => 'Rich content',
  'title' => 'some title',
  'color' => 2210844,
  'fields' => fields,
  'thumbnail' => thumbnail,
)

payload = {'content' => 'magestic dickbutt', 'embeds' => embed}.to_json
url = "https://discordapp.com/api/webhooks/393067525451022336/uz2WgUi_8-6oS9zy2Pu_3l_-CtQvabdSlgflF_ojyxTxWgxO_8Vdj0qBDMNixDj6wlT1"

@api = Api.new
@api.post(url, headers: {'Content-Type'=> 'application/json'}, payload: payload)
