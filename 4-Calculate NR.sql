drop PROCEDURE if exists calculateNR;

DELIMITER //
CREATE PROCEDURE calculateNR(item_of_interest_id int)
BEGIN
    declare period int;
    SET period = 1;

    update_NR_loop: LOOP
        IF period > 12 THEN
            LEAVE update_NR_loop;
        END IF;

        update master_schedule as ms
		set ms.net_requirements = CASE 
									WHEN ms.gross_requirements - ms.scheduled_receipts - ms.projected_inventory < 0 THEN 0
									ELSE ms.gross_requirements - ms.scheduled_receipts - ms.projected_inventory 
								  END 
		where 1=1 
        and ms.item_id = item_of_interest_id
        and ms.period_number = period;
        SET period = period + 1;
    END LOOP;
END;
//
DELIMITER ;
