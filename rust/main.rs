use std::fs::{self, File};
use std::io::Write;
use std::path::PathBuf;
use std::error::Error;
use base64::Engine;

fn main() -> Result<(), Box<dyn Error>> {
    // Initialize output string
    let mut output: String = String::from("this.pdfMake=this.pdfMake||{},this.pdfMake.vfs={");

    // Read current directory
    let entries: fs::ReadDir = fs::read_dir(".")?;

    for entry in entries {
        let entry: fs::DirEntry = entry?;
        let path: PathBuf = entry.path();

        // Skip if not a file
        if !path.is_file() {
            continue;
        }

        // Get all files matching the extensions in the current directory
        if let Some(ext) = path.extension() {
            let ext_str: String = ext.to_string_lossy().to_lowercase();
            if ["otf", "ttf", "ttc", "png", "jpg", "jpeg", "gif"]
                .contains(&ext_str.as_str()) {

                // Read file content
                let content: Vec<u8> = fs::read(&path)?;

                // Convert to base64
                let base64: String = base64::engine::general_purpose::STANDARD.encode(&content);

                // Get filename, ensuring forward slashes
                let filename: String = path.file_name()
                    .unwrap()
                    .to_string_lossy()
                    .into_owned();

                // Add to output string
                output.push_str(&format!("\"{}\":\"{}\"," , filename, base64));
            }
        }
    }

    // Remove last comma and close the object
    if output.ends_with(',') {
        output.pop();
    }
    output.push_str("};");

    // Write to file
    let mut file: File = File::create("vfs_fonts.js")?;
    file.write_all(output.as_bytes())?;

    println!("vfs_fonts.js created");
    Ok(())
}