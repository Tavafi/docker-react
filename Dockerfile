FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# We need to expose default port for production server (such as AWS), AWS will directly and automatically map a port to the exposed port in Dockerfile (here is 80)
# If we expose port on our local machine, our machine automatically do nothing and it will be ignored
# tip : without exposing a port, AWS will occur an error that Hey I can't launch and run the project you have already deployed 
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html