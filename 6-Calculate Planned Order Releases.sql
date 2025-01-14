drop PROCEDURE if exists CalculatePlannedOrderReleases;

DELIMITER //
CREATE PROCEDURE CalculatePlannedOrderReleases(item_of_interest_id VARCHAR(16))
BEGIN
    DECLARE period INT;
    declare lead_time int;
    set lead_time = GetLeadTime(item_of_interest_id);
    SET period = 1;

    update_PlannedOrderReceipts_loop: LOOP
        IF period > 12 THEN
            LEAVE update_PlannedOrderReceipts_loop;
        END IF;

        update master_schedule as ms1, master_schedule as ms2
		set ms1.planned_order_releases =  ms2.planned_order_receipts
		where 1=1 
        and ms1.item_id = item_of_interest_id
        and ms2.item_id = item_of_interest_id
        and ms2.period_number = period
        and ms1.period_number = period - lead_time;
        SET period = period + 1;
    END LOOP;
END;
//
DELIMITER ;
