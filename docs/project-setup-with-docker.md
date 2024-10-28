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

#### Stopping the Containers
To stop the containers:
```bash
sudo docker-compose down
```

#### Additional Details
- **Database Setup**: The `docker-entrypoint.sh` script automatically configures the database (creates and loads the schema) on first run.
- **Cleaning Docker Environment**:
   Use `bin/docker-clean-up` to stop, remove, and reset Docker images, volumes, and cache.

