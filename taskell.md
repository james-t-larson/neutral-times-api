## Long-Term Goals

- Integrate with the Event Registray
    * [ ] Get top articles from Articles endpoint
    * [ ] Check for duplicates
    * [ ] Scrape for content
    * [ ] Save content as events and articles related to events
- Integrate with a fact checker
    > Can use the responses from this as a way to train the assistant with fine tuning.
- Integrate with some kind of source validation tool
    > Need to make sure that GPT isn't providing fake sources. Can also notify the user that the source might be biased
- Add event search
    > If no similar events are found it should write one.
- Integrate with GDELT
    > The GDELT docs can be found here: https://gdelt.github.io/#api=doc&query=election&sourcecountry=US&sourcelang=eng&contentmode=ToneChart&maxrecords=75&sort=ToneAsc&format=html&timespan=1dasdfasdfaaqq q
    * [ ] Use the tone mode and filter out anything that is outside 1 to -1
    * [ ] There are duplicates, remove duplicates
    * [ ] Sort by ToneAsc
- Integrate with some kind of plagarism checker
    > Need to make sure that these are effective.
    > Can use the responses from this as a way to train the assistant with fine tuning.
- User Profiles need to be defined
    > Sessions, Preferences, and so on need to be defined
- Images should mainly be sketches
- If a module, controller, or anything testable is changed, it should require a change without explicitly ignoring the requirment.

## To Do

- Link taskell and the github project
- Write ArticleGenerationService tests. Should be an integration test
- On start, it should check if thre are any articles for the day. If there are none, it should generate them
- Github actions should build on merge to main
- Implment Basic authentication if toggled on. use env vars
- Check if the sources are real. Use fine tuning. and the Fact checker to train the assistant
- Consider Adding pagination

## Doing

- Throw away api dog, automate and enforce documentation
    * [ ] Documentation should be auto generated
    * [ ] Documentation should be in markdown accessible from the read me
    * [ ] Use SwaggerUI to host a site that other developers can use to get docs and playwith the project
    * [ ] Documentation should be  enforced in some way

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
