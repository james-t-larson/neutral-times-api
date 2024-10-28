# Neutral News Gen

**Neutral News Gen** is an automated platform that uses AI (powered by GPT) to gather and generate unbiased news articles based on the latest events. The system queries online sources every 12 hours to create dynamic, neutral news stories.

## Features
- **AI-powered content generation**: Uses GPT to generate news articles from real-time event data.
- **Real-time updates**: Automatically fetches new information every 12 hours and generates new stories.
- **REST API**: Provides an API to query the stories and associated content.

## Table of Contents
- [Installation](#installation)
- [Project Setup with Docker](docs/project-setup-with-docker.md)
- [Configuration](#configuration)
- [API Endpoints](#api-endpoints)
- [Media Fairness and Balance Guidelines](docs/media-fairness-guidelines.md)

---

## Installation

1. **Clone the repository**:

    ```bash
    git clone https://github.com/yourusername/neutral-news-gen.git
    cd neutral-news-gen
    ```

2. **Install dependencies**:

    ```bash
    bundle install
    ```

3. **Set up the database**:

    Make sure you have PostgreSQL installed, then run:

    ```bash
    rails db:create
    rails db:migrate
    rails db:seed
    ```

4. **Set up environment variables**:

    You’ll need an OpenAI API key to power the GPT-based generation. Create a `.env` file:

    ```bash
    touch .env
    ```

    Add the following to your `.env` file:

    ```bash
    OPENAI_API_KEY=your-openai-api-key
    ```

5. **Start the Rails server**:

    ```bash
    rails server
    ```

---

## API Endpoints

### GET /stories

Fetch all stories, or filter by a specific `id`.

#### Request Parameters:
| Name    | Type   | Required | Description                   |
|---------|--------|----------|-------------------------------|
| `id`    | string | no       | Filter by specific story ID    |

#### Example Request:

```bash
GET /stories?id=1
```

#### Example Response:

```json
[
  {
    "id": 1,
    "title": "Breaking News: Ruby on Rails Rocks!",
    "summary": "A detailed article about how Ruby on Rails is a powerful web development framework.",
    "published_at": "2024-10-12T20:36:26.097Z",
    "content": [
      {
        "id": 1,
        "sub_title": "Introduction to Ruby on Rails",
        "text": "Ruby on Rails is a server-side web application framework..."
      }
    ]
  }
]
```

### Error Responses:
| Status Code | Message                      |
|-------------|------------------------------|
| 400         | "Invalid parameter 'id'."    |
| 404         | "Article not found."           |
| 500         | "An unexpected error occurred." |

For more details on API structure, refer to the API documentation in the project.


