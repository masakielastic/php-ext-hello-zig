# php-ext-hello-zig

PHP extension example that calls a Zig function via C ABI and returns a string to PHP.

## Layout

- `ext`: extension build directory for PIE/phpize
- `ext/hello_zig.c`: extension source code
- `ext/zig`: Zig library source and `build.zig`
- `ext/tests`: phpt tests

## PIE metadata

`composer.json` is configured for PIE with:

- `type: php-ext`
- `php-ext.extension-name: hello_zig`
- `php-ext.build-path: ext`

## Build locally

Prerequisites:

- PHP development tools (`phpize`, headers)
- Zig available on PATH (or pass `ZIG=/path/to/zig`)

Commands:

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
