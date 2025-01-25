# Neutral Times API

**Neutral Times API** is an automated platform that uses AI (powered by GPT) to gather and generate unbiased news articles based on the latest events. The system queries online sources every 12 hours to create dynamic, neutral news stories.

---

## Features
- **AI-powered content generation**: Uses GPT to generate news articles from real-time event data.
- **Real-time updates**: Automatically fetches new information every 12 hours and generates new stories.
- **REST API**: Provides an API to query the stories and associated content.

---

## Table of Contents
- [Installation](#installation)
- [Project Setup with Docker](docs/project-setup-with-docker.md)
- [Configuration](#configuration)
- [API Endpoints](#api-endpoints)

---

## Additional Resources
- [MVP Feature Spec](docs/mvp-feature-spec.md)
- [Media Fairness and Balance Guidelines](docs/media-fairness-guidelines.md)
- [Upcoming Changes and Roadmap](taskell.md)

---

## Installation

1. **Clone the repository**:

    ```bash
    git clone https://github.com/yourusername/neutral-news-api.git
    cd neutral-news-api
    ```

2. **Install dependencies**:

    ```bash
    bundle install
    ```

3. **Set up PostgreSQL**:

    Make sure you have PostgreSQL installed. If not, you can install it on Manjaro with:

    ```bash
    sudo pacman -S postgresql 
    ```

    **Initialize the PostgreSQL Database** (if this is your first time setting it up):

    ```bash
    sudo -iu postgres initdb --locale=en_US.UTF-8 -D /var/lib/postgres/data
    ```

    **Start the PostgreSQL Service**:

    ```bash
    sudo systemctl start postgresql
    ```

    **Enable PostgreSQL to Start on Boot** (recommended):

    ```bash
    sudo systemctl enable postgresql
    ```

4. **Create the application database**:

    Run the following commands to set up the database:

    ```bash
    rails db:create
    rails db:migrate
    rails db:seed
    ```

5. **Set up secrets**:

    TODO

6. **Start the Rails server**:

    ```bash
    rails server
    ```
---

