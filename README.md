[![](https://images.microbadger.com/badges/image/frostbitelabs/tensorflow-base.svg)](https://microbadger.com/images/frostbitelabs/tensorflow-base "Get your own image badge on microbadger.com")

# Build

Builds the Docker image `frostbitelabs/tensorflow-base`,

    docker build -t frostbitelabs/tensorflow-base .

or without cache,

    docker build -t frostbitelabs/tensorflow-base --no-cache .

# Push

    docker login
    docker push frostbitelabs/tensorflow-base

# Run Python notebook from container

    docker run -it --rm -p 8888:8888 frostbitelabs/tensorflow-base jupyter notebook

# Run VNC from container

    docker run -it --rm -p 5900:5900 frostbitelabs/tensorflow-base x11vnc -xdummy
