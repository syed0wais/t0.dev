# Use Node.js LTS version with Alpine for smaller image size
FROM node:20-alpine

# Add tini for better signal handling
RUN apk add --no-cache tini

# Create app directory
WORKDIR /usr/src/app

# Copy package files first for better caching
COPY package*.json ./

# Install dependencies with clean npm cache
RUN npm ci --only=production && \
    npm cache clean --force

# Copy app source and hardcode the API keys in server.js
COPY . .

# Update server.js with hardcoded values
RUN sed -i "s/process.env.FIGMA_TOKEN/\"figd_gJodVHdqIyuyNRFcKTJ-48xWDjRdFKln4VC3qOCm\"/" server.js && \
    sed -i "s/process.env.GEMINI_API_KEY/\"AIzaSyByaRJkoVkLv6YxkohXUx39_JwjzFIvC-E\"/" server.js

# Create required directories
RUN mkdir -p downloads workspaces previews uploads && \
    chown -R node:node .

# Use non-root user
USER node

# Expose port
EXPOSE 3000

# Use tini as entrypoint
ENTRYPOINT ["/sbin/tini", "--"]

# Start the application
CMD [ "npm", "start" ]
