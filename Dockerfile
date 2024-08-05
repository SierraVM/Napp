# Usa una imagen base oficial de Node.js
FROM node:14

# Argumentos para UID y GID
ARG UID=1000
ARG GID=1000

# Crear un directorio de trabajo
WORKDIR /usr/src/app

# Copiar los archivos necesarios primero para instalar dependencias
COPY package*.json ./

# Instalar dependencias como root para evitar problemas de permisos
RUN npm install

# Copiar el resto de los archivos de la aplicación
COPY . .

# Crear un grupo y usuario con UID y GID específicos si no existen
RUN if ! getent group ${GID} ; then groupadd -g ${GID} appgroup ; fi && \
    if ! id -u ${UID} >/dev/null 2>&1 ; then useradd -m -u ${UID} -g ${GID} appuser ; fi

# Cambiar la propiedad del directorio de trabajo al nuevo usuario
RUN chown -R ${UID}:${GID} /usr/src/app

# Cambiar a usuario no root
USER ${UID}

# Exponer el puerto de la aplicación
EXPOSE 80

# Comando para ejecutar la aplicación
CMD ["node", "NAPP.js"]


