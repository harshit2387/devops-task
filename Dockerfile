FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --production=false
COPY . .

FROM node:18-alpine
WORKDIR /app
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
COPY --from=builder /app/package*.json ./
RUN npm ci --production
COPY --from=builder /app ./
USER appuser
ENV NODE_ENV=production
EXPOSE 3000
CMD ["node", "index.js"]
