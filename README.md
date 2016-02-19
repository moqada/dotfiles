# My dotfiles 

## Setup

```
$ git clone https://github.com/moqada/dotfiles.git
$ cd dotfiles
$ ./scripts/setup.sh
```

Put `~/.zshenv`

```
export NPM_TOKEN=<NPM_TOKEN>
export CONVENTIONAL_GITHUB_RELEASER_TOKEN=<GITHUB_TOKEN>
```

## For Mac

Install homebrew

```
$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
$ xcode-select --install
```

Install packages and applications from Brewfile

```
$ brew bundle
```

Install applications from App Store and original packages

[MacApplications.md](MacApplications.md)
