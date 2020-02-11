#include <stdlib.h>
#include <ruby.h>
#include <ruby/encoding.h>
#include "ulid.h"


static VALUE m_ULID;


void
rb_ulid_generator_mark (void *_self)
{
  /*
   * This function is not needed becaue there is no malloc() or
   * pointers to other VALUE objects.
   * However, to help others understand how Ruby C extensions
   * work I've left it here.
   *
    struct ulid_generator *ug;

    TypedData_Get_Struct(self, struct ulid_generator, &UlidGeneratorType, ug);

    rb_gc_mark(ug->thing);
    rb_gc_mark(ug->other_thing);
  */
}

void
rb_ulid_generator_free (void *_self)
{
  // Not needed. We do not malloc() here or in the ulid lib
  // free(_self);
}

static const rb_data_type_t UlidGeneratorType = {
    "UlidGenerator",
    { rb_ulid_generator_mark, rb_ulid_generator_free, NULL }
};

static VALUE
rb_ulid_generate(VALUE self)
{
  struct ulid_generator *ug;

  TypedData_Get_Struct(self, struct ulid_generator, &UlidGeneratorType, ug);
  char ulid[27];

  ulid_generate(ug, ulid);

  return rb_utf8_str_new(ulid, 26);
}

static VALUE
rb_ulid_alloc(VALUE self)
{
  struct ulid_generator *ug;
  VALUE obj;
  obj = TypedData_Make_Struct(self, struct ulid_generator, &UlidGeneratorType, ug);

  int ret = ulid_generator_init(ug, ULID_SECURE);

  if (ret != 0)
    rb_raise(rb_eRuntimeError, "ulid_generator_init failure");

  return obj;
}

// TODO ..
/*
static VALUE
rb_ulid_each(int argc, VALUE* argv, VALUE self)
{
  // return rb_funcall(self, rb_intern("to_enum"), 2, rb_intern("generate"), self,);

  return Qnil;
}
*/

void
Init_ulid_fast() {
  m_ULID = rb_define_module("ULID");
    
  VALUE cls = rb_define_class_under(m_ULID, "Generator", rb_cObject);
  // rb_include_module(m_ULID, rb_mEnumerable);
  rb_define_alloc_func(cls, rb_ulid_alloc);
  rb_define_method(cls, "generate", rb_ulid_generate, 0);
  //rb_define_method(cls, "each", rb_ulid_each, -1);
}
