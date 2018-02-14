# PersistencePerformanceFun

An application used at Learn Swift Winnipeg to compare and contrast different persistence methods, including UserDefaults, manually storing files via FileManager, and using the Disk framework.

## Getting Started

This project uses Carthage dependency manager to load 3rd party frameworks. It must be installed in order to build the project. Follow the provided steps to install via HomeBrew:

### Ensure HomeBrew Is Installed
- Run `$ brew --version` in terminal.
- You'll see something like `Homebrew 1.2.4` if it's installed.
- If not, go to https://brew.sh for installation instructions.

### Install Carthage
- With HomeBrew installed run `brew update` in terminal.
- Run `brew install carthage`.

### Install Dependencies
- With Carthage installed run `carthage bootstrap --platform iOS` in terminal.
