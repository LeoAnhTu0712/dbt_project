select 
        date_trunc(date(o.order_time_local_tz),month) as order_month,
        date_trunc(date(o.order_time_local_tz),isoweek) as order_week,
        date(o.order_time_local_tz) as order_date,
        order_time_local_tz as order_time,
        o.order_status as order_status,
        pickup_province_name as region_name,
        o.vertical_name,
        sub_vertical_name,
        service_name,
        o.channel,
        o.order_id as booking_id,
        ifnull(dispatch_group_id,o.order_id) as group_booking_id,
        o.customer_id as phone_number, 
        o.gmv,
        o.discount,
        promotion_code,
        vehicle_model,
        vehicle_license_plate,
        vehicle_vin_number,
        driver_id,
        trip_distance as distance,
        case when safe_cast(o.surge_multiplier as float64) = 0 then 1 
             else safe_cast(o.surge_multiplier as float64) 
        end as surge_multiplier,
        safe_cast(actual_time_arrival_business_second as float64) as ATA,
        safe_cast(actual_pickup_distance as float64) as pickup_distance,
        safe_cast(created_at_local_tz as datetime) as created_at,
        safe_cast(last_assigned_time_local_tz as datetime) as last_assigned_time_local_tz,
        is_schedule_order,
        is_allocated
        from `bustling-bot-508302-n4.gold.orders` o
        where date(o.order_time_local_tz) <= current_date('Asia/Kolkata') - 1