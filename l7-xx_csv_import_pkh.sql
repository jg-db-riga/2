CREATE OR REPLACE PACKAGE  XX_CSV_IMPORT_PKG
IS
    PROCEDURE log_error(p_msg VARCHAR2);

    PROCEDURE insert_header(p_header_rec xx_orders%ROWTYPE);

    PROCEDURE insert_line(p_line_rec xx_order_lines%ROWTYPE);

    PROCEDURE IMPORT_CSV(p_file_name VARCHAR2, p_dir VARCHAR2);
END;    