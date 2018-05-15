FROM ubuntu:latest

# Install curl
RUN apt-get update && apt-get install -y --no-install-recommends curl  && rm -rf /var/lib/apt/lists/*

# Add custom scripts
COPY curl_cors.sh /usr/local/bin
RUN chmod a+x /usr/local/bin/curl_cors.sh

CMD /bin/bash
