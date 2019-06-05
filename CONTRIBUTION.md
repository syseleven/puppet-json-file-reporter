# How to contribute

## Create a fork at your github space
Go to https://github.com/syseleven/puppet-json-file-reporter and press "Fork".

## Checkout your forked repository
```shell
git clone <your forked repository>
```

## Create a branch at the cloned repository
Use meaningful branch names, e.g. the issue id.
```
git checkout -b <branch_name>
```

## Make your changes
Only changes related to the named issue will be accepted.

## Run the test
We are running some tests to ensure style, syntax, and so on.
```shell
bundle install
bundle exec rake test
```

## Commit and push your changes
Please use meaningful commit messages.
```shell
git commit -m "fixes issue #<id>"
git push -u origin HEAD
```

## Rebase your branch
Keep you forked master always in sync with our master and rebase your branch with your master.

Update your master branch:
```shell
git checkout master
git pull --rebase
git remote add syseleven https://github.com/syseleven/puppet-json-file-reporter.git
git rebase syseleven/master
git push
```

Rebase your feature branch:
```shell
git checkout <feature-branch>
git rebase master
git push -f
```

## Create a pull request
After you have pushed your feature branch to your github space you can create a pull request.

## Eat some cookies
Since we all love cookies and to celebrate the open source culture eat some cookies of your choice.
