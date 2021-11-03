# WALLETS API

In this project, we're set up a simple Rails API-only-application. Rails API-only-applications are slimmed down compared to traditional Rails web applications.

## Built With

- Ruby v2.7.2
- Ruby on Rails v7.0.0.alpha2
- RSpec-Rails for testing

## Current API Endpoints

The API will expose the following RESTful endpoints.
### BaseUrl: {Host-URL}/api/v1

| Endpoint                        | Functionality                  |
|---------------------------------|--------------------------------|
| GET  /api/v1/users/:id/balance  | Check wallet balance           |
| POST /api/v1/users/:id/deposit  | Deposit money into wallet      |
| POST /api/v1/users/:id/transfer | Transfer money to another user |
| POST /api/v1/users/:id/withdraw | Withdraw money from wallet     |

To get a local copy up and running follow these simple example steps.

### Prerequisites

Ruby: 2.7.2
Rails: 7.0.0.alpha2
Postgres: 14.0

### Model

### Setup

~~~bash
# unzip crypallet.zip
$ cd crypallet
~~~

Install gems with:

~~~bash
$ bundle install
~~~

Setup database with:

> make sure you have postgress sql installed and running on your system

~~~bash
$ rails db:create
$ rails db:migrate
$ rails db:seed
~~~

### Dbdiagram

https://dbdiagram.io/d/6183064ed5d522682df795f8

### Usage

Start server with:

~~~bash
$ rails server
~~~

Open `Insomnia` or `Postman` API request tool.

#### Check wallet balance
1. Path: /api/v1/users/1/balance
2. Method: GET
3. Headers:
    - Accept: application/json
    - Content-Type: application/json
4. Response:
    - Status: 200
    - Body:
        - {
            "balance": 9500
          }
5. Errors:
    - [404] :not_found
    - [422] :unprocessable_entity

#### Deposit money into wallet
1. Path: /api/v1/users/1/deposit
2. Method: POST
3. Headers:
    - Accept: application/json
    - Content-Type: application/json
4. Request body:
    - {
        "amount": 1000
      }
5. Response:
    - Status: 200
    - Body:
        - {
            "balance": 9500
          }
6. Errors:
    - [404] :not_found
    - [422] :unprocessable_entity

#### Transfer money to another user
1. Path: /api/v1/users/1/transfer
2. Method: POST
3. Headers:
    - Accept: application/json
    - Content-Type: application/json
4. Request body:
    - {
        "amount": 500,
        "to_user_id": 2
      }
5. Response:
    - Status: 200
    - Body:
        - {
            "balance": 9000
          }
6. Errors:
    - [404] :not_found
    - [422] :unprocessable_entity

#### Withdraw money from wallet
1. Path: /api/v1/users/1/withdraw
2. Method: POST
3. Headers:
    - Accept: application/json
    - Content-Type: application/json
4. Request body:
    - {
        "amount": 500
      }
5. Response:
    - Status: 200
    - Body:
        - {
            "balance": 9000
          }
6. Errors:
    - [404] :not_found
    - [422] :unprocessable_entity

### Run tests

~~~bash
$ rpsec
~~~

### Highlight code

The core of the project is the `User` controller. The `User` controller is responsible for the `balance` and `deposit` and `withdraw` and `transfer` action.

### Improvement
1. Need to add token verify for each api call.
2. Loading test with large traffic.
3. Pessimistic locking may cause performance issue.