// Recursively walks through a directory and yields information about each file and directory encountered.
import { walk } from "https://deno.land/std/fs/mod.ts";
// Options for walk
import { type WalkOptions } from "https://deno.land/std@0.224.0/fs/mod.ts";
// Utilities for base64 encoding and decoding.
import { encodeBase64 } from "https://deno.land/std/encoding/base64.ts";

async function make_vfs() {
  // Initialize output string
  let output = "this.pdfMake=this.pdfMake||{},this.pdfMake.vfs={";

  const walk_options: WalkOptions = {
    // The maximum depth of the file tree to be walked recursively.
    maxDepth: 1,
    // Indicates whether file entries should be included or not.
    includeFiles: true,
    // Indicates whether directory entries should be included or not.
    includeDirs: false,
    // List of regular expression patterns used to filter entries. If specified,
    // entries that do not match the patterns specified by this option are excluded.
    match: [/\.(otf|ttf|ttc|png|jpg|jpeg|gif)$/],
  };

  // Walk the current directory searching for .otf, .ttf, .ttc & png files
  for await (const file of walk(".", walk_options)) {
    const content = await Deno.readFile(file.name);
    output += `"${file.name}":"${encodeBase64(content)}",`;
  }

  // Remove last comma added in for await loop
  output = output.slice(0, -1) + "};";

  // Write the vfs_fonts.js file to disk
  await Deno.writeTextFile("vfs_fonts.js", output);
  console.log("vfs_fonts.js created");
}

// deno run --allow-read --allow-write make_vfs.ts
await make_vfs();