# hanlon-cookbook

This is the wrapper cookbook to deploy [hanlon](https://github.com/csc/Hanlon) and deal with the dependencies.

NOTE: This is very much a WIP.

NOTE: still need to set up dhcp inside this cookbook also.

## How to get hanlon running with puma

You'll need to check the `hanlon_server.conf` and the `hanlon_client.conf` after the init script is ran do to some of the miss automatic configurations. Such as `hanlon_server:` and the `image_path:`

```shell
$ sudo su -
# cd /opt/hanlon
# gem install bundler
# bundle install
# ./hanlon_init
# vi /opt/hanlon/cli/config/hanlon_client.conf
# vi /opt/hanlon/web/config/hanlon_server.conf
# cd /opt/hanlon/web/
# bundle exec puma
```
