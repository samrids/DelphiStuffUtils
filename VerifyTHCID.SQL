วิธีเช็ค เลข 13 หลักของบัตรประชาชนไทย (SQL Server)

select data.tax_id,
case when data.caldigit > 9 then data.caldigit - 10 else data.caldigit end caldigit,
data.checkdigit,
case when case when data.caldigit > 9 then data.caldigit - 10 else data.caldigit end = data.checkdigit then 'OK' else 'Err' End ChkState
from (
 select T.tax_id,
 11-(
 (cast(substring(T.tax_id,1,1) as integer) * 13 +
 cast(substring(T.tax_id,2,1) as integer) * 12 +
 cast(substring(T.tax_id,3,1) as integer) * 11 +
 cast(substring(T.tax_id,4,1) as integer) * 10 +

 cast(substring(T.tax_id,5,1) as integer) * 9 +
 cast(substring(T.tax_id,6,1) as integer) * 8 +
 cast(substring(T.tax_id,7,1) as integer) * 7 +
 cast(substring(T.tax_id,8,1) as integer) * 6 +

 cast(substring(T.tax_id,9,1)  as integer) * 5 +
 cast(substring(T.tax_id,10,1) as integer) * 4 +
 cast(substring(T.tax_id,11,1) as integer) * 3 +
 cast(substring(T.tax_id,12,1) as integer) * 2 )
  % 11) caldigit ,

 cast(substring(T.tax_id,13,1) as integer)  checkdigit
 from wht_data T
 where T.tax_id is not null and len(T.tax_id)=13) data
--where case when data.caldigit > 9 then data.caldigit - 10 else data.caldigit end <> data.checkdigit
