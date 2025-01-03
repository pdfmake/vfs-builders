# Function to recursively walk through directory and generate VFS output
function New-VFS {
  # Initialize output string
  $output = "this.pdfMake=this.pdfMake||{},this.pdfMake.vfs={"

  # Get all files matching the extensions in the current directory
  # Equivalent to maxDepth: 1 in the Deno script
  $files = Get-ChildItem -Path "." -File |
      Where-Object { $_.Extension -match '\.(otf|ttf|ttc|png|jpg|jpeg|gif)$' }

  # Process each file
  foreach ($file in $files) {
      # Read file content as bytes
      $content = [System.IO.File]::ReadAllBytes($file.FullName)

      # Convert to Base64
      $base64 = [Convert]::ToBase64String($content)

      # Add to output string
      # Using forward slashes for consistency with the Deno version
      $relativePath = $file.Name -replace '\\', '/'
      $output += "`"$relativePath`":`"$base64`","
  }

  # Remove last comma and close the object
  $output = $output.TrimEnd(',') + "};"

  # Write to file
  $output | Out-File -FilePath "vfs_fonts.js" -Encoding UTF8

  Write-Host "vfs_fonts.js created"
}

# Execute the function
New-VFS