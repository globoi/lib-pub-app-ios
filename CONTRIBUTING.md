# Lib Pub App IOS Contribution Guide

## Introduction

This is a contributing guide designed to help new members and other teams understand the workflow and best practices for contributing to the **Lib Pub IOS App** project.

## Project Structure

**Main folder structure of the lib pub app project**

- core:/ contains the main functionality of the library code.
- cross/: centralizes the cross-concerns code of the lib pub app module. It includes features like logging and other functionalities that can be used in different parts of the project.
- externals/: folder with integrations and external dependencies of the project.
- repositories:/ data and storage management.
- targeting/: contains parameters and targeting definitions for ads.
- types/: contains the definitions of the data types used by the library.

## Contribution Rules

1. **Branch creation**

Use this branch pattern when starting a new task.

- feature/ for new features.
- fix/ for bug fixes
- docs/ for documentation changes.

2. **Code Style**

The project ensures consistency in code style. It is always important to check and format the code using the recommended CocoaPods tasks:

- pod lib lint: Will lint your pod locally, assuming that you have provided everything needed to create your pod.
- pod spec lint: Will lint your pod from anywhere, including if your pod's source code is hosted on GitHub.

3. **Tests**

- Use tool XCTest to write and maintain tests.
- Write new unit tests or/and integration tests for each new implementation or fix.
- Check that all tests pass before making a pull request.

## Pull Requests

- Make frequent and well-descriptive commits to maintain a history
- When you finish a task, open a pull request with a detailed description, and include references to the resolved issues if you have them.

## Git Flow

- New features in the project must always be developed from a branch that has to be created from the main branch. This ensures that changes still under testing are taken from the DEV environment to the PROD environment.

1. **Create a branch for new features**

- Whenever you implement a new functionality in the project, create a new branch from main. This helps avoiding conflicts and ensures that only approved and tested changes go into production.

2. **Development and testing**

- When making new changes, commit to the new branch created, and document the changes.

3. **Merge into Branch**

- Once development is complete, merge the new branch into the dev branch. This will allow the new implementations to be tested in the development environment before moving to main branch and consequently to production environment.

4. **Testing in the development environment**

- Always perform testing for new updates to ensure that new features work as expected and that there is no negative impact on other parts of the project.

5. **Merge into branch**

- After carrying out and passing all tests, merge the "feature/fix/docs" branch (created by you) into the main branch. This will make the new features available in the production environment.

## Deployment process

- Our deployment mechanism is based on manually created tags from the dev and main branches, so that each one will deliver a new version of the podspec file to the pod repository on github globo.