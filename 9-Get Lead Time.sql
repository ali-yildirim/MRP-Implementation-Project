drop FUNCTION if exists GetLeadTime;

DELIMITER //
CREATE FUNCTION GetLeadTime(item_of_interest_id VARCHAR(16))
	RETURNS INT
    DETERMINISTIC
	READS SQL DATA
	BEGIN
		DECLARE LT INT;
		SET LT = (	SELECT item.lead_time
					FROM item
					WHERE item.item_id = item_of_interest_id);
		RETURN LT;
	END //
DELIMITER ;
