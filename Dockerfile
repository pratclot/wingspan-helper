# Stage 1: Build Stage
FROM node:18 AS build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json (if available)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application source code
COPY . .

# Build the Vue app with Vite
RUN npm run build

# Stage 2: Production Stage
FROM nginx:stable-alpine

# Set the working directory in Nginx
WORKDIR /usr/share/nginx/html

# Copy the build output from the previous stage
COPY --from=build /app/dist .

# Copy custom Nginx configuration if needed
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose the default port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
