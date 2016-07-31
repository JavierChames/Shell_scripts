#!/bin/bash

API=o.iJ8on6x180u5NL9hfTauZCB1UVeAdDPg
#MSG="javier first test"
MSG="$1"
t="test"
curl -u $API: https://api.pushbullet.com/v2/pushes -d type=note -d title="Alert" -d body="added $t for download"
