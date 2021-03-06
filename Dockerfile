FROM mhart/alpine-node as buildContainer
RUN apk add --update git && \
 rm -rf /tmp/ /var/cache/apk/
WORKDIR /app
COPY ./package.json /app/
RUN npm install
COPY . /app
RUN npm set progress=false && npm config set depth 0 && npm cache clean --force
RUN npm run build:ssr

# FROM node:8-alpine

# WORKDIR /app
# # Copy dependency definitions
# COPY --from=buildContainer /app/package.json /app
# COPY --from=buildContainer /app/server.js /app

# # Get all the code needed to run the app
# COPY --from=buildContainer /app/dist /app/dist
# COPY --from=buildContainer /app/static /app/static
# COPY --from=buildContainer /app/dist-server /app/dist-server

# # Expose the port the app runs in
EXPOSE 4000

# # Serve the app
CMD ["npm", "run", "serve:ssr"]
