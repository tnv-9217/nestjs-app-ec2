# Use the official Node.js image from the Docker Hub
FROM node:18.20.3

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY ./package.json ./

# Install NestJS dependencies
RUN npm install

# Copy the rest of your application code to the working directory
COPY . .

# Build your NestJS application (assuming it's already compiled to JavaScript)
RUN npm run build

# Expose the port your NestJS application runs on
EXPOSE 3010

# Command to run your application
CMD ["npm", "start"]
