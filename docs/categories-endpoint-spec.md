# Client Endpoints

## 1. Fetch All Categories

**GET** `/categories`

- **Description**: Retrieve a list of all available categories.
- **Response**:
  ```json
  [
    { "id": 1, "name": "Politics", "description": "Thing thing thing" },
    { "id": 2, "name": "Sports", "description": "Thing thing things" },
    { "id": 3, "name": "Technology", "description": "Thing thing thing" },
    { "id": 4, "name": "Health", "description": "Thing thing thing" },
    { "id": 5, "name": "Entertainment", "description": "Thing thing thing" }
  ]

## 2. Fetch a Single Category

**GET** `/categories/{id}`

- **Description**: Retrieve details of a specific category by its ID.
- **Response**:
  ```json
  {
    "id": 3,
    "name": "Technology",
    "slug": "technology",
    "description": "All about tech news and updates."
  }

## 3. Fetch articles for a specific category

**GET** `/categories/{id}/articles`

- **Description**: Retrieve all articles associated with a specific category by its ID.
- **Response**:
  ```json
  [
    {
      "id": 101,
      "title": "Tech Innovations of 2024",
      "author": "Jane Doe",
      "publishedAt": "2024-11-25T08:30:00Z"
    },
    {
      "id": 102,
      "title": "The Future of AI",
      "author": "John Smith",
      "publishedAt": "2024-11-26T09:00:00Z"
    }
  ]
  ```
---

# Admin Endpoints

*These endpoints are restricted to administrative users and require appropriate authentication. They allow for creating, updating, deleting, and retrieving categories.*

## 4. Create a New Category

**POST** `/admin/categories`

- **Description**: Add a new category to the news site.
- **Request Body**:
  ```json
  {
    "name": "Science",
    "description": "Articles and updates related to science."
  }

- **Response**:
  ```json
  {
    "id": 6,
    "name": "Science",
    "description": "Articles and updates related to science.",
    "createdAt": "2024-11-25T08:30:00Z",
    "updatedAt": "2024-11-25T08:30:00Z"
  }

## 5. Update an Existing Category

**PUT** `/admin/categories/{id}`

- **Description**: Update the details of an existing category.
- **Request Body**:
  ```json
  {
    "name": "World News",
    "slug": "world-news",
    "description": "Global news and international updates."
  }

- **Response**:
  ```json
  {
    "id": 1,
    "name": "World News",
    "slug": "world-news",
    "description": "Global news and international updates.",
    "createdAt": "2024-01-15T10:00:00Z",
    "updatedAt": "2024-11-25T09:00:00Z"
  }

## 6. Delete a Category

**DELETE** `/admin/categories/{id}`

- **Description**: Remove a category from the news site.
- **Response**:
  ```json
  { "success": true }

