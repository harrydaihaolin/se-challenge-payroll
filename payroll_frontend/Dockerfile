FROM node:alpine as builder
WORKDIR /app
COPY . ./
RUN npm install
RUN npm install react-scripts@3.4.0 -g
EXPOSE 3000
CMD ["npm", "start"]


