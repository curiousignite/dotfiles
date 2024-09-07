# dotfiles

This is my configuration files repo.

I use this to work on multiple setups simultaneously, both windows and linux.

After creating the skeleton from scratch, I came across a git repo which does basically the same thing as mine does but in a larger scale.
So I ~~stole~~ inspired and implemented some techniques from it but kept the config files and programs the same for my liking and simplicity.

- Here is a link to git repo: <https://github.com/khaneliman/dotfiles/tree/main>

## TODO

### General

- [X] nvim/wezterm open links in browser on click
- [X] Firefox user.js configuration (https://github.com/arkenfox/user.js)
- [ ] Setup VM for testing purposes because it's getting hard to test it on my pc

### Windows

- [X] Check which programs are installed and install programs
- [X] Check and replace old config files with config.old file for safety
- [X] Create junctions and symlinks for windows config files
- [X] Prompt for installation of missing programs
- [X] Check if fonts exists before installation
- [X] Windows Explorer Theme settings 


### Linux

- [ ] Check which programs are installed and install programs
- [ ] Check and replace old config files with config.old file for safety
- [ ] Create links for config files
- [ ] Prompt for installation of missing programs

### Future Plans

- Create a macOS setup
- Create a minimal setup versions for old systems
- Separate personal and work stuff(Don't install steam on work pc etc.)
- Create a single executable with the minimum dependency for starting point
