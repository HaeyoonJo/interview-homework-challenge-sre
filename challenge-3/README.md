# Challenge 3: Dockerize HTTP Server

The `challenge-3` is to perform dockerization of a HTTP server in `server.py`. Simply, we create a `Dockerfile` to build a Docker image then run the container locally to test the HTTP server. After that, we push the image to Docker Hub.

Let me walk you through the steps to achieve this:
1. Create a `Dockerfile` in the `challenge-3` directory.
2. Build the image and run the container for testing.
3. Push the image to a public Docker Hub.
4. Test the server request with `GET` with/without the required header.
5. Result.
6. Clean up.

## 1. Create a `Dockerfile`
As a reference, you can find the dockerfile content in the [`Dockerfile`](./Dockerfile) file and here is the content of the `Dockerfile`:
- For the best practice, as you can see I merged the `RUN` commands to reduce the number of layers in the image and also added a non-root user to run the server for better security.
```dockerfile
FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

COPY server.py .

RUN groupadd -g 1234 customgroup && \
    useradd -m -u 1234 -g customgroup customuser

USER customuser

EXPOSE 8080

CMD ["python3", "server.py"]
```

## 2. Build an image and run the container
1. Build the Docker image
- We build the image with the image as `challenge-3:0.1` in `name:tag` format. This image name and tag will be used only for local testing purpose and then tag the image to be `orcahaeyoon/sre-interview-homwork` as the production image with `challenge-3` tag. The container is `challenge-3-http-server` for this example.

For immutability, I set the image names, tags and container name as environment variables to avoid hardcoding them in the commands.

```bash
cd challenge-3/
challenge_image="challenge-3"
challenge_image_tag="0.1"
prod_image="orcahaeyoon/sre-interview-homwork"
prod_image_tag="challenge-3"
container_name="challenge-3-http-server"
# building the image
docker build -t $challenge_image:$challenge_image_tag .
```

2. Run the Docker container
- we use very simple command to run the container with the image we just built.
- flag:
    - `-d`: run the container in background.
    - `-p 8080:8080`: map port 8080 of the container to port 8080 on the host machine, so we can access the server from our local machine.
```bash
docker run -d -p 8080:8080 --name $container_name $challenge_image:$challenge_image_tag
```

3. Test the server 
- With the required header
```bash
curl -H "Challenge: orcrist.org" http://localhost:8080
```
Output: Everything works!

- Also, let me give a try without header to see the difference.
```bash
curl http://localhost:8080
```
Output: Wrong header!

## 4. docker hub push
```bash
docker tag $challenge_image:$challenge_image_tag $prod_image:$prod_image_tag
docker push $prod_image:$prod_image_tag
```

### 5. Result
- When we make a `GET` request to the server with the header `Challenge: orcrist.org`, the server will return:
```
# curl -H "Challenge: orcrist.org" http://localhost:8080
Everything works!
```

### 6. Clean up
- Lets stop and remove the container after testing to free up resources. You can use the following commands:
```bash
docker stop $container_name
docker rm $container_name
docker rmi $challenge_image:$challenge_image_tag
```