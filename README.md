﻿
# Fusion Node + Express API Skeleton

## Purpose

The purpose of this API skeleton is to provide a starter API - one that is more complete than something you'd get from the Express application generator, and yet not bloated with a bunch of features you'll have to rip out.

The remainder of this document contains information needed to configure and run the API in a local development environment. It also include guidance for building upon this skeleton.

Instructions for deployment to a hosted environment are out of scope.

## Prerequisites

- Install [Git](https://git-scm.com/downloads).
- Install [Node](https://nodejs.org/en/download/).
- Clone the Git repository to your local machine.
- Make a copy of the `.env.example` file, and rename the copy to `.env`.
- **For Windows-based development environments only**: Ensure line endings are configured for LF instead of CRLF. See the [Troubleshooting](#Troubleshooting) section for instructions.

## How To

Unless otherwise noted, all terminal commands must be issued from the project's root directory.

### Install project libraries

```bash
npm install
```

### Lint the code

```bash
npm run lint
```

You can also run the following to fix simple lint errors:

```bash
npm run fixlint
```

### Run tests

```bash
npm test
```

Or you can run integration and unit tests separately:

```bash
npm run integration-test
```

```bash
npm run unit-test
```

### Run the app

Execute the following to run the app in debug mode, with auto-restart functionality provided by `nodemon`:

```bash
npm run develop
```

Then browse to `/api-docs` to view all of the paths supported by the API.

## Troubleshooting

### Line endings are CRLF instead of LF (Windows only)

The line endings in this application are LF instead of CRLF. The commands below will configure your Windows environment for LF only. These changes will be applied to all of your Git Repos.

```bash
# Set default core.autocrlf to false in Windows
git config --global core.autocrlf false

# Set core.eol to LF in Windows
git config --global core.eol lf
```

### Application or Tests Don't Work Due To Missing Dependencies

* Re-run `npm install` to verify that your dependencies are up to date.

### Debugging project locally with Visual Studio Code fails with 'Error: Required value not provided: appName'

A launch.json file is necessary to use environment variables from the .env file when debugging the project locally.

- Create a launch.json file in the project's .vscode folder with the following JSON contents:

```JSON
{
  "version": "0.2.0",
  "configurations": [

    {
      "type": "node",
      "request": "launch",
      "name": "Launch API",
      "program": "${workspaceFolder}/bin/www",
      "envFile":"${workspaceFolder}/.env"
    },
    {
      "type": "node",
      "request": "launch",
      "name": "Run Tests",
      "program": "${workspaceFolder}/node_modules/mocha/bin/_mocha",
      "args": [
        "-u",
        "tdd",
        "--timeout",
        "999999",
        "--colors",
        "${workspaceFolder}/tests/**/*.js"
      ],
      "internalConsoleOptions": "openOnSessionStart",
      "envFile":"${workspaceFolder}/.env"
    }
  ]
}
```

Notes: The supplied JSON code will add two debugging options, `Launch API` and `Run Tests` to the Visual Studio Code IDE: 

- `Launch API` will start the API. The default endpoint is localhost:3000/api

- `Run Tests` will execute all Mocha test scripts in the project and show the results in the DEBUG CONSOLE window.

### Everything Is Hosed!

Sometimes you just need to completely reset your development environment. Execute the following commands to start from a "clean slate":

```bash
// NOTE: Untracked changes will be lost!
git clean -dxf
```

## Project Folder Structure

For the benefit of those building and/or maintaining the application, here's an overview of the folder structure.

### root

Contains files common to typical Node+Express Web apps.

### bin

Contains application startup code. Originally generated by the [Express Application Generator](https://expressjs.com/en/starter/generator.html), and then modularized and simplified.

### src

Contains the application's source files.

#### app-middleware

Application middleware to handle crosscutting application-level concerns.

#### models

Contains Web models.

If you introduce different kinds of models (e.g., domain/data models), be sure to separate these using subfolders.

#### routes

The application route handlers.

#### services

Functions that provide support to other parts of the application, esp. to the route handlers.

### tests

Automated tests.

  > Recommendation: *Keep integration and unit tests separate.*
  > Recommendation: *Keep tests separate from source files.*

## Versioning

We use [SemVer](http://semver.org/) for versioning.
