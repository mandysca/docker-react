# Production build 

# Phase #1 - Create a build file 

# Create from image alpine - with phase name "builder". The output of this
# phase is build directory 
FROM node:16-alpine as builder 

# Set working directory 
WORKDIR '/app'

# Copy the package.json that has the information on dependencies 
# to the working directory 
COPY ./package.json ./ 

# Run install command to get the dependencies 
RUN npm install 

# Copy rest of the files into docker 
COPY ./ ./ 

RUN npm run build 

# /app/build <- will have the output of this phase 

# Phase 2 - Create a production version 
# terminates the previous block 

FROM nginx

# Copy from phase = builder 
# nginx documentation for static HTML content 
# only copy the bare minimum from the image 

COPY --from=builder /app/build /usr/share/nginx/html 

# Default command of nginx starts the nginx server 

# At terminal 
# To build cd to working directory 
# docker build .
# get the => image id 
# Then to run the image (map to default port 80 of nginx)
# docker run -p 8080:80 IMAGE_ID