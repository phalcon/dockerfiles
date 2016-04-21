#!/usr/bin/env bash
#
#  Phalcon Framework
#
#  Copyright (c) 2011-2016 Phalcon Team (http://www.phalconphp.com)
#
#  This source file is subject to the New BSD License that is bundled
#  with this package in the file docs/LICENSE.txt.
#
#  If you did not receive a copy of the license and are unable to
#  obtain it through the world-wide-web, please send an email
#  to license@phalconphp.com so we can send you a copy immediately.
#
#  Authors: Serghei Iakovlev <serghei@phalconphp.com>

rm -rf /tmp/*

echo "/tmp/core-%e.%p" | tee /proc/sys/kernel/core_pattern &> /dev/null
ulimit -c unlimited

$@

ret=$?

if [ ${ret} -eq 0 ]; then
    exit 0;
fi

echo -e "The command '${@}' terminated with non-zero status code."

shopt -s nullglob
export LC_ALL=C

for i in /tmp/core-*.*; do
	if [ -f "$i" -a "$(file "$i" | grep -o 'core file')" ]; then
		gdb -q $(which php) "$i" <<EOF
set pagination 0
backtrace full
info registers
x/16i \$pc
thread apply all backtrace
quit
EOF
	fi
done

exit ${ret};
