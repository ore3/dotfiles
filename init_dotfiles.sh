#!/bin/sh


# download 
if [ -e ~/.vimdir ]; then
	echo "found vimdir"
else
	echo "mkdir vimdir"
	mkdir -p ~/.vimdir/{swap,backup,undo}
fi

# download 
if [ -e ~/.oh-my-zsh ]; then
	echo "oh-my-zsh found"
else
	echo "install oh-my-zsh"
	git clone https://github.com/ore3/oh-my-zsh ~/dotfiles/rc/oh-my-zsh
	ln -vFis ~/dotfiles/rc/oh-my-zsh ~/.oh-my-zsh;
fi

# current dir
cd $(dirname $0)

# make symlink
cd rc
for dotfiles in *; do
	case $dotfiles in 
		\.*)
			continue;;
		..)
			continue;;
		.git)
			continue;;
		*)
			ln -Fis "$PWD/$dotfiles" "$HOME/.$dotfiles";;
	esac
done
if [ -e ~/.vim ]; then
	echo ".vim found. rename .vim dir"
else
	ln -vFis ~/dotfiles/rc/vim ~/.vim;
fi

# install & update NeoBundle plugins
#if [ "${is_existed}" == true ]; then
#	echo "running NeoBundleUpdate...\n"
#	vim -u ~/.vimrc -i NONE -c "try | NeoBundleUpdate! | finally | q! | endtry" -e -s -V1
#else
#	echo "running NeoBundleInstall...\n"
#	vim -u ~/.vimrc -i NONE -c "try | NeoBundleInstall! | finally | q! | endtry" -e -s -V1
#fi
#echo "\ncompleted!"


# download neobundle files
if [ -e ~/dotfiles/rc/vim/bundle/neobundle.vim ]; then
	echo "neobundle found"
	is_existed=true
else
	echo "install neobundle"
	mkdir -p ~/dotfiles/rc/vim/bundle/
	git clone https://github.com/Shougo/neobundle.vim ~/dotfiles/rc/vim/bundle/neobundle.vim
	is_existed=false
fi

# vimproc
if [ -e ~/dotfiles/rc/vim/bundle/vimproc.vim ]; then
	echo "vimproc found"
else
	echo "install vimproc"
	sudo yum install -y gcc
	git clone https://github.com/Shougo/vimproc.vim.git ~/.vim/bundle/vimproc.vim
	cd ~/.vim/bundle/vimproc.vim
	make
fi

#peco
if [ -e /usr/local/bin/peco ]; then
	echo "peco found"
else
	echo "install peco"
	wget https://github.com/peco/peco/releases/download/v0.3.2/peco_linux_386.tar.gz
	tar zxvf peco_linux_386.tar.gz 
	sudo cp peco_linux_386/peco /usr/local/bin/peco
fi

