#!/bin/sh

if [ -t 1 ]; then
	target="vfs_fonts.js"
else
	target="/dev/stdout"
fi

(
	echo "var vfs = {"
	for file in "$@"; do
		file=$1
		filename=$(basename $file)
		filecontent=$(base64 -w 0 $file)
		shift
		echo "\"${filename}\":\"${filecontent}\""
		if [ "$#" -gt 0 ]; then
			echo ","
		fi
	done
	echo "}"
	echo "; var _global = typeof window === 'object' ? window : typeof global === 'object' ? global : typeof self === 'object' ? self : this; if (typeof _global.pdfMake !== 'undefined' && typeof _global.pdfMake.addVirtualFileSystem !== 'undefined') { _global.pdfMake.addVirtualFileSystem(vfs); } if (typeof module !== 'undefined') { module.exports = vfs; }"
) > "$target"