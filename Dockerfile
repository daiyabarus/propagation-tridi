# Use a Miniconda3 image with Python 3.10
FROM continuumio/miniconda3:latest

# Set the working directory inside the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Create a new Conda environment with Python 3.10
RUN conda create -n myenv python=3.10 -y

# Make RUN commands use the new environment:
SHELL ["conda", "run", "-n", "myenv", "/bin/bash", "-c"]

# Install Conda packages
RUN conda install -c conda-forge \
    clawpack \
    matplotlib \
    pyvista \
    pandas \
    numpy \
    rasterio \
    gdal \
    -y

# Install pip packages
RUN pip install streamlit stpyvista

# Make sure the environment is activated:
RUN echo "conda activate myenv" >> ~/.bashrc

# Set the default shell to bash
SHELL ["/bin/bash", "--login", "-c"]

# Default command to run the Streamlit app
CMD ["conda", "run", "--no-capture-output", "-n", "myenv", "streamlit", "run", "main.py"]
