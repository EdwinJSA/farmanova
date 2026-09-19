FROM node:18-alpine

# Instalar OpenSSL requerido por Prisma
RUN apk add --no-cache openssl

WORKDIR /app

# Copiar dependencias
COPY package*.json ./
RUN npm install

# Copiar el código fuente
COPY . .

# Generar el cliente de Prisma y compilar TypeScript
RUN npx prisma generate
RUN npm run tsc

EXPOSE 3000

# Aplicar migraciones y arrancar apuntando a la carpeta Build
CMD ["sh", "-c", "npx prisma migrate deploy && node Build/index.js"]