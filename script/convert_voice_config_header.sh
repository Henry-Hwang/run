cat $1 | sed -e 's/_RX/_RX_VOICE/g; s/_TX/_TX_VOICE/g' | grep "CSPL_CONFIG_" > "${1%.*}_voice.h"
