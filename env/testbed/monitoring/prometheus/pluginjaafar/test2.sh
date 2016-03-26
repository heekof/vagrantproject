#!/bin/bash

METRIC="process_virtual_memory_bytes process_cpu_seconds_total go_memstats_next_gc_bytes prometheus_local_storage_persistence_urgency_score"
$INDEX=1
for M in METRIC 
do
echo "this is my metic $INDEX : $M"
(($INDEX++))
done

