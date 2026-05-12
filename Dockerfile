FROM node:20-alpine AS base

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
