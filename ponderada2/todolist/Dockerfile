# # Use a imagem base oficial do Flutter que suporte Dart SDK 3.0.5+
# FROM dart:stable

# # Atualizar a lista de pacotes e instalar unzip
# RUN apt-get update && apt-get install -y unzip

# # Crie um novo usuário não-root
# RUN useradd -ms /bin/bash flutteruser

# # Definir o diretório de trabalho
# WORKDIR /app

# # Copiar o código da aplicação para o contêiner
# COPY . .

# # Mudar a propriedade dos arquivos para o novo usuário
# RUN chown -R flutteruser: /app

# # Adicionar diretório seguro ao Git
# RUN git config --global --add safe.directory /sdks/flutter

# # Mudar para o novo usuário
# USER flutteruser

# # Instalar dependências do Flutter
# RUN sudo flutter pub get

# # Expor a porta do servidor web
# EXPOSE 8001

# # Comando para iniciar o servidor Flutter
# CMD ["flutter", "run", "-d", "web-server", "--web-port", "8080"]

# Use an official Dart runtime as a parent image
FROM dart:stable

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container
COPY . .

# Install Flutter
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
ENV PATH "$PATH:/usr/local/flutter/bin"

# Switch to the stable channel
RUN flutter channel stable

# Upgrade Flutter to the latest version
RUN flutter upgrade

# Enable web support
RUN flutter config --enable-web

# Get Flutter dependencies
RUN flutter pub get

# Expose the server port
EXPOSE 8080

# Command to start the Flutter server
CMD ["flutter", "run", "-d", "web-server", "--web-port", "5000"]