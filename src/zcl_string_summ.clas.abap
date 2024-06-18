CLASS zcl_string_summ DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.


CLASS zcl_string_summ IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA(str_1) = '125'.
    DATA(str_2) = '26'.
    DATA(char_diff) = strlen( str_1 ) - strlen( str_2 ).
    DATA buf  TYPE string.
    DATA numb TYPE i VALUE 0.

    IF char_diff > 0.
      buf = str_2.
      DO abs( char_diff ) TIMES.
        DATA(str_2_final) = insert( val = buf sub = '0' ).
        buf = str_2_final.
      ENDDO.
    ELSE.
      buf = str_1.
      DO abs( char_diff ) TIMES.
        DATA(str_1_final) = insert( val = buf sub = '0' ).
        buf = str_1_final.
      ENDDO.
    ENDIF.

    IF str_2_final IS NOT INITIAL.
      DATA(string_2) = str_2_final.
    ELSE.
      string_2 = str_2.
    ENDIF.

    IF str_1_final IS NOT INITIAL.
      DATA(string_1) = str_1_final.
    ELSE.
      string_1 = str_1.
    ENDIF.

    DATA(lv_length) = strlen( string_1 ) - 1.
    CLEAR buf.

    WHILE lv_length >= 0.

      DATA(i_1) = CONV i( string_1+lv_length(1) ).
      DATA(i_2) = CONV i( string_2+lv_length(1) ).
      DATA(summ) = i_1 + i_2 + numb.
      IF ( summ ) < 10.
        DATA(summ_str) = CONV string( summ ).
        DATA(str_summ) = insert( val = buf sub = summ_str ).
        buf = str_summ.
        numb = 0.
      ELSE.
        summ_str = ( summ ) MOD 10.
        str_summ = insert( val = buf sub = summ_str ).
        buf = str_summ.
        numb = 1.
      ENDIF.

      lv_length -= 1.
    ENDWHILE.

    out->write( str_summ ).
  ENDMETHOD.
ENDCLASS.
