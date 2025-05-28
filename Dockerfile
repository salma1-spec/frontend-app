# Use official Node.js 14 as base image
FROM  --platform=linux/amd64 node:18 AS build
# Set working directory
WORKDIR /app
# Set environment variable
ARG VITE_API_URL
ENV VITE_API_URL=${VITE_API_URL}
# Copy package.json and package-lock.json
COPY package*.json ./
# Install dependencies
RUN npm install  --force
# Copy the rest of the client code
COPY . .
# Build the client for production
RUN npm run build

FROM  --platform=linux/amd64 nginx:alpine
# Copy the build artifacts from the build stage
COPY --from=build /app/dist /usr/share/nginx/html
# NGINX default configuration file
COPY nginx.conf /etc/nginx/nginx.conf
# Expose port 80
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

