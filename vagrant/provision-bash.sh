#!/bin/sh
echo "install aliases and augment path"
# create symbolic links in the /home/vagrant for all files in the ho
for a in `find home -name "*" -type f` ; do
  rm -f $VAGRANT_USER_HOME/`basename $a`
  ln -rs $a /home/vagrant
done
echo "export PATH=$PATH:/vagrant/vagrant/bin" >> $VAGRANT_USER_HOME/.bashrc
