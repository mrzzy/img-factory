#
# TiddlyWiki - TiddlyWiki NodeJS
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

# create a new wiki to serve backed by a volume
ENV WIKI_DIR=/wiki
RUN mkdir ${WIKI_DIR} && chown tiddly ${WIKI_DIR}
USER tiddly
RUN tiddlywiki ${WIKI_DIR} --init server

# copy entrypoint script
COPY entrypoint.sh .


# run tiddlywiki on container start
ENTRYPOINT ["ash"]
CMD ["entrypoint.sh"]
