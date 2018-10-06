# Flow
1. Request sent to specific route on server
2. API recieves request at route
  - Route + Plugin handler defined in configs
  - Each route defines its plugin type
    - Routes are specific to plugins
? How should handlers be organized per route/plugin
  - should handlers be plugin specific? or standard?
    - standard more consistent

# Installation
- What's go's best practice
- Sensu install vs configure/plugin

# Configuration

## Routes
- One config + plugin handler per route
  - However, any number of rules for that plugin/route combo

## API Configuration
- Define what type of webhook we are expecting
- Define which plugin this webhook is using
- Define what script to run when webhook hits server

- Define language for configuration (yml, json)

# Plugins
- "Webhook" Interface used by all plugins
- Go Modules that define how the server should handle specific API requests
  - For example, for github, the plugin module would have a struct called "GithubWebhook"
  - This struct would define all of the useful components of the webhook
  - implement the webhook interface

---

# Return values? Output?
- Configurable
- Sample output types:
  - log file
  - database
  - webhook(?) (post build results to github or whatever)
