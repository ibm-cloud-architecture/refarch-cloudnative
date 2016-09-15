#### Before you start

It is important these steps are followed as we want to ensure that Node is installed via NVM to easily switch versions and ensure it is available without root access.  If you are on a Mac and installed Node from the installer instead of Homebrew/NVM, please follow these instructions [Uninstall Node JS from Mac](http://benznext.com/completely-uninstall-node-js-from-mac-os-x/) to remove it before starting over.

#### Installation of Node for Mac OSx

**Note:** After the installation of Homebrew, these instructions should work for  Windows and linux. Homebrew is a package manager for OSx.

1. Homebrew - Check to see if it's installed by running **`brew -h`** in your terminal
    If brew isn't installed, then install xcode cli tools, and then install Homebrew.

 ```
 $ xcode-select --install
 $ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)
 ```

2. NVM - Install nvm and create an nvm directory within your home directory.

 ```
 $ brew install nvm
 $ mkdir ~/.nvm
 ```

 There will be some instructions when the installation completes. The steps here follow those instructions.

3. Run **`touch ~/.bash_profile`** then open **`~/.bash_profile`**.
   This will create and open a file that configures your Bash shell.
   If you know you are using a different shell, open that terminal's profile file (for instance, ZSH's file is **`~/.zshrc`**).
   Add the following to your **`~/.bash_profile`** file each on separate lines:

 ```
  export NVM_DIR=~/.nvm
  source $(brew --prefix nvm)/nvm.sh
 ```

4. Save the file, close your terminal, and restart it.

5. Node.js - Install node, API Connect requires version 4.

 ```
 $ nvm install 4
 ```

6. Add **`nvm use 4`** on a new line to the same file you edited in Step 3. Save, close, and re-open your terminal. When you repoen
the terminal you should see  something like **`Now using node v4.5.0 (npm v2.15.9)`**

#### Some additional resources and notes

Homebrew (**`brew`**) requires the xcode command line tools. More information can be found at [installing homebrew on OSx](https://coolestguidesontheplanet.com/installing-homebrew-on-os-x-el-capitan-10-11-package-manager-for-unix-apps/).

Here are some tips for working with multiple versions of node: [multiple-versions-node-nvm](https://www.sitepoint.com/quick-tip-multiple-versions-node-nvm/)


