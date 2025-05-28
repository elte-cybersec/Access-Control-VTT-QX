FROM ubuntu:20.04
ENV TZ=Europe/Helsinki
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Set working directory
WORKDIR /home/proverif/

# Install dependencies
RUN apt-get clean && apt-get -y update && apt-get install -y \
    git \
    net-tools \
    iputils-ping \
    nano \
    g++ \
    make \
    cmake \
    tar \
    ocaml \
    ocaml-compiler-libs \
    ocaml-findlib \
    liblablgtk2-ocaml-dev \
    wget

# Download and install ProVerif
RUN wget https://bblanche.gitlabpages.inria.fr/proverif/proverif2.04.tar.gz && \
    tar -xf proverif2.04.tar.gz -C /home/proverif/ && \
    cd /home/proverif/proverif2.04/ && \
    ./build

# Clone the PPTM repository
RUN cd /home/proverif/proverif2.04 && git clone https://github.com/DominikRoy/PPTM.git

# Create a models directory for working with protocol models
RUN mkdir -p /home/proverif/models

# Set work directory to models for convenience
WORKDIR /home/proverif/models

# Add ProVerif to PATH
ENV PATH="/home/proverif/proverif2.04:${PATH}"

# Default command
CMD ["/bin/bash"]