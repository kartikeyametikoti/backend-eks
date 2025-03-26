# FROM ubuntu:latest
# # the reason for selecting ubuntu instead  amazon linux is installation of mysql-client and mysql-server leads to get the repos from outside there will be no any inbuilt repos for mysql here we need aws-cli besides mysql-client and mysql-server that's why we are installing aws-cli for aws s3 cp command
# USER root

# # Update package manager and install dependencies
# RUN apt-get update && \
#     apt-get install -y unzip curl && \
#     apt-get clean
# RUN apt-get install -y  mysql-server
# # Install AWS CLI
# RUN curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
#     unzip awscliv2.zip && \
#     ./aws/install && \
#     rm -rf aws awscliv2.zip

# # Verify AWS CLI installation
# RUN aws --version

# # Set working directory
# WORKDIR /backup

# # Copy the backup script into the container
# COPY backup.sh /backup/backup.sh

# # Give execute permissions
# RUN chmod +x backup.sh

# # Run the backup script on startup and keep the container running
# # actually /dev/null is like a blackhole what ever the data comes to that file it arises it 
# # but tail -f <file name> waits for the data but the will never be there because of /dev/null so the tail command comtinuosly waits and the container will be also running continuosly.
# # if we don't use this "tail -f /dev/null" after completion of a running backup.sh it will terminate it makes the container down as well as pod also
# CMD ["sh", "-c", "./backup.sh && tail -f /dev/null"]
FROM ubuntu:latest
# the reason for selecting ubuntu instead  amazon linux is installation of mysql-client and mysql-server leads to get the repos from outside there will be no any inbuilt repos for mysql here we need aws-cli besides mysql-client and mysql-server that's why we are installing aws-cli for aws s3 cp command
USER root

# Update package manager and install dependencies
RUN apt-get update && \
    apt-get install -y unzip curl && \
    apt-get clean
RUN apt-get install -y  mysql-server
# Install AWS CLI
RUN curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf aws awscliv2.zip

# Verify AWS CLI installation
RUN aws --version

# Set working directory
WORKDIR /backup

# Copy the backup script into the container
COPY backup.sh .

# Give execute permissions
RUN chmod +x backup.sh

# Run the backup script on startup and keep the container running
# actually /dev/null is like a blackhole what ever the data comes to that file it arises it 
# but tail -f <file name> waits for the data but the will never be there because of /dev/null so the tail command comtinuosly waits and the container will be also running continuosly.
# if we don't use this "tail -f /dev/null" after completion of a running backup.sh it will terminate it makes the container down as well as pod also
CMD ["bash", "-c", "service mysql start && /backup/backup.sh && tail -f /dev/null"]
