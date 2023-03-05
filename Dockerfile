FROM node:19-bullseye
ENV NODE_ENV=production
ENV ORACLEDB_CONNECTSTRING=10.100.201.4/welsdev
ENV ORACLEDB_USER=wels
ENV ORACLEDB_PASSWORD=wels

# Set the working directory to /app
WORKDIR /app

# Copy the package.json and package-lock.json files to the container
COPY ./out/json .

# Install Node.js dependencies
RUN npm install
RUN npm install -g turbo

# Install the Oracle Instant Client libraries
# RUN apt-get update && \
#    apt-get install -y unzip && \
#    apt-get install -y libaio1 && \
#    apt-get clean && \
#    rm -rf /var/lib/apt/lists/* && \
#    mkdir /opt/oracle && \
#    cd /opt/oracle && \
#    curl -o instantclient-basic-linux.x64-19.12.0.0.0dbru.zip https://download.oracle.com/otn_software/linux/instantclient/191200/instantclient-basic-linux.x64-19.12.0.0.0dbru.zip -SL && \
#    curl -o instantclient-sdk-linux.x64-19.12.0.0.0dbru.zip https://download.oracle.com/otn_software/linux/instantclient/191200/instantclient-sdk-linux.x64-19.12.0.0.0dbru.zip -SL && \
#    unzip instantclient-basic-linux.x64-19.12.0.0.0dbru.zip && \
#    unzip instantclient-sdk-linux.x64-19.12.0.0.0dbru.zip && \
#    rm instantclient-basic-linux.x64-19.12.0.0.0dbru.zip instantclient-sdk-linux.x64-19.12.0.0.0dbru.zip && \
#    echo /opt/oracle/instantclient_19_12 > /etc/ld.so.conf.d/oracle-instantclient.conf && \
#    ldconfig

# Set environment variables required by the Oracle Instant Client
ENV OCI_LIB_DIR=/opt/oracle/instantclient_19_12
ENV OCI_INC_DIR=/opt/oracle/instantclient_19_12/sdk/include
# COPY tnsnames.ora /usr/lib/oracle/21/client64/lib/network/admin
# Copy the rest of the application files to the container
COPY ./out/full .

# Expose the port that the server will listen on
EXPOSE 3000
# Change the ownership of the application files to the node user
RUN chown -R node /app
USER node
# Start the Node.js server
CMD node apps/server/server.js