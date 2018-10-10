### Create API server
- [x] Write a barebones go-chi server
- [x] Get server to read in local json files
- [~] Figure out how interfaces work in Go
- [~] Create routes from config file
- [ ] Write a generic webhook interface
- [ ] Implement an interface in the github plugin

### Get API server doing CI things
- [~] These items are going to come out of "Design CI things"

### Dogfood Pierogi
- [ ] Set this up on my server
- [ ] Configure github webhook for pierogi repo to send information to pierogi
- [ ] Set pierogi up to properly ingest github webhook and run the git pull go script from 1.b

### Set pierogi up for my website
- [ ] Write go script that will deploy my jekyll website
- [ ] Hook above script up to github webhook from 2.b

---

# Extras
- pull request event handling

### Output Configuration
- [ ] Set up callback to github to report job status when build is triggered
