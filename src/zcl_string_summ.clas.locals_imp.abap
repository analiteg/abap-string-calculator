CLASS lcl_string_culc DEFINITION CREATE PRIVATE.

  PUBLIC SECTION.
    METHODS allign_strings
      IMPORTING  iv_str_1 TYPE string
                 iv_str_2 TYPE string

      EXPORTING  ev_str_1 TYPE string
                 ev_str_2 TYPE string
                ev_length TYPE i OPTIONAL .

    METHODS sum_strings
      IMPORTING iv_string_1   TYPE string
                iv_string_2   TYPE string

      RETURNING VALUE(rv_str) TYPE string.

    CLASS-METHODS create_instance
      RETURNING VALUE(ro_instance) TYPE REF TO lcl_string_culc.

  PRIVATE SECTION.
    CLASS-DATA lo_instance TYPE REF TO lcl_string_culc.

    " not a requirement  DATA buf  TYPE string.
    DATA numb TYPE i VALUE 0.

    CONSTANTS : lci_ten 	TYPE i VALUE 10 .
    CONSTANTS : lci_zero 	TYPE i VALUE 0 .
    CONSTANTS : lci_one 	TYPE i VALUE 1 .
    CONSTANTS : lcs_zero 	TYPE string VALUE `0` .

ENDCLASS.


CLASS lcl_string_culc IMPLEMENTATION.
  METHOD create_instance.
    ro_instance = COND #( WHEN ro_instance IS BOUND
                          THEN ro_instance
                          ELSE NEW lcl_string_culc( ) ).
  ENDMETHOD.

  METHOD allign_strings.
    FIELD-SYMBOLS: <fs_buf> . 

    ev_str_1 = iv_str_1 .
    ev_str_2 = iv_str_2 .

    DATA(chars_1)   = strlen( ev_str_1 ) .
    DATA(chars_2)   = strlen( ev_str_2 ) .
    DATA(char_diff) = chars_1 - chars_2 .
    ev_length       = nmax( chars_1, chars_2 ) .

    IF char_diff = lci_zero .			    " eq
      return.
    ELSEIF char_diff > lci_zero . 		" The second string is the shortest.  
      ASSIGN ev_str_2 TO <fs_buf> .
    ELSE.				                      " The first string is the shortest.
      ASSIGN ev_str_1 TO <fs_buf> .
    ENDIF.

    <fs_buf> = |{ <fs_buf> WIDTH = ev_length ALIGN = RIGHT PAD = lcs_zero }| .

  ENDMETHOD.

  METHOD sum_strings.
    allign_strings( EXPORTING  iv_str_1 = iv_string_1
                               iv_str_2 = iv_string_2

                    IMPORTING  ev_str_1 = DATA(ev_string_1)
                               ev_str_2 = DATA(ev_string_2)
                              ev_length = DATA(lv_length) ).

    lv_length = lv_length - lci_one.
    DATA(buf) = `` .
    TRY.
        WHILE lv_length >= lci_zero.

          DATA(i_1) = CONV i( ev_string_1+lv_length(lci_one) ).
          DATA(i_2) = CONV i( ev_string_2+lv_length(lci_one) ).

          DATA(summ) = i_1 + i_2 + numb.

          IF ( summ ) < lci_ten.
            numb = lci_zero.
          ELSE.
            summ = ( summ ) MOD lci_ten.
            numb = lci_one.
          ENDIF.

          DATA(summ_str) = CONV string( summ ).
	  DATA(buf) = insert( val = buf
	                      sub = summ_str ).

          lv_length -= lci_one.

        ENDWHILE.
      CATCH cx_root INTO DATA(lr_exc).
        str_summ = 'error'.
    ENDTRY.
    CONDENSE str_summ NO-GAPS.
    rv_str = str_summ.
  ENDMETHOD.
ENDCLASS.
