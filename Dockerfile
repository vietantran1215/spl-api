FROM node:24-alpine AS builder
WORKDIR /app
COPY . .
RUN npm ci && npm run build

FROM node:24-alpine
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
CMD ["node", "dist/main.js"]