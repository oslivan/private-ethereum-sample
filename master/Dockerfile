FROM ethereum/client-go

ENV MASTER true

RUN mkdir /root/.ethereum
WORKDIR /root/.ethereum
COPY genesis.json .
COPY passfile .
COPY boot.key .
COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
