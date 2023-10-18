# Guidelines

First we need to install vim-plug run the following in relation to which machine you've spawned on:

## Downloading and setting up vim-plug
### Windows
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni $HOME/vimfiles/autoload/plug.vim -Force


### Linux
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


Or if using the plug.vim that is in this repo do:

```
mkdir -p ~/.vim/autoload
cp plug.vim ~/.vim/autoload/
```

## Setting up vimrc
Afterwards to load your custom virc file do the following

### Linux
cp sample.vimrc ~/.vimrc

### Windows
Google is your friend, I don't use this and won't.
