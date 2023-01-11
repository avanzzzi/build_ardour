#!/bin/bash

docker build . -t build_ardour
docker run -it --mount type=bind,source="$(pwd)/target",target=/src/target build_ardour
