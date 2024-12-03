# Use Node.js 18 as the base image
FROM node:18-bullseye

# Set the working directory inside the container
WORKDIR /app

# Install Angular CLI globally
RUN npm install -g @angular/cli@15.0.3

# Copy the package.json and package-lock.json files from the wsu-hw-ng-main folder
COPY wsu-hw-ng-main/package*.json ./

# Install project dependencies
RUN npm install

# Copy the entire Angular project into the container
COPY wsu-hw-ng-main/ ./

# Expose port 4200 (default port for Angular)
EXPOSE 4200

# Start the Angular application
CMD ["ng", "serve", "--host", "0.0.0.0"]
