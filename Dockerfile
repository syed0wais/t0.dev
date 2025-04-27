FROM node:18

# Set working directory
WORKDIR /usr/src/app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy app files
COPY . .

# Create directories and set permissions
RUN mkdir -p /usr/src/app/uploads && \
    mkdir -p /usr/src/app/previews && \
    chown -R node:node /usr/src/app

# Switch to non-root user for security
USER node

# Expose port (match your server.js port)
EXPOSE 3000

# Start the app
CMD ["node", "server.js"]
