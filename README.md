﻿# Fusion Node + Express API Skeleton

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

### Building with Docker

You will need to have the Docker engine installed and running before executing any of the below. See the Docker [downloads page](https://www.docker.com/community-edition) for more details.

#### Build the image

From the root of the project:

```bash
docker build -t express-scaffold -f Dockerfile .
```

#### Run an ephemeral container

In the examples below, I'm running the app on port 8080, and mapping 8080 of the host to that of the docker container with the `-p` flag. If, for example, you wanted to bind to port 9090 on the host but still run the server on 8080 inside the container, the argument would be `-p 9090:8080`. If you want to change the port on which the server is running inside the container, you can do so by changing the `PORT=` line of your .env file.

##### Option 1: Pass .env contents as true env vars

This involves a bit less overhead than option 2 below, and it should be used when you don't have any sensitive information in your .env file. The rationale is that env vars have a tendency to end up in logs in plaintext unless you take additional steps to cleanse/obfuscate.

```bash
docker run --rm -d -p 8080:8080 --name express-scaffold-container --env-file <path-to-.env-file> express-scaffold
```

##### Option 2: Pass .env file as a volume

Rather than translating your .env file, this option mounts the file itself into the docker container. Unlike with env vars, the contents of this file are less likely to inadvertently wind up in your logs.

```bash
docker run --rm -d -p 8080:8080 -v <absolute-path-to-.env-file-in-your-project>:/app/config/.env --name express-scaffold-container express-scaffold
```

#### Accessing the service

This is no different than running outside of docker: access `localhost:8080/api`. Be sure to use the same port to which you established the binding in the run step with the `-p` argument.

#### Stopping the container and cleaning up

Running the container with the `--rm` flag will clean it up whenever it stops. To stop the container:

```bash
docker stop express-scaffold-container
```

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
