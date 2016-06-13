#!/usr/bin/env bash

ORIG_PATH=$PATH

export ZEPHIRDIR=/usr/share/zephir
export PATH=$PATH:/usr/share/zephir/bin

mkdir -p $ZEPHIRDIR

git clone --depth=1 -v https://github.com/phalcon/zephir /tmp/zephir
cd /tmp/zephir

# because containers does not have sudo
echo "#!/usr/bin/env bash
exec \"\$@\"" > /usr/bin/sudo

chmod +x /usr/bin/sudo
(cd parser && phpize --clean)
./install -c
cd / && rm -rf /tmp/zephir

git clone --depth=1 -v https://github.com/phalcon/cphalcon.git -b 2.1.x /tmp/phalcon-ext
cd /tmp/phalcon-ext
zephir build
cp ext/modules/phalcon.so $(php-config --extension-dir)/phalcon.so

echo 'extension=phalcon.so' | tee /etc/php/5.5/mods-available/phalcon.ini

ln -s /etc/php/5.5/mods-available/phalcon.ini /etc/php/5.5/cli/conf.d/50-phalcon.ini

cd /
rm -rf $ZEPHIRDIR /tmp/phalcon-ext /usr/bin/sudo
export PATH=$ORIG_PATH
unset ZEPHIRDIR
unset ORIG_PATH
