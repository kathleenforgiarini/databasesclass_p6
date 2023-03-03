SPOOL C:\BD2\Project6Q3.txt
SELECT to_char(sysdate, 'DD Month YYYY HH:MI:SS') FROM dual;

SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE p6question3 AS
CURSOR item_curr IS
SELECT item_id, item_desc, cat_id
FROM item;

v_item_id item.item_id%TYPE;
v_item_desc item.item_desc%TYPE;
v_cat_id item.cat_id%TYPE;

CURSOR inv_curr (pc_item_id item.item_id%TYPE) IS
SELECT inv_id, color, inv_size, inv_price, inv_qoh
FROM inventory
WHERE item_id = pc_item_id;
v_inv_id inventory.inv_id%TYPE;
v_color inventory.color%TYPE;
v_inv_size inventory.inv_size%TYPE;
v_inv_price inventory.inv_price%TYPE;
v_inv_qoh inventory.inv_qoh%TYPE;

BEGIN
OPEN item_curr;
FETCH item_curr INTO v_item_id, v_item_desc, v_cat_id;
WHILE item_curr%FOUND LOOP
DBMS_OUTPUT.PUT_LINE('Item '|| v_item_id ||
' is ' || v_item_desc ||', with the category '||v_cat_id);
OPEN inv_curr(v_item_id);
FETCH inv_curr INTO v_inv_id, v_color, v_inv_size, v_inv_price, v_inv_qoh;
WHILE inv_curr%FOUND LOOP 
DBMS_OUTPUT.PUT_LINE('Inventory '|| v_inv_id ||
' is color ' || v_color ||', size '||v_inv_size|| '. Its price is: $'|| v_inv_price || '. Quantity of: ' || v_inv_qoh);
FETCH inv_curr INTO v_inv_id, v_color, v_inv_size, v_inv_price, v_inv_qoh;
END LOOP;
CLOSE inv_curr;
FETCH item_curr INTO v_item_id, v_item_desc, v_cat_id;
END LOOP;
CLOSE item_curr;
END;
/

exec p6question3;

Spool off;
