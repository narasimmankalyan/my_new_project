# Use Python 3.9-slim as the base image
FROM python:3.9-slim

# Install dependencies (add ODBC if needed)
RUN apt-get update && apt-get install -y curl

# Set working directory
WORKDIR /app

# Copy and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . .

# Expose port for Flask/Gunicorn
EXPOSE 5000

# Run using Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "3", "main:app"]
