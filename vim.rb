dep "vim" do
  requires ["packages.lib", "languages", "vim-source", "vim-config"]

  met? {
    requirements
  }

  meet {
    compile #&& install
  }
end

def requirements
  return false unless "vim/src/vim".p.exists?
  cd "vim" do
    shell("src/vim --version").include?("+python")
  end
end

def compile
  cd "vim" do
    shell("make distclean")
    shell("./configure " + options)
    shell("make")
  end
end

def install
  cd "vim" do
    shell("sudo make install")
  end
end

def options
  [
  "--with-features=HUGE",
  "--enable-multibyte=yes",
  "--enable-cscope=yes",
  "--enable-fontset",
  "--enable-rubyinterp",
  "--with-ruby-command=/home/mcgain/.rvm/rubies/ruby-1.9.3-p286/bin/ruby",
  "--enable-pythoninterp",
  "--with-python-config-dir=/usr/lib/python2.6/config"
  ].join(" ")
end

  dep "vim-config" do

  end

  dep "vim-source" do
    requires "mercurial.bin"
    met? {
      "vim/Vim.info".p.exists?
    }

    meet {
      shell("hg clone https://vim.googlecode.com/hg/ vim")
    }
  end

  dep "mercurial.bin" do
    provides "hg"
  end

  dep "packages.lib" do
    installs "libncurses5-dev"
    installs "libgnome2-dev"
    installs "libgnomeui-dev"
    installs "libgtk2.0-dev"
    installs "libatk1.0-dev"
    installs "libbonoboui2-dev"
    installs "libcairo2-dev"
    installs "libx11-dev"
    installs "libxpm-dev"
    installs "libxt-dev"
    installs "libpython2.7-dev"
  end

  dep "languages" do
    requires ["ruby", "python"]
  end

  dep "python", template: "bin" do
    installs "python-dev"
    provides "python"
  end
