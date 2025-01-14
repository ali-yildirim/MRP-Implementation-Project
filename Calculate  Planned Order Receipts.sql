drop PROCEDURE if exists CalculatePlannedOrderReceipts;

DELIMITER //
CREATE PROCEDURE CalculatePlannedOrderReceipts(item_of_interest_id VARCHAR(16))
BEGIN
    DECLARE period INT;
    SET period = 1;

    update_PlannedOrderReceipts_loop: LOOP
        IF period > 12 THEN
            LEAVE update_PlannedOrderReceipts_loop;
        END IF;

        update master_schedule as ms1, master_schedule as ms2, item i
		set ms1.planned_order_receipts =  case 
											when ms1.net_requirements = 0 then 0
											else CEIL((ms1.net_requirements + ms2.projected_inventory) / (i.lot_size)) * i.lot_size
										  end
		where 1=1 
        and ms1.item_id = item_of_interest_id
		and ms2.item_id = ms1.item_id
        and i.item_id = ms1.item_id
        and ms1.period_number = period
        and ms2.period_number = period + 1;
        SET period = period + 1;
    END LOOP;
END;
//
DELIMITER ;