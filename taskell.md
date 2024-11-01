## To Do

- Should generate articles at noon and midnight
- Add something so that it get politcial news in the news api integration
- Write tests for generation service
- Update api dog
- Create Feature Spec, use github docs.
- Github actions should build on merge to main
- Update README with postgres start info
- Write down some kind of roadmap.
- Link taskell and the github project
- Implment Basic authentication if toggled on. use env vars
- Integrate with GDELT
    > The GDELT docs can be found here: https://blog.gdeltproject.org/gdelt-doc-2-0-api-debuts/Thjq
- Integrate with a fact checker
    > Can use the responses from this as a way to train the assistant with fine tuning.
- Integrate with some kind of plagarism checker
    > Need to make sure that these are effective.
    > Can use the responses from this as a way to train the assistant with fine tuning.
- Check if the sources are real. Use fine tuning. and the Fact checker to train the assistant
- The default route is broken

## Doing


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
