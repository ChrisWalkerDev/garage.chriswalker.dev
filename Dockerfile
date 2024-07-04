FROM node:20.14-alpine AS build

# Create app directory
WORKDIR /dist/src/app

# Remove cache
RUN npm cache clean --force

# Add the source code to app
COPY . .

# Install all the dependencies
RUN npm install

# Generate the build of the application
RUN npm run build --prod

# Defining nginx image to be used
FROM nginx:latest as ngi

# Copying compiled code and nginx config to different folder
COPY --from=build /dist/src/app/dist/garage.chriswalker.dev/browser /usr/share/nginx/html
COPY /nginx.conf  /etc/nginx/conf.d/default.conf

EXPOSE 8080
