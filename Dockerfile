FROM node:24.13.0 AS builder
WORKDIR /app

########
FROM builder AS client-base
COPY package.json package-lock.json ./
RUN npm install

COPY tsconfig*.json ./   
COPY eslint.config.js index.html vite.config.ts ./
COPY public ./public
COPY src ./src

########
FROM client-base AS client-dev
CMD ["npm", "run", "dev"]

###################################################
FROM client-base AS client-build
RUN npm run build