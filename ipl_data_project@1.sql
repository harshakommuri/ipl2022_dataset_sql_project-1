create database ipl_2022_analysis
use ipl_2022_analysis

create table players_data(
player_id int,
player_name varchar(60),
base_price varchar(60),
player_type varchar(60),
cost_in_CR varchar(50),
cost_in_ones int,
team_2021 varchar(50),
team_2022 varchar(50))


load data infile "D:\ipl_2022_dataset_updated.csv"
into table players_data
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

select * from players_data

-- 1. How many players participated in the Auction 2022 ?
select count(player_name) from players_data

-- 2. Participation based on the Role(Batsman, Bowlers, Allrounders and WK)
select player_name, player_type, count(player_name) from players_data group by player_type

-- 3. How many Players Were Sold in IPL 2022 Auctions ?
select count(player_name) as sold_player from players_data where cost_in_ones > 0

-- 5. How many players Retained/DraftPicked by Each team ?
select * from players_data where base_price = 'Draft pick' or base_price = 'Retained' 

-- 6. Which Are the players who participated in IPL 2021 and will be participating in IPL 2022 and playing in same team
 select * from players_data where team_2021=team_2022;

-- 7. Number of players in each team based on thier roles
select player_type, count(player_type), team_2022 from players_data group by team_2022, player_type

-- 8. Heighest Bid(successful ) by each team
select player_name, team_2022, max(cost_in_ones) as price from players_data group by team_2022

-- 9. Top Five Batsman picked from Auction
select cost_in_ones, player_name, team_2022, player_type from players_data where player_type = 'BATTER' and base_price not in ('Retained', 'Draft Pick') order by cost_in_ones desc limit 5

-- 10. Heighest Paid Retained player
select * from players_data where base_price = 'Retained' order by cost_in_ones desc limit 1

-- 11. List of players who Played IPL 2021 but went unsold this time
select * from players_data where team_2021 > ' ' and cost_in_ones = 0





