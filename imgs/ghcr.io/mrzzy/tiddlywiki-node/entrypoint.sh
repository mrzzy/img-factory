#!/bin/sh
set -e
#
# TiddlyWiki - TiddlyWiki NodeJS
# entrypoint script
#

# init wiki directory on first startup (empty wiki directory)
if [ -z "$(ls -A ${WIKI_DIR})" ]
then
    echo "[INFO] $(date -Iseconds): Initializing wiki directory on first startup"
    tiddlywiki ${WIKI_DIR} --init server
fi

# parse auth config from environment variables
if [ -n "$TIDDLYWIKI_AUTH_HEADER" ]
then
    echo "[INFO] $(date -Iseconds): Starting tiddlywiki with header authentication"
    AUTH_ARGS="authenticated-user-header=$TIDDLYWIKI_USERNAME readers=$TIDDLYWIKI_READERS writers=$TIDDLYWIKI_WRITERS"
elif [ -n "$TIDDLYWIKI_USERNAME" ] && [ -n "$TIDDLYWIKI_PASSWORD" ]
then
    echo "[INFO] $(date -Iseconds): Starting tiddlywiki with basic authentication"
    AUTH_ARGS="username=$TIDDLYWIKI_USERNAME password=$TIDDLYWIKI_PASSWORD"
else
    echo "[WARNING] $(date -Iseconds): Starting tiddlywiki with Anonymous Access"
    AUTH_ARGS=""
fi


exec tiddlywiki ${WIKI_DIR} --listen \
    host=0.0.0.0 \
    port=8080 \
    gzip=yes \
    debug-level=$TIDDLYWIKI_DEBUG \
    $AUTH_ARGS
