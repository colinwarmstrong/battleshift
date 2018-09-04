# README

---

_Battleshift_ is a project for Backend Module 3 at Turing School of Software and Design. The purpose of this project was to work on a legacy brown-field project, add functionality to it, and practice refactors and working with APIs in `Ruby on Rails`.

---

_Ruby Version 2.4.1_

_Rails Version 5.1.6_

### Setup

- Clone the repo.

- Run `rake db:{create,migrate,seed}` from the CLI.

- Each user must create an account to recieve a token. Visit `/` path to sign up; then, respond to the verification email.

- All API requests will need the user's API key in the headers:
  `X_API_KEY: {your api key}`

### Endpoints

- `POST /api/v1/games` Send your API key and the email addres of the player you'd like to start a game with. Both players must have accounts.
- `POST /api/v1/games/:game_id/ships` Places ships.
- `POST /api/v1/games/:game_id/shots` Send coordinates for your attack.


### Contact Info

Eliot Swank [GitHub](https://github.com/EMSwank)
Colin Armstrong [GitHub](https://github.com/colinwarmstrong)
