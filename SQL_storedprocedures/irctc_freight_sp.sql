create PROCEDURE sp_irctc_freight_select_delete
@b_id INT,
@RecordStatus BIT,
@modifiedBy VARCHAR(50),
@StatementType NVARCHAR(20) = ''
AS
  BEGIN

      IF @StatementType = 'Select'
        BEGIN
            SELECT *
            FROM   irctc_freight where b_id = @b_id;
        END
      ELSE IF @StatementType = 'Delete'
        BEGIN
		    UPDATE irctc_freight SET RecordStatus=@RecordStatus,modifiedBy=@modifiedBy WHERE b_id = @b_id;
           
        END
  END
  
DROP PROCEDURE sp_irctc_freight_select_delete

CREATE PROCEDURE sp_irctc_freight_insert_update	     (@b_id int,
@user_id int, 
@freight_name varchar(50),
@freight_type varchar(20),
@from_place varchar(50),
@to_place varchar(50),
@departure varchar(50),
@arrival varchar(50),
@StatementType NVARCHAR(20) = '')
AS
  BEGIN
      IF @StatementType = 'Insert'
        BEGIN
            INSERT INTO irctc_freight
                        (b_id,user_id, 
freight_name,
freight_type,
from_place,
to_place,
departure,
arrival)
            VALUES     ( @b_id,
                         @user_id,
                         @freight_name,
                         @freight_type,
                         @from_place,
						 @to_place,
						 @departure,
						 @arrival)
        END

      ELSE IF @StatementType = 'Update'
        BEGIN
            UPDATE irctc_freight
            SET    b_id =@b_id,
user_id=@user_id, 
freight_name=@freight_name,
freight_type=@freight_type,
from_place=@from_place,
to_place=@to_place,
departure=@departure,
arrival=@arrival
            WHERE  b_id = @b_id
        END
  END

execute sp_irctc_freight_select_delete 100,1,'Select';

CREATE PROCEDURE sp_irctc_freight_selectlist
AS
  BEGIN
            SELECT * FROM irctc_freight;
  END

  
CREATE PROCEDURE sp_irctc_freight_selectinactive
AS
  BEGIN
            SELECT *
            FROM   irctc_freight where RecordStatus=0;
        END
CREATE PROCEDURE sp_irctc_freight_selectactive
AS
  BEGIN
            SELECT *
            FROM   irctc_freight where RecordStatus=1;
        END

execute sp_irctc_freight_selectlist
--freight_type
CREATE PROCEDURE sp_irctc_freighttype_selectlist
AS
  BEGIN
            SELECT * FROM freight_type;
  END
  CREATE PROCEDURE sp_irctc_freighttype_select
  @freight_type_id int
AS
  BEGIN
            SELECT * FROM freight_type where freight_type_id=@freight_type_id;
  END
  CREATE PROCEDURE sp_irctc_freighttype_insert
  (@freight_type_id int,
  @freight_type varchar(50))
AS
  BEGIN
            INSERT INTO freight_type
                        (freight_type_id,
freight_type)
            VALUES     ( @freight_type_id,
                         @freight_type);
  END
  CREATE PROCEDURE sp_irctc_freighttype_delete
  (@freight_type_id int,
  @RecordStatus BIT)
AS
  BEGIN
            UPDATE freight_type
          SET    RecordStatus=@RecordStatus
            WHERE freight_type_id = @freight_type_id;
  END
  CREATE PROCEDURE sp_irctc_freighttype_update
  (@freight_type_id int,
  @freight_type varchar(50))
AS
  BEGIN
            UPDATE freight_type
            SET    freight_type_id =@freight_type_id,
freight_type=@freight_type
            WHERE  freight_type_id = @freight_type_id
  END