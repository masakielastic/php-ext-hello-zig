--TEST--
hello_zig_hello returns message from Zig
--SKIPIF--
<?php
if (!extension_loaded('hello_zig')) {
    echo 'skip hello_zig extension not loaded';
}
?>
--FILE--
<?php
var_dump(hello_zig_hello());
?>
--EXPECT--
string(25) "Hello World from Zig FFI!"
