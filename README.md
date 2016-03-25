# My dotfiles 

## Installation

```
$ git clone https://github.com/moqada/dotfiles.git
$ cd dotfiles
```

## Setup

Put `~/.zshenv`

```
export NPM_TOKEN=<NPM_TOKEN>
export CONVENTIONAL_GITHUB_RELEASER_TOKEN=<GITHUB_TOKEN>
```

### For Mac

Put dotfiles, install applications and tools.

```
$ ./scripts/setup_mac.sh
```

Install applications from original packages

> [MacApplications.md](MacApplications.md)

After sync Dropbox (`./Mackup`), restore settings for some applications.

```
$ mackup restore
```


### For Others

Put dotfiles only.

```
$ ./scripts/setup.sh
```
