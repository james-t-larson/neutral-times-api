## Long-Term Goals

- Integrate with a fact checker
    > Can use the responses from this as a way to train the assistant with fine tuning.
    * [ ] Learn about different fact checkers that I can integrate with
- Integrate with some kind of plagarism checker
    > Need to make sure that these are effective.
    > Can use the responses from this as a way to train the assistant with fine tuning.
- Implement Custom Categories
    > Custom Categories should be something before new categories suggestions 
- There needs to be able to mark a certain article as bad, and maybe a  check list for how?
- Integrate with Mozilla TTS
    > I would like the news read to me. Check out Mozilla TTS and see if it's good enough for this
- User Profiles need to be defined
    > Sessions are needed for invites, no need for preferences for mvp
- Add event search
    > If no similar events are found it should write one.
- Use Git integration with SimpleCov to ensure that any change has tests written
    > simplecov-icov has a tool that can check tests for only changed files. this should ensure nearly 100% test coverage and catch anything that isn't tested
- Switch to an open source LLM
- Images should mainly be sketches
- Integrate with a citation machine for sources
    > There is a gem called citeproc-ruby that might work. This would be good for getting all the articles around a specific event and putting them into sources for the article
- Add Morning Brief
    > This could be done with integrating with weather and traffic apis. Then write a summary on that. I could also include an estimated time to work. If there is a difference outside the norm, then it could notify me. 
- Add Gem for readibility
    > Can be used to guage the performance of a prompt
- Add Gem for semetality
    > Can be used for tracking the performance of a prompt

## To Do

- Implment category filter to articles endpoint
    > The user should be able to request business or political articles. 
    * [ ] Should write 10 political and 10 business related articles
- Implement Prompt Versioning
    * [ ] Move Prompt into DB
    * [ ] Add columns for sentiment, readibilty
    * [ ] If its easily detectably. Things like, "This article was written following certain guidlines"
- Link taskell and the github project
- Github actions should build on merge to main
    > Tests are run locally and in develop before merge to main 
- Add Lazydocker to nvim
- Prod should not be using seed data
- Update swagger so that it points at the correct domain depending on the env
    * [ ] Need to get around basic auth in dev somehow
    * [ ] 
- Complete Tests for OpenAi Service
- Complete Tests for Event Registry
- Complete Tests for Generation Service
- Get Lazydocker working in AWS instance. Can't even get into rails c without googling
- Move prompt to database
- Persist database as a volume in the docker-compose file.
    > This is the reason that the database is lost when docker-compose down is run

## Doing

- Prompt should be changed to reduce emotional language.
    * [ ] The current prompt have content that makes it easy to detect as an ai. 
    * [ ] The old prompt is to complex. Reduce complexity

## Done

- Get taskell working in nvim
    > https://github.com/romariorobby/taskell.nvim
    * [x] Get plugin installed
    * [x] Configure key mapping
- Update README with docker info
- Learn to send prompts to gpt from the api
- Invite Jo to the project when README is updated
- Integrate with openai, generate articles
    > Need to switch to the assitant that I created. Exmaples can be found here: https://github.com/alexrudall/ruby-openai?tab=readme-ov-file#assistants
- Move news api, api key into credentials.yml
- Change main branch to develop so that dependa bot creates PR's for it
- Change system info for generation service
- Change Story to article everywhere
- Get gpt content generated correctly
- Should generate articles from GPT and store them in the DB
    * [x] Add validations for all columns
    * [x] Make sure that sources is in the endpoint
    * [x] Add sources to the tests
    * [x] Remove published at from the tests
- Write tests for open ai generation service
- Should generate articles at noon and midnight
- Make sure that news api tests still work
- Add something so that it get politcial news in the news api integration
- Should write 5 articles
- Update README with postgres start info
- Write down some kind of roadmap.
- Write tests for the Article model
- Create Feature Spec, use github docs?
- Add date range incase there is a problem with generation development will not be stalled
    * [x] Update tests, switch defualt scope to published_today
    * [x] Should be able to get todays articles with no params on the main route.
    * [x] Should be able to get any days articles when param is passed
    * [x] When requesting a specific article should no be limited todays articles
    * [x] Should throw error if iso8601  is not used
- The default route is broken
- Throw away api dog, automate and enforce documentation
    * [x] Documentation should be auto generated, use rswag
    * [x] Use SwaggerUI to host a site that other developers can use to get docs and playwith the project
    * [x] Documentation should be  enforced in some way, use git hooks
- On start, it should check if thre are any articles for the day. If there are none, it should generate them
- Complete tests for article and model controller
    * [ ] Complete edge case tests for model
    * [ ] 
- Enforce SSL in lightsail instance
- Implment Basic authentication if toggled on. use env vars
- Integrate with the Event Registray
    * [x] Get top articles from Articles endpoint
    * [x] Pass article content into chat gpt to rewrite
    * [x] Add api key to secrets
- Complete Tests for the Article Controller
    > There are features and things that are not tested
    * [ ] Should not be able to request articles for the future
