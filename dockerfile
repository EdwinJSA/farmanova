FROM node:18-alpine

# Instalar OpenSSL requerido por Prisma
RUN apk add --no-cache openssl

WORKDIR /app

# Copiar dependencias
COPY package*.json ./
RUN npm install

# Copiar el código fuente
COPY . .

# Generar el cliente de Prisma y compilar TypeScript (tsc)
RUN npx prisma generate
RUN npm run tsc

EXPOSE 3000

# Aplicar migraciones y arrancar el servidor compilado en dist/index.js (o la ruta donde compile tu tsconfig)
CMD ["sh", "-c", "npx prisma migrate deploy && node dist/index.js"]