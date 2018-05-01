FROM node:10
WORKDIR /app
COPY package.json /app/
RUN npm install
COPY ./ /app/
ENTRYPOINT [ "node", "-r", "dotenv/config", "./bin/www.js", "dotenv_config_path=./config/.env" ]