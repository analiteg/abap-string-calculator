CLASS zcl_string_summ DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.


CLASS zcl_string_summ IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    out->write( lcl_string_culc=>create_instance( )->summ_strings( iv_string_1 = '34534657656756556464645535434564897564789674876947964565442'
                                                                   iv_string_2 = '546577743336363335567865764333336333221254754755775374573575473576359646863575744' ) ).
  ENDMETHOD.
ENDCLASS.
