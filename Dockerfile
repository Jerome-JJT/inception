# syntax=docker/dockerfile:1
FROM alpine
RUN apk add --no-cache python2 g++ make
# CMD ["node", "src/index.js"]

