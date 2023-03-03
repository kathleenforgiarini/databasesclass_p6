SPOOL C:\BD2\Project6Q4.txt
SELECT to_char(sysdate, 'DD Month YYYY HH:MI:SS') FROM dual;

SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE p6question4 AS
CURSOR item_curr IS
SELECT i.item_id, item_desc , cat_id, sum(inv_price*inv_qoh) AS value
FROM item i, inventory inv
WHERE i.item_id = inv.item_id
GROUP BY i.item_id, item_desc, cat_id
ORDER BY i.item_id;
v_item_id item.item_id%TYPE;
v_item_desc item.item_desc%TYPE;
v_cat_id item.cat_id%TYPE;
v_value NUMBER;

CURSOR inv_curr (pc_item_id item.item_id%TYPE) IS
SELECT inv_id, inv_price, inv_qoh
FROM inventory
WHERE item_id= pc_item_id;
v_inv_id inventory.inv_id%TYPE;
v_inv_price inventory.inv_price%TYPE;
v_inv_qoh inventory.inv_qoh%TYPE;

BEGIN
OPEN item_curr;
FETCH item_curr INTO v_item_id, v_item_desc, v_cat_id, v_value;
WHILE item_curr%FOUND
LOOP
DBMS_OUTPUT.PUT_LINE('Item id: '|| v_item_id ||', ' || v_item_desc ||', total value $' || v_value || '. Category id: '||v_cat_id);
OPEN inv_curr (v_item_id);
FETCH inv_curr INTO v_inv_id, v_inv_price, v_inv_qoh;
WHILE inv_curr%FOUND
LOOP
DBMS_OUTPUT.PUT_LINE('Inventory id: '|| v_inv_id ||', price $'||v_inv_price||', quantity: '|| v_inv_qoh||'.');
FETCH inv_curr INTO v_inv_id, v_inv_price, v_inv_qoh;
END LOOP;
CLOSE inv_curr;
FETCH item_curr INTO v_item_id, v_item_desc, v_cat_id, v_value;
END LOOP;
CLOSE item_curr;
END;
/
EXEC p6question4;

Spool off;