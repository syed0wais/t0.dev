# Use official Node.js image
FROM node:18

# Set working directory
WORKDIR /usr/src/app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy all source files (excluding node_modules via .dockerignore)
COPY . .

# Create a directory for previews and set permissions
# Note: This directory will be mounted to Render's Persistent Disk
RUN mkdir -p /usr/src/app/previews && \
    chown -R node:node /usr/src/app/previews

# Explicitly declare the volume for Render's Persistent Disk
# Render will automatically mount storage here if enabled in the dashboard
VOLUME /usr/src/app/previews

# Switch to non-root user for security
USER node

# Expose the app port (must match your server.js port)
EXPOSE 3000

# Start the application
CMD ["node", "server.js"]
