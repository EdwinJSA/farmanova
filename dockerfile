FROM node:18-alpine

# Instalar OpenSSL requerido por Prisma
RUN apk add --no-cache openssl

WORKDIR /app

# Copiar archivos de dependencias primero para optimizar caché
COPY package*.json ./
RUN npm install

# Copiar el resto del código fuente (incluyendo la carpeta prisma y sus migraciones)
COPY . .

# Generar el cliente de Prisma
RUN npx prisma generate

EXPOSE 3000

# Aplicar migraciones y arrancar la aplicación
CMD ["sh", "-c", "npx prisma migrate deploy && npm start"]