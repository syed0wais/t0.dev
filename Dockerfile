# Use Node.js LTS version with Alpine for smaller image size
FROM node:20-alpine

# Add tini and python3 for better signal handling and whisper support
RUN apk add --no-cache tini python3 py3-pip

# Create app directory
WORKDIR /usr/src/app

# Copy package files first for better caching
COPY package*.json ./

# Install dependencies with clean npm cache
RUN npm ci --only=production && \
    npm cache clean --force

# Install whisper
RUN pip3 install whisper

# Copy app source
COPY . .

# Create required directories and ensure they persist
RUN mkdir -p /usr/src/app/downloads /usr/src/app/workspaces /usr/src/app/previews /usr/src/app/uploads && \
    chown -R node:node /usr/src/app

# Use non-root user
USER node

# Expose port
EXPOSE 3000

# Use tini as entrypoint
ENTRYPOINT ["/sbin/tini", "--"]

# Start the application
CMD [ "npm", "start" ]
