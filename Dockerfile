FROM deis/init

RUN apt-get update
RUN apt-get upgrade -yq
RUN apt-get install -yq gcc make lua5.1-dev lua5.1
RUN apt-get install -yq lua-json lua-socket
RUN apt-get install -yq luarocks libyaml-dev
RUN luarocks install --server=http://rocks.moonscript.org moonrocks
RUN moonrocks install yaml
RUN moonrocks install moonscript

ADD . /app
ADD run/runit /etc/service/tetra

ENV TETRA_DOCKER YES
ENV TETRA_CONFIG_PATH "/app/etc/config.yaml"

ENTRYPOINT /sbin/my_init

