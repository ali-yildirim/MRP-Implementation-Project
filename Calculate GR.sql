drop PROCEDURE if exists CalculateGR;

# update gross req.
DELIMITER //
CREATE PROCEDURE CalculateGR(item_of_interest_id VARCHAR(16))
BEGIN
    DECLARE period INT;
    declare lead_time int;
    declare master_item_id varchar(16);
    set master_item_id = GetItemID(item_of_interest_id);
    set lead_time = GetLeadTime(master_item_id);
    SET period = 1;
	
    # update the item GRs over each period
	update_gr_loop_period: LOOP
        
		# if all periods are updated then leave
		IF period > 12 THEN
			LEAVE update_gr_loop_period;
		END IF;
		# update the period GRs
		update master_schedule as ms1, master_schedule as ms2, bom, item
		set ms1.gross_requirements = ms2.planned_order_releases * bom.bom_multiplier
		where 1=1 
		and ms1.item_id = item_of_interest_id
		and bom.component_id = item_of_interest_id
        and ms2.period_number = period
		and ms2.item_id = bom.item_id
		and ms1.period_number = period;
		SET period = period + 1;
	END LOOP;
END;
//
DELIMITER ;
