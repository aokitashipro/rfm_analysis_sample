select `kana`, max(c_in) as recent_date, datediff( CURRENT_DATE(), max(c_in)) as recency, count(c_in) as frequency, sum(sum_price) as monetary
	
,(case	
	when ( datediff( CURRENT_DATE(), max(c_in)) < 31 ) then 5
	when ( datediff( CURRENT_DATE(), max(c_in)) < 91 ) then 4
	when ( datediff( CURRENT_DATE(), max(c_in)) < 181 ) then 3
	when ( datediff( CURRENT_DATE(), max(c_in)) < 361 ) then 2
	else 1
end) as r	

,(case	
	when ( 10 <= count(c_in) ) then 5
	when ( 7 <= count(c_in) ) then 4
	when ( 5 <= count(c_in) ) then 3
	when ( 2 <= count(c_in) ) then 2
	else 1
end) as f	
	
,(case	
	when ( 100000 <= sum(sum_price) ) then 5
	when ( 50000 <= sum(sum_price) ) then 4
	when ( 30000 <= sum(sum_price) ) then 3
	when ( 10000 <= sum(sum_price) ) then 2
	else 1
end) as m	
	from
	(
	select replace(replace(`�������`,' ',''), '�@','') as kana
	, sum(���v����) as sum_price
	, date(�`�F�b�N�C����) as c_in
	,`�v��������`
	,`��l�l��`
	,`�q���l��`
	from `sample_table`
	group by kana, date(�`�F�b�N�C����)
	) AS rm
	
group by rm.kana
