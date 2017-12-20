require 'json'
require_relative 'features/support/api'

build_number = ARGV[0]
job_url = ARGV[1]

thumbnail = {'url' => 'https://image.spreadshirtmedia.com/image-server/v1/mp/compositions/1020402791/views/1,width=300,height=300,backgroundColor=E8E8E8,version=1498225413/perhaps-cow-meme.jpg'}
fields = []
fields.push({'name' => 'perhaps', 'value' => 'perhaps'})
embed = []
embed.push('title' => 'perhaps',
  'color' => 2210844,
  'fields' => fields,
  'thumbnail' => thumbnail,
)

payload = {'content' => "#{build_number}\n #{job_url}", 'embeds' => embed}.to_json
url = "https://discordapp.com/api/webhooks/393067525451022336/uz2WgUi_8-6oS9zy2Pu_3l_-CtQvabdSlgflF_ojyxTxWgxO_8Vdj0qBDMNixDj6wlT1"

@api = Api.new
@api.post(url, headers: {'Content-Type'=> 'application/json'}, payload: payload)
