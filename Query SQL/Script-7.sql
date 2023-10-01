CREATE OR REPLACE FUNCTION UpdateShipmentID()
RETURNS VOID AS $$
DECLARE 
    done BOOLEAN DEFAULT FALSE;
    shipment_id_counter INT DEFAULT 1;
    current_sending_time TIMESTAMP;
    new_shipment_id VARCHAR(10);
    
    -- Cursor untuk mengambil data dengan SendingTime tidak null
    cur CURSOR FOR
        SELECT sending_time
        FROM delivery
        WHERE sending_time IS NOT NULL;
    
BEGIN
    OPEN cur;
    
    LOOP
        FETCH cur INTO current_sending_time;
        EXIT WHEN NOT FOUND;
        
        -- Menghasilkan nilai ShipmentID dengan format yymmdd01, yymmdd02, dst.
        new_shipment_id := TO_CHAR(current_sending_time, 'YYMMDD') || to_char(shipment_id_counter, 'FM00');
        
        -- Menyimpan nilai ShipmentID ke dalam kolom ShipmentID
        UPDATE delivery 
        SET shipment_id = new_shipment_id
        WHERE sending_time = current_sending_time;
        
        -- Increment counter ShipmentID
        shipment_id_counter := shipment_id_counter + 1;
    END LOOP;
    
    CLOSE cur;
    
    RETURN;
EXCEPTION
    WHEN OTHERS THEN
        -- Tangani kesalahan jika terjadi
        RAISE WARNING 'Error in UpdateShipmentID(): %', SQLERRM;
        RETURN;
END;
$$ LANGUAGE PLpgSQL;


