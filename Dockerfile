# Use the latest Python image from the official repository
FROM python:3.13-slim

# Set the working directory
WORKDIR /app

# Install dependencies on the OS level
RUN apt-get update && \
    apt-get install -y build-essential git autoconf wget bzip2

# Install Conda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p /opt/conda && \
    rm /tmp/miniconda.sh && \
    /opt/conda/bin/conda clean -af

# Update PATH environment variable for CONDA
ENV PATH=/opt/conda/bin:$PATH

# install dependencies for ANARCI
RUN conda install -c conda-forge biopython -y
RUN conda install -c bioconda hmmer=3.3.2 -y

# install ANARCI
RUN python setup.py install

# Create the fasta_files directory
RUN mkdir fasta_files

# Set the entrypoint
ENTRYPOINT ["sh", "-c", "tail -f /dev/null"]
