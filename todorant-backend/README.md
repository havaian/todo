# [Todomaster](https://todomaster.com) backend code

## Installation and local launch

1. Clone this repo: `git clone https://github.com/backmeupplz/todomaster-backend`
2. Launch the [mongo database](https://www.mongodb.com/) locally
3. Create `.env` with the environment variables listed below
4. Add credentials to the `assets` folder
5. Run `yarn install` in the root folder
6. Run `yarn develop`

And you should be good to go! Feel free to fork and submit pull requests. Documentation is [also available](https://github.com/backmeupplz/todomaster-backend/tree/master/docs) in this repo.

## Environment variables

| Name                                     | Description                              |
| ---------------------------------------- | ---------------------------------------- |
| `MONGO`                                  | URL of the mongo database                |
| `JWT`                                    | secret for JWT                           |
| `FACEBOOK_APP_ID`, `FACEBOOK_APP_SECRET` | Facebook login credentials               |
| `TELEGRAM_LOGIN_TOKEN`                   | Telegram login bot                       |
| `WIT_LANGUAGES`                          | A map of language names to Wit.ai tokens |

Also, please, consider looking at `.env.sample`.

## Continuous integration

Any commit pushed to master gets deployed to [backend.todomaster.com](https://backend.todomaster.com) via [CI Ninja](https://github.com/backmeupplz/ci-ninja).
