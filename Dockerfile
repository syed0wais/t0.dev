# Use Node.js LTS version with Alpine for smaller image size
FROM node:20-alpine

# Add tini and python3 for better signal handling and whisper support
RUN apk add --no-cache tini python3 py3-pip

# Create app directory
WORKDIR /usr/src/app

# Create and activate virtual environment for Whisper
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Install Whisper in the virtual environment
RUN . /opt/venv/bin/activate && pip3 install whisper

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
    chown -R node:node /usr/src/app && \
    # Give node user permission to install packages
    chown -R node:node /usr/src/app/.npm

# Use non-root user
USER node

# Expose port
EXPOSE 3000

# Use tini as entrypoint
ENTRYPOINT ["/sbin/tini", "--"]

# Start the application
CMD [ "npm", "start" ]
