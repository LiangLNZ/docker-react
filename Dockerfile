FROM node:alpine as builder
 
USER node
 
RUN mkdir -p /home/node/app
WORKDIR /home/node/app

# must set the permission here to make it works 
COPY --chown=node:node ./package.json ./
RUN npm install
COPY --chown=node:node ./ ./

RUN npm run build 


FROM nginx
EXPOSE 80
#here will work with or without chown to set the permission 
COPY --from=builder /home/node/app/build /usr/share/nginx/html

