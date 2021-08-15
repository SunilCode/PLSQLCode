MERGE INTO member_staging x
USING (SELECT member_id, first_name, last_name, rank FROM members) y
ON (x.member_id  = y.member_id)
WHEN MATCHED THEN
    UPDATE SET x.first_name = y.first_name, 
                        x.last_name = y.last_name, 
                        x.rank = y.rank
    WHERE x.first_name <> y.first_name OR 
           x.last_name <> y.last_name OR 
           x.rank <> y.rank 
WHEN NOT MATCHED THEN
    INSERT(x.member_id, x.first_name, x.last_name, x.rank)  
    VALUES(y.member_id, y.first_name, y.last_name, y.rank);