FROM node:18 AS build

WORKDIR /app/frontend
COPY frontend/package*.json ./
RUN npm install
COPY frontend/ ./
RUN npm run build

FROM node:18

WORKDIR /app/backend
COPY backend/package*.json ./
RUN npm install
COPY backend/ ./
COPY --from=build /app/frontend/build ./public

EXPOSE 5000
CMD ["npm", "start"]
