create or replace table `masterschool-gcp.analytics_integration.merged_sessions_leases` as
--ändern was
select
  s.* except(channel_code),
  cm.channel_name channel_type,
  l.* except(leasing_contract_id)

from `masterschool-gcp.analytics_stage.sessions` s
join `masterschool-gcp.analytics_stage.mapping_channel` cm
on s.channel_code = cm.channel_code
left join `masterschool-gcp.analytics_stage.leases` l
on s.leasing_contract_id = l.leasing_contract_id and s.session_date = l.request_date