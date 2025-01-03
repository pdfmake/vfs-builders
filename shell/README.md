## Shell

How to use script:
```sh
make_vfs.sh font1.ttf font2.ttf font3.ttf
```

If you are using a mac you need to change this line
```
		filecontent=$(base64 -w 0 $file)
```

to (change the flag from `-w` to `-b`)

```
		filecontent=$(base64 -b 0 $file)
```

GNU coreutils' `base64` seems to differ to Apple's `base64` in this flag (which prevents line wrapping).
