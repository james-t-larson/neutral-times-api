1. Fetch Current Prompt

GET /admin/prompts/current
- Description: Fetch the current active prompt.
- Response:
  {
    "id": 1,
    "content": "Current prompt text",
    "version": 5,
    "updatedAt": "2024-11-25T10:00:00Z",
    "metadata": { "tag": "active" }
  }

2. List All Versions

GET /admin/prompts/versions
- Description: Get a list of all prompt versions.
- Response:
  [
    { "id": 1, "version": 5, "content": "Current prompt text", "updatedAt": "2024-11-25T10:00:00Z" },
    { "id": 1, "version": 4, "content": "Previous prompt text", "updatedAt": "2024-11-20T10:00:00Z" }
  ]

3. Fetch a Specific Version

GET /admin/prompts/versions/{versionId}
- Description: Fetch a specific version of the prompt.
- Response:
  {
    "id": 1,
    "version": 4,
    "content": "Previous prompt text",
    "updatedAt": "2024-11-20T10:00:00Z"
  }

4. Restore a Version

POST /admin/prompts/restore
- Description: Restore a previous version as the active version.
- Body:
  { "version_id": 4 }
- Response:
  { "success": true, "currentVersion": 4 }

5. Get Differences Between Versions

GET /admin/prompts/diff
- Description: Get the differences between two versions of the prompt.
- Query Params: version1=4&version2=5
- Response:
  {
    "additions": ["Line 3: Added new sentence."],
    "deletions": ["Line 2: Removed old sentence."],
    "modifications": ["Line 1: Changed wording from 'old' to 'new'."]
  }

6. Create a New Version

POST /admin/prompts
- Description: Create a new version of the prompt and set it as active.
- Body:
  { "content": "New prompt text" }
- Response:
  {
    "id": 1,
    "version": 6,
    "content": "New prompt text",
    "updatedAt": "2024-11-25T11:00:00Z"
  }

7. Lock Prompt for Editing

POST /admin/prompts/lock
- Description: Lock the current prompt to prevent editing.
- Response:
  { "success": true, "lockedBy": "admin", "lockedAt": "2024-11-25T11:30:00Z" }

8. Sort prompt and versions by performance

GET /admin/prompts/sort/metrics
- Description: Sort all prompts by specified metrics such as sentiment, bias, factuality, and plagiarism.
- Query Params:
  - `metric`: (required) The metric to sort by. Options: "sentiment", "bias", "factuality", "plagiarism".
  - `order`: (optional) "asc" or "desc" (default: "desc").
- Response:
  [
    {
      "id": 1,
      "version": 5,
      "content": "Current prompt text",
      "updatedAt": "2024-11-25T10:00:00Z",
      "metrics": {
        "sentiment": 85,
        "bias": 90,
        "factuality": 92,
        "plagiarism": 98
      }
    },
    {
      "id": 1,
      "version": 4,
      "content": "Previous prompt text",
      "updatedAt": "2024-11-20T10:00:00Z",
      "metrics": {
        "sentiment": 78,
        "bias": 82,
        "factuality": 88,
        "plagiarism": 95
      }
    }
  ]
