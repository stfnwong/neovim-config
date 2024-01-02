# NEOVIM CONFIG
This is to shut github up about not having a README. This is my config for neovim.
I am moving to neovim because vim is too slow on my mac, and its only partly
because of the fucking antivirus shit that we have at work. Why a 2019 Macbook
pro is fucking slow like dogshit I don't know but even on this fucked up ISO
keyboard I can still type as fast if not faster than the buffer can render
because it takes a literal age to draw one fucking character. I can fly through 
the exact same thing without breaking a sweat on a T440p, which was not hand 
designed by a Trillion Dollar company in Sunny California.

Typing in this same file in neovim is slightly faster, although the real reason 
is that somehow this machine can barely run a terminal that is designed to 
emulate a teletype machine from the mid 20th century.

### Outdated
For my future self, this file goes in `$HOME/.config/nvim`.


### New plugin layout using lua

I followed some guide or other that puts all the lua stuff into named folders.
From what I can tell as someone who knows no lua you glue everything together 
in `init.lua` by using `require()`.

So each plugin gets its own `lua` file that controls its settings, each of these
is under `lua/woctor/plugins` and needs to be `require()`'d from `init.lua`.


### NetRW
I think I prefer the old behaviour of `netrw` where you can `:e` to a directory and 
then select something without having `nvimtree` pop up and then place the source file 
in the current buffer.
