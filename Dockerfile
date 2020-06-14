FROM node:10 as builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
ARG API_URI
ENV API_URI ${API_URI:-http://localhost:8000/graphql/}
RUN API_URI=${API_URI} npm run build

FROM node:10-alpine
WORKDIR /app
RUN npm install --global http-server
COPY --from=builder /app/dist/ /app/

CMD ["http-server", "/app"]
