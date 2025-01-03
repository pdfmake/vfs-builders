<?php

$output = "var vfs = {";
$phpDir = dir('.');
while (($file = $phpDir->read()) !== false) {
    if ($file != '..' && $file != '.' && $file != 'make_vfs.php' && $file != 'vfs_fonts.js') {
        $output .= '"';
        $output .= $file;
        $output .= '":"';
        $output .= base64_encode(file_get_contents($file));
        $output .= '",';
    }
}
$output = substr($output, 0, -1);
$output .= "}";

$output .= "; var _global = typeof window === 'object' ? window : typeof global === 'object' ? global : typeof self === 'object' ? self : this; if (typeof _global.pdfMake !== 'undefined' && typeof _global.pdfMake.addVirtualFileSystem !== 'undefined') { _global.pdfMake.addVirtualFileSystem(vfs); } if (typeof module !== 'undefined') { module.exports = vfs; }";

if (isset($_REQUEST['tofile'])) {
    $fh = fopen('vfs_fonts.js', 'w') or die("CAN'T OPEN FILE FOR WRITING");
    fwrite($fh, $output);
    fclose($fh);
    echo 'vjs_fonts.js created';
} else {
    echo $output;
}