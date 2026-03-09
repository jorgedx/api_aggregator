# Rails API Aggregator

## Overview

This application provides a single REST API endpoint that aggregates data from two external DummyJSON endpoints, applies custom business logic, persists the processed results, and returns a structured JSON response. Implementing a wrapper class for the DummyJson service.

## System Requirements

    * Ruby: 3.4.8
    * Rails: 7.2.2.2
    * PostgreSQL: 16.13 

## Setup

Clone the repository and enter the folder
```bash
git clone https://github.com/jorgedx/api_aggregator.git
cd api_aggregator
```

Install dependencies, create and migrate the database
```bash
bundle install
rails db:create db:migrate
```

Run the server
```bash
rails server
```

The API is now available: http://localhost:3000.


## How to use
The endpoint expects a user ID as unique parameter, This ids are availables 1, 2, 3, 4, 5, 6, 7, 8
```bash
GET /user_status/:id   -  
```
Example with curl
```bash
curl -i http://localhost:3000/user_status/1
```

Example success response
```json
{
    "id":1,
    "full_name":"Ava Taylor",
    "experience":"Rookie",
    "pending_task_count":1,
    "next_urgent_task":"Take a scenic horseback riding tour"
}
```

* id (int): Internal id.
* full_name (string): firstName and lastName combined.
* experience (string): "Veteran" If age > 50, otherwise "Rookie".
* pending_task_count (int): The total count of incomplete tasks.
* next_urgent_task (string): Title of the first incomplete task (an empty string if nothing exist).

## Tests
Running Rspec tests by executing this command
```bash
bundle exec rspec spec/
```
