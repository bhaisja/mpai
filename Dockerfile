# Use a base image with Python
FROM python:3.9-slim

# Install git and update system packages
RUN apt-get update && apt-get install -y git

# Install additional Python packages
RUN pip install --no-cache-dir uvicorn fastapi telebot flask

# Clone the GitHub repository
RUN git clone https://github.com/bhaisja/api22.git /app

# Set working directory
WORKDIR /app

# Make scripts executable (assuming you have scripts that need execution permission)
RUN chmod +x *

# Expose the default port for your application (assuming you use port 8000 for uvicorn)
EXPOSE 8000

# Start the application using uvicorn
CMD ["uvicorn", "api:app", "--host", "0.0.0.0", "--port", "8000"]
