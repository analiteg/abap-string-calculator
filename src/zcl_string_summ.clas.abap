CLASS zcl_string_summ DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.


CLASS zcl_string_summ IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    out->write( lcl_string_culc=>create_instance( )->sum_strings(
    iv_string_1 = '999999'
    iv_string_2 = '2'
    ) ).
  ENDMETHOD.
ENDCLASS.



