# PHP Hello Zig Extension Development Plan

## Goal
Build a PHP extension (`hello_zig`) that calls a Zig-compiled C ABI function and returns `Hello World` to PHP users.

## Scope
- Manage extension source code under `ext`
- Build Zig static library with `ext/zig/build.zig`
- Link Zig output into PHP extension build
- Make package installable with PIE via `composer.json`

## Milestones
1. Project scaffolding
- Prepare `composer.json` for PIE (`type: php-ext`, `php-ext.build-path`)
- Set PIE build path to `ext`
- Create extension source tree under `ext`

2. Zig FFI layer
- Implement C ABI function in Zig (`hellozig_message`)
- Provide C header (`hellozig.h`)
- Add `build.zig` to produce static library (`libhellozig.a`) and install headers

3. PHP extension layer
- Implement `hello_zig_hello()` PHP function in C
- Call Zig C ABI function and return string to PHP
- Register extension metadata and function entry table

4. Build integration
- Add `config.m4` to compile extension and link Zig static library
- Trigger Zig build during configure when artifact is missing

5. Verification
- Build: `phpize && ./configure --enable-hello-zig && make`
- Runtime: `php -dextension=modules/hello_zig.so -r 'echo hello_zig_hello(), PHP_EOL;'`
- Expected output: `Hello World from Zig FFI!`

## Risks and Mitigations
- Zig binary missing: fail early in `config.m4` with explicit message
- ABI mismatch: enforce C ABI with Zig `export` and C header
- Header include path issues: install header path from Zig and add include path in `config.m4`

## Future Enhancements
- Add `config.w32` for Windows build support
- Add CI matrix (PHP 8.1/8.2/8.3, Zig stable)
- Add phpt tests for extension behavior
