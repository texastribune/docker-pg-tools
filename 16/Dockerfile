FROM --platform=linux/amd64 postgres:16

WORKDIR /app
COPY backup_to_s3.sh restore_from_s3.sh  .
RUN chmod +x backup_to_s3.sh restore_from_s3.sh
RUN apt-get update
RUN apt-get install curl unzip -y
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.15.22.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install