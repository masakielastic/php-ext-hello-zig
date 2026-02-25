# hello-zig

Learning-focused sample of a PHP extension that calls Zig through a C ABI (FFI boundary).

## Learning goals

- Understand how PHP extension C code calls a Zig function.
- Understand how Zig builds a static library consumed by PHP extension build.
- Understand how PIE metadata points to the extension build directory.

## Project layout

- `composer.json`: PIE metadata (`type: php-ext`, build path, extension name)
- `ext/config.m4`: phpize/autoconf build integration and Zig library linking
- `ext/hello_zig.c`: PHP function registration and call into Zig ABI
- `ext/zig/build.zig`: Zig static library build definition
- `ext/zig/src/hellozig.zig`: exported Zig function (`hellozig_message`)
- `ext/zig/src/hellozig.h`: C header consumed from `hello_zig.c`
- `ext/tests/001_hello_zig_hello.phpt`: runtime behavior test

## How the call flow works

1. PHP userland calls `hello_zig_hello()`.
2. PHP extension C code (`ext/hello_zig.c`) invokes `hellozig_message()`.
3. `hellozig_message()` is implemented in Zig and exported with C ABI.
4. Returned C string is sent back to PHP as a string result.

## Install with PIE (from Packagist)

This package is intended to be installable from Packagist:

- `https://packagist.org/packages/masakielastic/hello-zig`

Example:

```bash
pie install masakielastic/hello-zig
php --ri hello_zig
php -r 'echo hello_zig_hello(), PHP_EOL;'
```

Expected output:

```text
Hello World from Zig FFI!
```

## Build and run (from clean state)

Prerequisites:

- `phpize` and PHP development headers
- Zig compiler (on `PATH`, or provided via `ZIG=/path/to/zig`)

```bash
cd ext
phpize
ZIG=/home/masakielastic/.local/zig-dev/zig ./configure --enable-hello-zig
make
php -dextension=modules/hello_zig.so -r 'echo hello_zig_hello(), PHP_EOL;'
```

Expected output:

```text
Hello World from Zig FFI!
```

## Run tests

```bash
cd ext
make test TESTS=tests/001_hello_zig_hello.phpt
```

## What to edit while learning

- Change return text: `ext/zig/src/hellozig.zig`
- Add new PHP function: `ext/hello_zig.c` (function entry table + implementation)
- Add new Zig export and header declaration: `ext/zig/src/hellozig.zig` and `ext/zig/src/hellozig.h`
- Add regression test: `ext/tests/*.phpt`

## Troubleshooting

- `zig command not found`:
  - Pass explicit path: `ZIG=/absolute/path/to/zig ./configure --enable-hello-zig`
- Build errors after file moves:
  - Re-run from clean build dir: `phpize` then `./configure` then `make`
- Extension not loading:
  - Confirm `.so` exists at `ext/modules/hello_zig.so`
  - Use absolute path in `-dextension=...`
