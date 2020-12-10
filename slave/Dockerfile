FROM ethereum/client-go

ENV SLAVE true
# If boot.key changed，it should be modified
ENV MASTER_NODE_KEY 13773927f16701da8e53a2ff3e352f48d18a9a883c5d89ccff1acad11860b9411bb0f9bd2cf024f548e19c16ad9763581e7e2b7310924e28bd7d470062294606

RUN mkdir /root/.ethereum
WORKDIR /root/.ethereum
COPY genesis.json .
COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
