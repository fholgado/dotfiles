#My Vim dotfiles
Here you will find my collection of Vim configuration files. I am using Vundle to keep things tidy. Here is a blog post with more details on what is in [here](http://fhl.gd/qw7u).

#Installation Instructions for Mac/Linux
<pre>
cd ~
git clone git://github.com/fholgado/dotfiles.git ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc
cd ~/.vim
</pre>

Now, you can open Vim and run the following command:

<pre>
:BundleInstall!
</pre>

You should see a window fetching all the plugins and stuffs. Neat! You can get in touch with me at @fholgado if you have any questions.
