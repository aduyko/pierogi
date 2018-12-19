### Create API server
- [x] Write a barebones roda server
- [x] Get server to run a local script
- [x] Get server to decode json payload
- [x] Get server to run a local script based on json payload
- [x] Get server to run a local script based on github json payload

### Handlers
- [x] Create handler super class
- [x] Create github handler and move github script execution logic in there
- [x] Create handlers based on config file routes

### Configuration
- [x] Create configuration file format / read it in
- [ ] Figure out a place for the default configuration file to live and use that
- [ ] Figure out how to manage secrets within this configuration file

### Routes
- [x] Get server to read in local json files
- [x] Create routes from config file

### Testing
- [ ] Add rspec tests

### Output Handling
- [ ] Set up helper functions for printing to stdout/response
- [ ] Set up logger helpers
- [ ] Set up helper functions for printing to log
- [ ] Set up output format for server repsonse(json)

### Dogfood Pierogi
- [ ] Set this up on my server
- [ ] Configure github webhook for pierogi repo to send information to pierogi
- [ ] Set pierogi up to properly ingest github webhook and run the git pull go script from 1.b

### Set pierogi up for my website
- [ ] Write script that will deploy my jekyll website
- [ ] Hook above script up to github webhook from 2.b

---

# Extras
- post content-type other than json
- pull request event handling

### Output Reporters
- [ ] Set up callback to github to report job status when build is triggered
