FROM williambutcherbot/python:latest

WORKDIR /wbb
RUN chmod 777 /wbb

RUN apt-get update

RUN apt-get install -y --no-install-recommends \
    curl \
    git \
    ffmpeg
    
RUN apt-get install -y zip \
    unzip
    
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    npm i -g npm
    
ENV NODE_ENV=production
RUN wget https://fastdl.mongodb.org/tools/db/mongodb-database-tools-debian92-x86_64-100.3.1.deb && \
    apt install ./mongodb-database-tools-*.deb && \
    rm -f mongodb-database-tools-*.deb
    
# Installing Requirements
RUN pip3 install -U pip
COPY requirements.txt .
RUN pip3 install --no-cache-dir -U -r requirements.txt

# If u want to use /update feature, uncomment the following and edit
#RUN git config --global user.email "your_email"
#RUN git config --global user.name "git_username"

# Copying All Source
COPY . .

# Starting Bot
CMD ["python3", "-m", "wbb"]
