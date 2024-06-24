# Use a base image with Python
FROM python:3.9-slim

# Install git and update system packages
RUN apt-get update && apt-get install -y git curl

# Download and install ngrok
RUN curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | tee /etc/apt/trusted.gpg.d/ngrok.asc > /dev/null && \
    echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | tee /etc/apt/sources.list.d/ngrok.list && \
    apt-get update && apt-get install ngrok

# Install additional Python packages
RUN pip install --no-cache-dir uvicorn fastapi telebot flask psutil

# Clone the GitHub repository
RUN git clone https://github.com/bhaisja/api.git /app

# Set working directory
WORKDIR /app

# Make scripts executable (assuming you have scripts that need execution permission)
RUN chmod +x *

# Expose the default port for your application (assuming you use port 8000 for uvicorn)
EXPOSE 8000

# Set the ngrok authtoken as an environment variable
ENV NGROK_AUTHTOKEN 2iKG0Yybexjrqw9Dm5KzWF9LwnN_4igiDYPPgJqYaVWDQoYv7

# Run the ngrok authtoken command and start the application using a shell script to run both ngrok and uvicorn
CMD ngrok authtoken $NGROK_AUTHTOKEN && python3 api.py
