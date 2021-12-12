# build phase, build the react app
FROM node:16-alpine

WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# /app/build <--- all the build stuff

# run phase, get nginx up and serving the build

# Once we see a second FROM block here, we know the previous
# phase is complete
FROM nginx
EXPOSE 80
COPY --from=0 /app/build /usr/share/nginx/html
# DO NOT NEED start/run NGINX, that is the default command. If there is no RUN statement the container will use the
# default image command