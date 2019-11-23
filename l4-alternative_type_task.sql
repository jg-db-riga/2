1. Create a procedure, which would have 5 incoming parameters: p_name VARCHAR2, p_street VARCHAR2, p_city VARCHAR2, p_state VARCHAR2, p_zip VARCHAR2
2. Procedure should set passed street-zip values to address_type (custom type created in lecture 3) object variable
3. INSERT new ercord to XX_TYPE_TEST table (created in lecture 3)
4. COMMIT trnsaction

	Hint: declaration section of your procedure should containt:
		TYPE address_type_tbl IS TABLE OF address_type  index by binary_integer;
		l_address_type address_type_tbl;
	-- Try to understand logic behind that code

	Hint: body section of your procedure should contain:
	1. Object constructor to set attributes as null
		l_address_type(1) := address_type(null, null, null, null);

	2. Custom type attributes values assignment:
		l_address_type(1).street := p_name;
		l_address_type(1).city := p_city;
		l_address_type(1).state := p_state;
		l_address_type(1).zip := p_zip;

	3. Insert statement to XX_TYPE_TEST
		INSERT INTO xx_type_test
		VALUES (p_name, l_address_type(1));

	4. COMMIT statement
	-- Try to understand logic behind that code

5. Make a declare PL/SQL block to test new created procedure by passing different values

