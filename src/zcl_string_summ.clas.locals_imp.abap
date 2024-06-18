CLASS lcl_string_culc DEFINITION CREATE PRIVATE.

  PUBLIC SECTION.
    METHODS allign_strings
      IMPORTING iv_str_1 TYPE string
                iv_str_2 TYPE string

      EXPORTING ev_str_1 TYPE string
                ev_str_2 TYPE string.

    METHODS summ_strings
      IMPORTING iv_string_1   TYPE string
                iv_string_2   TYPE string

      RETURNING VALUE(rv_str) TYPE string.

    CLASS-METHODS create_instance
      RETURNING VALUE(ro_instance) TYPE REF TO lcl_string_culc.

  PRIVATE SECTION.
    CLASS-DATA lo_instance TYPE REF TO lcl_string_culc.

    DATA buf  TYPE string.
    DATA numb TYPE i VALUE 0.

ENDCLASS.


CLASS lcl_string_culc IMPLEMENTATION.
  METHOD create_instance.
    ro_instance = COND #( WHEN ro_instance IS BOUND
                          THEN ro_instance
                          ELSE NEW lcl_string_culc( ) ).
  ENDMETHOD.

  METHOD allign_strings.
    DATA(str_1) = iv_str_1.
    DATA(str_2) = iv_str_2.
    DATA(char_diff) = strlen( str_1 ) - strlen( str_2 ).

    IF char_diff > 0.
      buf = str_2.
      DO abs( char_diff ) TIMES.
        DATA(str_2_final) = insert( val = buf
                                    sub = `0` ).
        buf = str_2_final.
      ENDDO.
    ELSE.
      buf = str_1.
      DO abs( char_diff ) TIMES.
        DATA(str_1_final) = insert( val = buf
                                    sub = `0` ).
        buf = str_1_final.
      ENDDO.
    ENDIF.

    IF str_2_final IS NOT INITIAL.
      ev_str_2 = str_2_final.
    ELSE.
      ev_str_2 = str_2.
    ENDIF.

    IF str_1_final IS NOT INITIAL.
      ev_str_1 = str_1_final.
    ELSE.
      ev_str_1 = str_1.
    ENDIF.
  ENDMETHOD.

  METHOD summ_strings.
    allign_strings( EXPORTING iv_str_1 = iv_string_1
                              iv_str_2 = iv_string_2

                    IMPORTING ev_str_1 = DATA(ev_string_1)
                              ev_str_2 = DATA(ev_string_2) ).

    DATA(lv_length) = strlen( ev_string_1 ) - 1.
    CLEAR buf.
    TRY.
        WHILE lv_length >= 0.

          DATA(i_1) = CONV i( ev_string_1+lv_length(1) ).
          DATA(i_2) = CONV i( ev_string_2+lv_length(1) ).

          DATA(summ) = i_1 + i_2 + numb.

          IF ( summ ) < 10.
            DATA(summ_str) = CONV string( summ ).
            DATA(str_summ) = insert( val = buf
                                     sub = summ_str ).
            buf = str_summ.
            numb = 0.
          ELSE.
            summ_str = ( summ ) MOD 10.
            str_summ = insert( val = buf
                               sub = summ_str ).
            buf = str_summ.
            numb = 1.
          ENDIF.

          lv_length -= 1.

        ENDWHILE.
      CATCH cx_root INTO DATA(lr_exc). " TODO: variable is assigned but never used (ABAP cleaner)
        str_summ = 'error'.
    ENDTRY.

    rv_str = str_summ.
  ENDMETHOD.
ENDCLASS.
