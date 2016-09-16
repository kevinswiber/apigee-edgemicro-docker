#!/bin/sh

edgemicro init

if [ -z "$EDGEMICRO_PASS" ]; then
  read -s -p "password:" EDGEMICRO_PASS
  echo ""
fi

edgemicro configure -o $EDGEMICRO_ORG -e $EDGEMICRO_ENV -u $EDGEMICRO_USER -p $EDGEMICRO_PASS > /tmp/output && \
cat /tmp/output | tail -n 4 | head -n 2 | sed 's/.*\(.\{64\}\)/\1/' > /tmp/keyoutput && \
echo ""
echo "# use these environment variables to start edgemicro"
cat /tmp/keyoutput | head -n 1 | awk '{print "export EDGEMICRO_KEY="$1}' && \
cat /tmp/keyoutput | tail -n 1 | awk '{print "export EDGEMICRO_SECRET="$1}' && \
echo "export EDGEMICRO_ORG=$EDGEMICRO_ORG" && \
echo "export EDGEMICRO_ENV=$EDGEMICRO_ENV" && \
rm /tmp/keyoutput
rm /tmp/output
