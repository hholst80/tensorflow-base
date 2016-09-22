# Build

Builds the Docker image `frostbitelabs/tensorflow-base`,

    docker build -t frostbitelabs/tensorflow-base .

or without cache,

    docker build -t frostbitelabs/tensorflow-base --no-cache .

# Push

    docker login
    docker push frostbitelabs/tensorflow-base

# Run VNC from container

    docker run -it --rm -p 5900:5900 frostbitelabs/tensorflow-base x11vnc -xdummy
