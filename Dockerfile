FROM ubuntu:latest

# Install curl
RUN apt-get update && apt-get install -y --no-install-recommends curl  && rm -rf /var/lib/apt/lists/*

CMD /bin/bash
