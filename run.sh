#!/bin/sh

# Set a random node name if not set.
if [ -z "${NODE_NAME}" ]; then
	NODE_NAME=$(uuidgen)
fi
export NODE_NAME=${NODE_NAME}

if [ ! -z "${ES_PLUGINS_INSTALL}" ]; then
   OLDIFS=$IFS
   IFS=','
   for plugin in ${ES_PLUGINS_INSTALL}; do
      if ! /elasticsearch/bin/elasticsearch-plugin list | grep -qs ${plugin}; then
         yes | /elasticsearch/bin/elasticsearch-plugin install --batch ${plugin}
      fi
   done
   IFS=$OLDIFS
fi

/elasticsearch/bin/elasticsearch