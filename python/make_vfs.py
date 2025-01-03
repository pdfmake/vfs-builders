import os
import base64
from pathlib import Path

def make_vfs():
    # Initialize output string
    output = "this.pdfMake=this.pdfMake||{},this.pdfMake.vfs={"

    # Get all files matching the extensions in the current directory
    allowed_extensions = {'.otf', '.ttf', '.ttc', '.png', '.jpg', '.jpeg', '.gif'}
    current_dir = Path('.')

    # Process each file
    for file_path in current_dir.iterdir():
        # Skip directories and check file extension
        if not file_path.is_file() or file_path.suffix.lower() not in allowed_extensions:
            continue

        # Read file content in binary mode
        with open(file_path, 'rb') as f:
            content = f.read()

        # Convert to base64
        base64_content = base64.b64encode(content).decode('utf-8')

        # Add to output string using forward slashes for consistency
        filename = str(file_path.name).replace('\\', '/')
        output += f'"{filename}":"{base64_content}",'

    # Remove last comma and close the object
    output = output.rstrip(',') + '};'

    # Write to file
    with open('vfs_fonts.js', 'w', encoding='utf-8') as f:
        f.write(output)

    print("vfs_fonts.js created")

if __name__ == '__main__':
    make_vfs()