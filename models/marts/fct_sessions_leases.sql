create or replace table `masterschool-gcp.analytics_consumer.final_model` as

select 
  session_date,
  contract_start_date,
  sl.channel_type,
  channel,
  bike_type,
  bike_brand,
  count(distinct session_id) sessions,
  count(distinct user_id) users,
  countif(distinct leasing_contract_id is not null) conversions,
  case when leasing_contract_id is not null then date_diff(contract_start_date, session_date, day) else 0 end days_to_contract_start,
  sum(saleprice_gross) total_revenue, 
  sum(costs) total_spent,
  --max() oder min() nehmen
  sessions_benchmarks,
  costs_benchmarks

from `masterschool-gcp.analytics_integration.merged_sessions_leases` sl
left join `masterschool-gcp.analytics_stage.ads_benchmarks` ab
on sl.channel_type = ab.channel_type and sl.session_date = ab.date
group by session_date, contract_start_date, channel_type, bike_type, leasing_contract_id, sessions_benchmarks, costs_benchmarks, channel, bike_brand