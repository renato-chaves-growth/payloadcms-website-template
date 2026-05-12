FROM node:20-slim

RUN apt-get update && apt-get install -y \
    libvips-dev \
        python3 \
            make \
                g++ \
                    && rm -rf /var/lib/apt/lists/*

                    RUN npm install -g pnpm

                    WORKDIR /app

                    COPY package.json ./

                    RUN pnpm install --no-frozen-lockfile && \
                        npm install --platform=linux --arch=x64 sharp

                        COPY . .

                        RUN pnpm run build

                        EXPOSE 3000

                        ENV NODE_ENV=production

                        CMD ["pnpm", "start"]
