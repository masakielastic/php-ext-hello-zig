PHP_ARG_ENABLE([hello_zig],
  [whether to enable hello_zig support],
  [AS_HELP_STRING([--enable-hello-zig], [Enable hello_zig extension])],
  [no])

if test "$PHP_HELLO_ZIG" != "no"; then
  AC_ARG_VAR([ZIG], [Path to the Zig compiler])
  if test -z "$ZIG"; then
    AC_PATH_PROG([ZIG], [zig], [no])
  fi
  if test "$ZIG" = "no"; then
    AC_MSG_ERROR([zig command not found. Please install Zig to build hello_zig.])
  fi

  PHP_NEW_EXTENSION([hello_zig], [hello_zig.c], [$ext_shared])

  HELLO_ZIG_DIR="$abs_srcdir/zig"
  HELLO_ZIG_LIBDIR="$HELLO_ZIG_DIR/zig-out/lib"

  AC_MSG_CHECKING([for Zig static library libhellozig.a])
  if test ! -f "$HELLO_ZIG_LIBDIR/libhellozig.a"; then
    AC_MSG_RESULT([not found])
    AC_MSG_NOTICE([building Zig static library with zig build])
    (
      cd "$HELLO_ZIG_DIR" || exit 1
      "$ZIG" build
    ) || AC_MSG_ERROR([zig build failed])
  else
    AC_MSG_RESULT([found])
  fi

  PHP_ADD_INCLUDE([$HELLO_ZIG_DIR/zig-out/include])
  PHP_ADD_LIBRARY_WITH_PATH([hellozig], [$HELLO_ZIG_LIBDIR], [HELLO_ZIG_SHARED_LIBADD])
  PHP_SUBST([HELLO_ZIG_SHARED_LIBADD])
fi
