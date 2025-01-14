drop PROCEDURE if exists UpdateInventory;

DELIMITER //
CREATE PROCEDURE UpdateInventory(item_of_interest_id VARCHAR(16))
BEGIN
    DECLARE period INT;
    SET period = 1;

    update_inventory_loop: LOOP
        IF period > 12 THEN
            LEAVE update_inventory_loop;
        END IF;

        update master_schedule as ms1, master_schedule ms2
		set ms1.projected_inventory = case 
										when  ms2.projected_inventory + ms2.planned_order_receipts - ms2.gross_requirements < 0 then 0
                                        else  ms2.projected_inventory + ms2.planned_order_receipts - ms2.gross_requirements
									  end
		where 1=1 
        and ms1.item_id = item_of_interest_id
        and ms1.period_number = period
        and ms2.item_id = ms1.item_id
        and ms2.period_number = period - 1;
        SET period = period + 1;
    END LOOP;
END;
//
DELIMITER ;