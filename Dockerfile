FROM jupyter/base-notebook

# Install git
USER root
RUN apt-get update && apt-get install -y git

# Install JupyterLab
RUN pip install jupyterlab

# Install additional Python packages
RUN pip install telebot flask

# Clone the GitHub repository
RUN git clone https://github.com/bhaisja/api22.git

# Set working directory
WORKDIR /home/jovyan/api22

# Make scripts executable
RUN chmod +x *

# Expose the default port for JupyterLab
EXPOSE 8888

# Start JupyterLab without authentication, run the Python script, and add an infinite loop
CMD ["sh", "-c", "jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.token='' & python m.py; tail -f /dev/null"]
