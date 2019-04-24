#!/bin/bash
ln -s /opt/app-root/src/wp-content/wp-config.php /opt/app-root/src/wp-config.php
exec /usr/libexec/s2i/run
