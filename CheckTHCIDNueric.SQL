Numeric only with Thai National ID (SQL Server)

SQL
--------------------

select data.* from (
select
 Personal_ID,
 ASCII(substring(T.Personal_ID,1,1) ) as no1,
 ASCII(substring(T.Personal_ID,2,1) )  as no2,
 ASCII(substring(T.Personal_ID,3,1) )  as no3,
 ASCII(substring(T.Personal_ID,4,1) )  as no4,

 ASCII(substring(T.Personal_ID,5,1) ) as no5,
 ASCII(substring(T.Personal_ID,6,1) ) as no6,
 ASCII(substring(T.Personal_ID,7,1) ) as no7,
 ASCII(substring(T.Personal_ID,8,1) ) as no8,

 ASCII(substring(T.Personal_ID,9,1)  )as no9,
 ASCII(substring(T.Personal_ID,10,1) )as no10,
 ASCII(substring(T.Personal_ID,11,1) )as no11,
 ASCII(substring(T.Personal_ID,12,1) )as no12,

 ASCII(substring(T.Personal_ID,13,1) ) checkdigit
 from Guide T
 where T.Personal_ID is not null and len(T.Personal_ID)=13 ) data
where
data.no1 > 57 or
data.no2 > 57 or
data.no3 > 57 or
data.no4 > 57 or

data.no5 > 57 or
data.no6 > 57 or
data.no7 > 57 or
data.no8 > 57 or

data.no9 > 57 or
data.no10 > 57 or
data.no11 > 57 or
data.no12 > 57 or

data.checkdigit > 57
