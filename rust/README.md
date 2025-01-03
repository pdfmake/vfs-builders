## Rust - [rust-lang.org](https://www.rust-lang.org/tools/install)

### **Default** `match` **file extensions:** `otf|ttf|ttc|png|jpg|jpeg|gif`

1. **Create** `/make_vfs` directory:

```cmd
cargo new make_vfs
```

2. Navigate to `/make_vfs` directory.
3. **Open** `/make_vfs` directory in VS Code:

```cmd
code .
```

4. **Copy** this script into `main.rs` file.
5. **Add** `base64` crate **dependency** to `Cargo.toml` file

```toml
[dependencies]
base64 = "0.22.1"

# Customizing Builds with Release Profiles at
# https://doc.rust-lang.org/book/ch14-01-release-profiles.html
[profile.dev]
opt-level = 0

[profile.release]
opt-level = 3
```

6. **Compile** to executable binary:

```cmd
cargo build --release
```

7. **Output**:

```txt
D:\rust\make_vfs>cargo build --release
   Compiling base64 v0.22.1
   Compiling make_vfs v0.1.0 (D:\rust\make_vfs)
    Finished `release` profile [optimized] target(s) in 1.51s
```