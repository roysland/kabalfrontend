FROM node:19-bullseye
ENV NODE_ENV=production

# Set the working directory to /app
WORKDIR /app

# Copy the package.json and package-lock.json files to the container
COPY ./out/json .

# Install Node.js dependencies
RUN npm install
RUN npm install -g turbo

# Copy the rest of the application files to the container
COPY ./out/full .
RUN npm install
# Expose the port that the server will listen on
EXPOSE 3000
# Change the ownership of the application files to the node user
RUN chown -R node /app
USER node
# Start the Node.js server
CMD node apps/server/server.js