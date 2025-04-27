# Use Node.js LTS version with Alpine for smaller image size
FROM node:20-alpine

# Add tini for better signal handling
RUN apk add --no-cache tini

# Create app directory
WORKDIR /usr/src/app

# Copy package files first for better caching
COPY package*.json ./

# Install dependencies with clean npm cache and global Angular CLI
RUN npm ci --only=production && \
    npm cache clean --force && \
    npm install -g @angular/cli

# Copy app source
COPY . .

# Create required directories and ensure they persist
RUN mkdir -p /usr/src/app/downloads /usr/src/app/workspaces /usr/src/app/previews /usr/src/app/uploads && \
    mkdir -p /home/node/.npm && \
    chown -R node:node /usr/src/app && \
    chown -R node:node /home/node/.npm

# Use non-root user
USER node

# Expose port
EXPOSE 3000

# Use tini as entrypoint
ENTRYPOINT ["/sbin/tini", "--"]

# Start the application
CMD [ "npm", "start" ]
