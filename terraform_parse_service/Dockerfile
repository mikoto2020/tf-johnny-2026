# Choose a smaller base image
FROM python:3.9-alpine

# Set working directory
WORKDIR /app

# Copy dependency files and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application
COPY . .

# exposed port
EXPOSE 5000

# Start command
CMD ["python", "app.py"]