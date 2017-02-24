## Contributing to the BlueCompute Reference Application
Anyone can contribute to the BlueCompoute Reference Application and associated projects and we welcome your contributions.
There are multiple ways to contribute: report bugs and improvement suggestion, improve documentation and contribute code.

We really value contributions and to maximize the impact of code contributions we request that any contributions follow these guidelines:

## Coding Standard 
- Please ensure you follow the coding standard and code formatting used throughout the existing code base
- All new features must be accompanied by associated tests

## Creating pull requests
- Make sure all tests pass locally before submitting a pull request
- New pull requests should be created against the integration branch of the repository
  This ensures new code is included in full stack integration tests before being merged into the master branch


## House keeping

1. One feature / bug fix / documentation update per pull request
2. Include tests with every feature enhancement, improve tests with every bug fix
3. One commit per pull request (squash your commits)
4. Always pull the latest changes from upstream and rebase before creating pull request. 


### Github and git flow
The internet is littered with guides and information on how to use and understand git.
However, here's a compact guide that follows the suggested workflow

1. Fork the desired repo in github

        
2. Clone your repo to your local computer


3. Add the upstream repository

    Note: Guide for step 1-3 here: [forking a repo](https://help.github.com/articles/fork-a-repo/)

4. Create new development branch off the integration branch

    ```
    git checkout -b <my-feature-dev> integration
    ```
5. Do your work
   - Write your code
   - Write your tests
   - Pass your tests locally
   - Commit your intermediate changes as you go and as appropriate
   - Repeat until satisfied

6. Rebase to the latest upstream changes, resolving any conflicts

    ```
    git fetch upstream
    git branch --set-upstream-to=upstream/integration
    git rebase
    ```

7. Create a new branch off the integration branch to submit pull request from
    
    ```
    git checkout -b <my-feature> integration
    ```

8. Squash your intermediate commits development branch into a single commmit in feature branch

    ```
    git merge --squash <my-feature-dev>
    git commit -m 'add feature xyz'
    ```


9. Push the changes to your repository

    ```
    git push origin <my-feature>
    ```

10. Create pull request against the `integration` branch of the upstream repository

[Creating a pull request](https://help.github.com/articles/creating-a-pull-request/)

#### What happens next?
- All pull requests will be automatically build and unit tested by travis-ci. 
- The repository maintainer will then inspect the commit and if accepted will pull the code into the integration branch.
- This will kick off a full integration test done in Bluemix Open Toolchain. 
- Commits passing this stage will make it into the next release.

