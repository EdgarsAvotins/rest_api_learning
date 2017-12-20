require 'json'
require_relative 'features/support/api'

build_number = ARGV[0]
job_url = ARGV[1]

thumbnail = {'url' => 'http://i0.kym-cdn.com/photos/images/facebook/000/711/605/f6d.jpg'}
fields = []
fields.push({'name' => 'a', 'value' => 'b'})
embed = []
embed.push('title' => 'c',
  'color' => 2210844,
  'fields' => fields,
  'thumbnail' => thumbnail,
)

payload = {'content' => "#{build_number}\n #{job_url}", 'embeds' => embed}.to_json
url = "https://discordapp.com/api/webhooks/393067525451022336/uz2WgUi_8-6oS9zy2Pu_3l_-CtQvabdSlgflF_ojyxTxWgxO_8Vdj0qBDMNixDj6wlT1"

@api = Api.new
@api.post(url, headers: {'Content-Type'=> 'application/json'}, payload: payload)
