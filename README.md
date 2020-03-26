
# Project Title

VetCentral is a Sinatra based application for a mock vet's office.
It uses ActiveRecord to connect and manage the sqlite3 database.
You should be able to create and edit a user, create and edit pets,
delete pets and delete you user account. There is a Users and a Pets Index, which can only be viewed if you are currently logged in.
When a user account is deleted, and pets associated with that account are removed from the database as well.

I hope you have fun creating your pets.

## Getting Started

You can clone the program from https://github.com/LaffSteven/vet

### Prerequisites

You will need to have Ruby installed.

```
Ruby
Bundler
```

### Installing

Clone the repo from github

```
git clone https://github.com/LaffSteven/vet
```

The run "bundle install" to make sure you have all the gems needed for the rest of the program

```
bundle install
```

The please run the database migrations

```
rake db:migrate
```

Finally, you can run Shotgun and navigate to localhost:9393/ in your web browser to use VetCentral

```
shotgun
```

## Built With

* [CORNEAL](https://github.com/thebrianemory/corneal) - A very useful gem

## Authors

* **Steven Laff** - *Initial work* - [LaffSteven](https://github.com/LaffSteven)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Thank you to Madeline Stark for her advice and review of this program.
