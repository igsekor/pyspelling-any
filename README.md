![Spellcheck](https://github.com/narisoft/docs/workflows/Spellcheck/badge.svg)

# GitHub Spellcheck

Repository is created for the support of any languages that you need for spell checking in GitHub Actions. This action uses [PySpelling](https://pypi.org/project/pyspelling/) to check spelling in source files in the designated repository.

## Features

- Customizable configuration of spell checking using [Aspell](http://aspell.net) and [Hunspell](http://hunspell.github.io)  due to [docs](https://facelessuser.github.io/pyspelling/configuration/)
- Support any formats of file to check
- Supports any languages from the list for [Aspell](https://ftp.gnu.org/gnu/aspell/dict/0index.html) and any languages for [Hunspell](https://en.wikipedia.org/wiki/Hunspell).

## Configuration

1. First you have to add a configuration for the spelling checker
2. Create a file named: `.spellcheck.yml` or `.spellcheck.yaml`, do note if both files exist the prior will have precedence. Do note the recommendation is _hidden_ files since these configuration files are not first rate citizens of your repository
3. Paste the contents of the outlined example, which is a configuration for Markdown, useful for your README file

Do note that this action requires the contents of the repository, so it is recommended used with [the Checkout action][actioncheckout].

You have to define this part in your workflow, since it not a part of the action itself.

Example:

```yaml
# This is workflow for spell checking using PySpelling lib (https://pypi.org/project/pyspelling/)
name: Spellcheck
# Controls when the action will run.
on:
  # Triggers the workflow on push or pull request events but only for the main branch
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]
  # Allows you to run this workflow manually from the Actions tab
  workflow_dispatch:
# A workflow run is made up of one or more jobs that can run sequentially or in parallel
jobs:
  # This workflow contains a single job called "build"
  build:
    # The type of runner that the job will run on
    runs-on: ubuntu-latest
    # Steps represent a sequence of tasks that will be executed as part of the job
    steps:
      # Spellcheck
      - uses: actions/checkout@v2
      - uses: igsekor/pyspelling-any@v0.0.2
        name: Spellcheck
```

Note the step: `- uses: actions/checkout@master`
This file must live in a the `.github/workflows/` directory.
For example, it could be `.github/workflows/spellcheck.yml`

## Checking For Bad Spelling

The GitHub Action helps you make sure _most_ spelling errors do not make it into your repository. You can however check your spelling prior to committing and pushing to your repository.

This simply uses the contents of our spelling toolchain:

```bash
$ pyspelling -c .spellcheck.yml
Misspelled words:

...

!!!Spelling check failed!!!
```

And at some point we get:

```bash
$ pyspelling -c .spellcheck.yml
Spelling check passed :)
```

Now we should be good to go.

Do note you could also use the `entrypoint.sh`, which is the script used in the Docker image.

```bash
Starting...
Setup languages and spelling tool...
Reading package lists...
Building dependency tree...
Reading state information...
aspell-en is already the newest version (2018.04.16-0-1).
aspell-en set to manually installed.
0 upgraded, 0 newly installed, 0 to remove and 3 not upgraded.
Using PySpelling according to configuration from spellcheck.yaml
Spelling check passed :)
```

## Author

The original author of this GitHub Action is Igor Korovchenko (@igsekor)

## Copyright and License

This repository is licensed under the MIT license.