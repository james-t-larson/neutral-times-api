1. Fetch All Categories

GET /categories

	•	Description: Retrieve a list of all available categories.
	•	Response:

[
  { "id": 1, "name": "Politics", "slug": "politics" },
  { "id": 2, "name": "Sports", "slug": "sports" },
  { "id": 3, "name": "Technology", "slug": "technology" },
  { "id": 4, "name": "Health", "slug": "health" },
  { "id": 5, "name": "Entertainment", "slug": "entertainment" }
]



2. Fetch a Single Category

GET /categories/{id}

	•	Description: Retrieve details of a specific category by its ID.
	•	Response:

{
  "id": 3,
  "name": "Technology",
  "slug": "technology",
  "description": "All about tech news and updates."
}

Admin Endpoints

These endpoints are restricted to administrative users and require appropriate authentication. They allow for creating, updating, deleting, and retrieving categories.

3. Fetch All Categories (Admin)

GET /admin/categories

	•	Description: Retrieve a list of all categories, including additional administrative details.
	•	Response:

[
  {
    "id": 1,
    "name": "Politics",
    "slug": "politics",
    "description": "Political news and updates.",
    "createdAt": "2024-01-15T10:00:00Z",
    "updatedAt": "2024-11-20T12:00:00Z"
  },
  {
    "id": 2,
    "name": "Sports",
    "slug": "sports",
    "description": "Latest sports news.",
    "createdAt": "2024-02-10T11:30:00Z",
    "updatedAt": "2024-11-18T09:45:00Z"
  }
  // Additional categories...
]



4. Fetch a Single Category (Admin)

GET /admin/categories/{id}

	•	Description: Retrieve detailed information of a specific category by its ID, including administrative metadata.
	•	Response:

{
  "id": 3,
  "name": "Technology",
  "slug": "technology",
  "description": "All about tech news and updates.",
  "createdAt": "2024-03-05T14:20:00Z",
  "updatedAt": "2024-11-22T16:10:00Z"
}



5. Create a New Category

POST /admin/categories

	•	Description: Add a new category to the news site.
	•	Request Body:

{
  "name": "Science",
  "slug": "science",
  "description": "Articles and updates related to science."
}


	•	Response:

{
  "id": 6,
  "name": "Science",
  "slug": "science",
  "description": "Articles and updates related to science.",
  "createdAt": "2024-11-25T08:30:00Z",
  "updatedAt": "2024-11-25T08:30:00Z"
}



6. Update an Existing Category

PUT /admin/categories/{id}

	•	Description: Update the details of an existing category.
	•	Request Body:

{
  "name": "World News",
  "slug": "world-news",
  "description": "Global news and international updates."
}


	•	Response:

{
  "id": 1,
  "name": "World News",
  "slug": "world-news",
  "description": "Global news and international updates.",
  "createdAt": "2024-01-15T10:00:00Z",
  "updatedAt": "2024-11-25T09:00:00Z"
}



7. Delete a Category

DELETE /admin/categories/{id}

	•	Description: Remove a category from the news site.
	•	Response:

{ "success": true }

Notes:

	•	Authentication: Admin endpoints (/admin/*) should be protected with appropriate authentication mechanisms to prevent unauthorized access.
	•	Data Consistency: Ensure that deleting a category does not orphan related articles. Implement cascading deletes or reassign articles to a default category as needed.
	•	Field Descriptions:
	•	id: Unique identifier for the category.
	•	name: Human-readable name of the category.
	•	slug: URL-friendly version of the category name, typically lowercase with words separated by hyphens.
	•	description: A brief explanation of the category’s content.
	•	createdAt: Timestamp indicating when the category was created.
	•	updatedAt: Timestamp indicating the last time the category was updated.

This structured approach ensures a clear separation between public and administrative functionalities, maintaining both security and usability.
