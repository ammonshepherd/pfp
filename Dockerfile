# Use Python version 3.9
FROM python:3.9-slim

# Set up an environment variable PORJECT_DIR is where the app lives in the
# container
ENV PROJECT_DIR /webapp

# Set the project dir as the working directory (like we 'cd' into that dir)
WORKDIR ${PROJECT_DIR}

# Copy all of the local files to the project directory
COPY ./webapp ${PROJECT_DIR}/

# Install all the dependencies
RUN pip install -r requirements.txt

# Run the application, on port 80
CMD ["flask", "run", "--host", "0.0.0.0", "--port", "80"]

