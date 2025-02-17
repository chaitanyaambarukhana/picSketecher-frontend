FROM node:latest as build

WORKDIR /app

COPY . .

RUN npm install && npm run build


FROM nginx:latest

COPY --from=build /app/dist /usr/share/nginx/html

COPY  ./default.conf /etc/nginx/conf.d/

CMD sed -i -e 's/$PORT/'"$PORT"'/g' /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'
