set -ex

USERNAME=jzaremba
BASE_IMAGE=texlive_base
IMAGE=texlive

docker build --network host -t $USERNAME/$BASE_IMAGE:latest -f Dockerfile.base .
docker build --network host -t $USERNAME/$IMAGE:latest -f Dockerfile.user .
