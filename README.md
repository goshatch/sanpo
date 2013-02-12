# SANPO: Social Photowalks

## What is this?
This is the source code for [SANPO](http://sanpo.cc). It is released
under the [Mozilla Public License version
2.0](http://www.mozilla.org/MPL/2.0/). The included graphical assets are
not covered by this license and may not be redistributed without
explicit permission.

## Getting it up and running
In most cases:
```
git clone git://github.com/gueorgui/sanpo.git
cd sanpo
bundle install
rails s
rake db:migrate
open "http://localhost:3000"

# Ubuntu/Debian users might want install packages for MySQL and WebKit
sudo apt-get install qt4-dev-tools libqt4-dev libqt4-core libqt4-gui libmysql-ruby libmysqlclient-dev
```

You will also need to configure email delivery to match your
environment (see bottom of ```config/application.rb```).

## Who made this?
Originally developed by Gueorgui Tcherednitchenko ([@gueorgui](http://twitter.com/gueorgui)) in Tokyo, Japan.
Illustrations by [@monja415](http://twitter.com/monja415).
Additional tests by [cwabbott](https://github.com/cwabbott) and [EmilRehnberg](https://github.com/EmilRehnberg). Thank you very much!
