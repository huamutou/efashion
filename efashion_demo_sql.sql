
-- show Dimension View.
select * from "_SYS_BIC"."eFashion/ARTICLE";


-- update efashion/efashion_result.quantity_sold( 10 times)
update "EFASHION"."SHOP_FACTS" set "QUANTITY_SOLD" = "QUANTITY_SOLD" * 10;
update "EFASHION"."SHOP_FACTS" set "QUANTITY_SOLD" = "QUANTITY_SOLD" / 10;

-- update efashion/efashion_result.quantity_sold( 10 times) 
update "EFASHION"."SHOP_FACTS" set "QUANTITY_SOLD" = "QUANTITY_SOLD" * 10
	where article_id = 138627 and color_code = 619 and shop_id = 203 and week_id = 247;
update "EFASHION"."SHOP_FACTS" set "QUANTITY_SOLD" = "QUANTITY_SOLD" / 10
	where article_id = 138627 and color_code = 619 and shop_id = 203 and week_id = 247;

-- show cube data
select * from "_SYS_BIC"."eFashion/EFASHION_RESULT";

-- MDX
MDX
select 
	{ [Measures].["_SYS_BIC"."eFashion/EFASHION_RESULT" ], [Measures].[] } on columns,
	{ [].[], [].[] } on rows
from "_SYS_BIC"."eFashion/EFASHION_RESULT"
where

-- show cube data
SELECT
	 "ARTICLE_ID",
	 "ARTICLE_LABEL",
	 "CATEGORY_ID",
	 "CATEGORY",
	 "FAMILY_CODE",
	 "FAMILY_NAME",
	 "ARTICLE_COLOR_ARTICLE_ID",
	 "COLOR_CODE",
	 "ARTICLE_COLOR_ARTICLE_LABEL",
	 "COLOR_LABEL",
	 "SHOP_ID",
	 "SHOP_NAME",
	 "CITY",
	 "STATE",
	 "WEEK_ID",
	 "YERA_WEEK",
	 "MTH",
	 "QTR",
	 "YR",
	 "COLOR_CODE_1",
	 "WEEK_ID_1",
	 "SHOP_ID_1",
	 "ARTICLE_ID_1",
	 sum("MARGIN") AS "MARGIN",
	 sum("AMOUNT_SOLD") AS "AMOUNT_SOLD",
	 sum("QUANTITY_SOLD") AS "QUANTITY_SOLD" 
FROM "_SYS_BIC"."eFashion/EFASHION_RESULT" 
GROUP BY "ARTICLE_ID",
	 "ARTICLE_LABEL",
	 "CATEGORY_ID",
	 "CATEGORY",
	 "FAMILY_CODE",
	 "FAMILY_NAME",
	 "ARTICLE_COLOR_ARTICLE_ID",
	 "COLOR_CODE",
	 "ARTICLE_COLOR_ARTICLE_LABEL",
	 "COLOR_LABEL",
	 "SHOP_ID",
	 "SHOP_NAME",
	 "CITY",
	 "STATE",
	 "WEEK_ID",
	 "YERA_WEEK",
	 "MTH",
	 "QTR",
	 "YR",
	 "COLOR_CODE_1",
	 "WEEK_ID_1",
	 "SHOP_ID_1",
	 "ARTICLE_ID_1"
