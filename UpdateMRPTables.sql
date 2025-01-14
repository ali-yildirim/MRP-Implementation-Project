DELIMITER //

CREATE PROCEDURE UpdateMRPTables()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE current_item_id VARCHAR(16);

    -- Declare a cursor to fetch item_id from the item table
    DECLARE item_cursor CURSOR FOR
    SELECT item_id FROM item;

    -- Declare a handler for the end of the cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Open the cursor
    OPEN item_cursor;

    -- Cursor loop
    item_loop: LOOP
        FETCH item_cursor INTO current_item_id;

        -- Exit loop if no more rows
        IF done THEN
            LEAVE item_loop;
        END IF;

        -- Perform some operation with the current item_id
		call CalculateGR(current_item_id);
        call UpdateInventory(current_item_id);
		call calculateNR(current_item_id);
		call CalculatePlannedOrderReceipts(current_item_id);
		call CalculatePlannedOrderReleases(current_item_id);
		call UpdateInventory(current_item_id);

    END LOOP;

    -- Close the cursor
    CLOSE item_cursor;
END;
//
DELIMITER ;




call UpdateMRPTables();

