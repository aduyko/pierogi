# Pierogi
A miniature CI/CD server written in Ruby

## Installation
- Clone this github repo (`git clone git@github.com:aduyko/pierogi.git`)
- Run `bundle install` to install gems
- More to come

## Tests
After installing, run `bundle exec rspec`

## Goals
Pierogi is meant to be a fast, stateless, lightweight CI/CD solution for small, self-hosted projects.

Both incoming job trigger api calls and outgoing logging/results output format and endpoints will be entirely configurable, allowing the user control over how they want to trigger their jobs, build their jobs, and how they want to output job results.

Unlike other self-hosted CI/CD/Job Runner systems, Pierogi is not meant to hold any persistent information about previous jobs, giving it a smaller footprint and not requiring a database.

Pierogi is meant to be used in conjunction with webhook-type services which will trigger Pierogi builds and which will be sent/contain the results of build information.

## Why
There don't seem to be many minimal CI/CD solutions - the problem Pierogi hopes to solve is providing a small service that runs scripts on a server in response to webhooks, allowing CI/CD builds to happen without much infrastructure/dependency overhead.

The theoretical use case is for running highly configurable tests, builds, and deployments when one or more projects are running on the same environment, which may be the case for hobbyists or small projects.
