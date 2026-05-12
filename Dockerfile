FROM node:20-slim

# Install system dependencies for sharp (libvips) and other native modules
RUN apt-get update && apt-get install -y \
    libvips-dev \
        python3 \
            make \
                g++ \
                    && rm -rf /var/lib/apt/lists/*
                    
                    # Install pnpm
                    RUN npm install -g pnpm
                    
                    WORKDIR /app
                    
                    # Copy package files
                    COPY package.json ./
                    
                    # Install dependencies WITHOUT frozen-lockfile
                    RUN pnpm install --no-frozen-lockfile
                    
                    # Copy the rest of the source
                    COPY . .
                    
                    # Build the application
                    RUN pnpm run build
                    
                    EXPOSE 3000
                    
                    ENV NODE_ENV=production
                    
                    CMD ["pnpm", "start"]FROM node:20-alpine AS base

# Install system dependencies for sharp and other native modules
RUN apk add --no-cache \
    vips-dev \
        python3 \
            make \
                g++ \
                    libc6-compat
                    
                    # Install pnpm
                    RUN npm install -g pnpm
                    
                    WORKDIR /app
                    
                    # Copy package files
                    COPY package.json ./
                    
                    # Install dependencies WITHOUT frozen-lockfile
                    # Force sharp to build from source for Alpine (musl libc)
                    ENV npm_config_sharp_libvips_binary_host="https://github.com/lovell/sharp-libvips/releases/download"
                    RUN pnpm install --no-frozen-lockfile
                    RUN pnpm rebuild sharp || true
                    
                    # Copy the rest of the source
                    COPY . .
                    
                    # Build the application
                    RUN pnpm run build
                    
                    EXPOSE 3000
                    
                    ENV NODE_ENV=production
                    
                    CMD ["pnpm", "start"]FROM node:20-alpine AS base

# Install system dependencies for sharp and other native modules
RUN apk add --no-cache \
    vips-dev \
        python3 \
            make \
                g++ \
                    libc6-compat

                    # Install pnpm
                    RUN npm install -g pnpm

                    WORKDIR /app

                    # Copy package files
                    COPY package.json ./

                    # Install dependencies WITHOUT frozen-lockfile
                    RUN pnpm install --no-frozen-lockfile

                    # Copy the rest of the source
                    COPY . .

                    # Build the application
                    RUN pnpm run build

                    EXPOSE 3000

                    ENV NODE_ENV=production

                    CMD ["pnpm", "start"]
