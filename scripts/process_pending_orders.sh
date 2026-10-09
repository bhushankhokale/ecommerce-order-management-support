#!/bin/bash

# E-Commerce Pending Orders Batch Job
# Training simulation for Production Support

LOG_FILE="$HOME/ecommerce-support/logs/batch_job.log"
INPUT_FILE="$HOME/ecommerce-support/scripts/batch_data/pending_orders.csv"

echo "$(date '+%Y-%m-%d %H:%M:%S') | INFO | Batch job started" >> "$LOG_FILE"

if [ ! -f "$INPUT_FILE" ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') | ERROR | Input file missing: $INPUT_FILE" >> "$LOG_FILE"
    echo "$(date '+%Y-%m-%d %H:%M:%S') | ERROR | Batch job failed" >> "$LOG_FILE"
    exit 1
fi

ORDER_COUNT=$(tail -n +2 "$INPUT_FILE" | wc -l)

echo "$(date '+%Y-%m-%d %H:%M:%S') | INFO | Orders found: $ORDER_COUNT" >> "$LOG_FILE"
echo "$(date '+%Y-%m-%d %H:%M:%S') | INFO | Batch job completed successfully" >> "$LOG_FILE"

exit 0
