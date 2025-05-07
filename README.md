# GeekMD's Personal NvChad Configuration

The bulk of my work is with TypeScript/React/Redux and Python. At present, this configuration supports those two langauges.

On first run Lazy will install all of your dependencies, except the formatters and language servers that are handled via Mason. For those to install you'll need to open a file with one of the supported file extensions (e.g. "\*.py"). The formatters and language servers will install, but you'll want to go restart NeoVim.

By default, GitHub's CoPilot (through copilot.lua) is supported. To authenticate just type `:Copilot auth`.

## Original Content from the NvChad Starter

**This repo is supposed to used as config by NvChad users!**

- The main nvchad repo (NvChad/NvChad) is used as a plugin by this repo.
- So you just import its modules , like `require "nvchad.options" , require "nvchad.mappings"`
- So you can delete the .git from this repo ( when you clone it locally ) or fork it :)

### Credits

1. Lazyvim starter https://github.com/LazyVim/starter as nvchad's starter was inspired by Lazyvim's . It made a lot of things easier!
