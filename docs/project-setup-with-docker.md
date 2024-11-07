### Project Setup with Docker

#### Prerequisites
1. **Docker** and **Docker Compose** must be installed on your system.
2. Generate SSL certificates in `config/certs/`:
   ```bash
   openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout config/certs/server.key -out config/certs/server.crt
   ```
3. **Set Permissions** for SSL files to ensure accessibility:
   ```bash
   chmod -R 644 config/certs/
   ```

#### First-Time Setup

1. **Build and Start Containers**:
   ```bash
   sudo docker-compose up --build
   ```

2. **Access the App**:
   - Rails app runs at: `https://localhost:3000` (SSL-enabled).

3. **Running Rails Commands**:
   For Rails commands, use:
   ```bash
   sudo docker-compose run app <command>
   ```
   Example:
   ```bash
   sudo docker-compose run app rails db:seed
   ```

4. **Start the App Container in Background**:
   To start a single app container in the background:
   ```bash
   sudo docker run -d neutral-news-gen_app
   ```

5. **Check All Containers (Running and Stopped)**:
   Use the `-a` flag with `docker ps` to list all containers:
   ```bash
   sudo docker ps -a
   ```

#### Testing That the App is Running
After starting the container, you can confirm it’s up and running by:

1. **Checking Running Containers**:
   ```bash
   sudo docker ps
   ```
   Ensure the app container is listed as `Up`.

2. **Testing the URL**:
   Open your browser and navigate to `https://localhost:3000`. If it loads successfully, the app is running.

3. **Using Curl for a Quick Check** (if you don't want to open a browser):
   ```bash
   curl -k https://localhost:3000
   ```
   This should return HTML content if the app is up.

#### Stopping the Containers
To stop the containers:
```bash
sudo docker-compose down
```

#### Cleaning Docker Environment
To stop and remove all exited containers:
```bash
sudo docker rm $(sudo docker ps -aq)
```

Use `bin/docker-clean-up` to stop, remove, and reset Docker images, volumes, and cache.

#### Additional Details
- **Database Setup**: The `docker-entrypoint.sh` script automatically configures the database (creates and loads the schema) on first run.

- **Cleaning Docker Environment**:
   Use `bin/docker-clean-up` to stop, remove, and reset Docker images, volumes, and cache.

