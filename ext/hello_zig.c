#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include "php.h"
#include "hellozig.h"

PHP_FUNCTION(hello_zig_hello)
{
  ZEND_PARSE_PARAMETERS_NONE();
  RETURN_STRING(hellozig_message());
}

ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO_EX(arginfo_hello_zig_hello, 0, 0, IS_STRING, 0)
ZEND_END_ARG_INFO()

static const zend_function_entry hello_zig_functions[] = {
  PHP_FE(hello_zig_hello, arginfo_hello_zig_hello)
  PHP_FE_END
};

zend_module_entry hello_zig_module_entry = {
  STANDARD_MODULE_HEADER,
  "hello_zig",
  hello_zig_functions,
  NULL,
  NULL,
  NULL,
  NULL,
  NULL,
  "0.1.0",
  STANDARD_MODULE_PROPERTIES
};

#ifdef COMPILE_DL_HELLO_ZIG
# ifdef ZTS
ZEND_TSRMLS_CACHE_DEFINE()
# endif
ZEND_GET_MODULE(hello_zig)
#endif
