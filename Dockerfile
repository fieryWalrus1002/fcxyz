FROM ubuntu:latest AS py3dox-dev

WORKDIR /app

RUN apt-get update \
    && apt-get install -y \
    git \
    python3-dev \
    python3-pip

COPY ./requirements.txt ./requirements.txt

RUN pip3 install -r requirements.txt

# Later, for making the final image where the app is installed and run
# COPY . .
# CMD ["python3", "main.py"]