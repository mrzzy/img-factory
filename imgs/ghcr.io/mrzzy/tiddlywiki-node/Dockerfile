#
# TiddlyWiki - TiddlyWiki NodeJS Container;
#

FROM node:14.17-alpine3.11

# setup workdir & user for tiddlywiki
WORKDIR /home/tiddly
RUN addgroup --gid 12820 tiddly \
    && adduser --uid 12820  \
        --ingroup tiddly \
        --home /home/tiddly \
        --disabled-password tiddly

# install tiddlywiki with npm
RUN npm install -g tiddlywiki@5.1.23

# setup directory for wiki
ENV WIKI_DIR=/wiki
RUN mkdir ${WIKI_DIR}

# copy entrypoint script
COPY entrypoint.sh .

# run tiddlywiki on container start
ENTRYPOINT ["sh", "entrypoint.sh"]
