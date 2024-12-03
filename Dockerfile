# Use Node.js 18 with Debian Bullseye as the base image
FROM node:18-bullseye

# Set the working directory inside the container
WORKDIR /app

# Install Angular CLI globally
RUN npm install -g @angular/cli@15.0.3

# Copy the package.json and package-lock.json first (for npm install)
COPY wsu-hw-ng-main/package*.json ./

# Install the dependencies from package.json
RUN npm install

# Copy the rest of the Angular application code into the container
COPY wsu-hw-ng-main/ .

# Expose port 4200 (default port for Angular applications)
EXPOSE 4200

# Command to run the Angular app, making it accessible from any IP
CMD ["ng", "serve", "--host", "0.0.0.0"]
