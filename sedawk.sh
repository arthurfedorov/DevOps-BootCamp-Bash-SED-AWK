#!/bin/bash

# Put you code here

# Create copy of `passwd` file to `passwd_new`. :exclamation: Do all modifications
# on `passwd_new` file
cp passwd passwd_new

# Change shell for user `saned` from /usr/sbin/nologin to /bin/bash using AWK
awk -F: 'BEGIN {OFS=":"} $1 == "saned" { $7 = "/bin/bash" } { print }' passwd_new > passwd_tmp && mv passwd_tmp passwd_new

# Change shell for user avahi from /usr/sbin/nologin to /bin/bash using SED
sed -i '/^avahi:/ s#/usr/sbin/nologin#/bin/bash#g' passwd_new

# Save only 1-st 3-th 5-th 7-th columns of each string based on : delimiter
awk -F ":" '{print $1 ":" $3 ":" $5 ":" $7}' passwd_new > passwd_tmp && mv passwd_tmp passwd_new

# Remove all lines from file containing word daemon
sed -i '/daemon/ d' passwd_new

# Change shell for all users with **even** `UID` to `/bin/zsh`
awk -F':' 'BEGIN {OFS=":"} $3 % 2 == 0 {$7 = "/bin/zsh"} {print $0}'



