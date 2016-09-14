# Build

Builds the Docker image `frostbitelabs/tensorflow-base`,

    docker build -t frostbitelabs/tensorflow-base .

or without cache,

    docker build -t frostbitelabs/tensorflow-base --no-cache .

# Push

    docker login
    docker push frostbitelabs/tensorflow-base
