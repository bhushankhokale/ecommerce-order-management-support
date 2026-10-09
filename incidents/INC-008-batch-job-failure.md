# INC-008 — Batch Job Failure

## 1. Incident Summary
- Incident ID: INC-008
- Category: Batch Job / Scheduled Job Failure
- Environment: Local Ubuntu WSL
- Application: E-Commerce Order Management
- Job Script: scripts/process_pending_orders.sh
- Input File: scripts/batch_data/pending_orders.csv
- Final Status: Resolved

## 2. Incident Description
A batch job failed because its required input CSV file was missing.
The failure was deliberately reproduced as part of a Production
Support training exercise.

## 3. Investigation Performed
1. Executed the batch job script.
2. Checked the script's exit code.
3. Examined logs/batch_job.log.
4. Identified the missing input file from the error message.
5. Created the required CSV file with five sample order records.
6. Reran the batch job.
7. Verified the exit code and reviewed the execution logs.

## 4. Evidence of Failure
The initial execution returned exit code 1.

The log recorded:
- Batch job started.
- Input file missing.
- Batch job failed.

## 5. Root Cause
The required file pending_orders.csv did not exist at the expected
location when the job was executed.

## 6. Corrective Action
Created the expected CSV input file containing a header and five
sample order records, then reran the batch job.

## 7. Recovery Evidence
The subsequent execution recorded:
- Batch job started.
- Orders found: 5.
- Batch job completed successfully.

The successful execution returned exit code 0.

## 8. L1 Production Support Learning
- Execute and monitor batch scripts.
- Interpret job exit codes.
- Investigate job logs using tail.
- Identify missing input files.
- Verify file paths and input availability.
- Rerun a job after correcting the identified issue.
- Preserve historical logs for incident investigation.

## 9. Prevention Recommendations
- Validate that required input files exist before the scheduled run.
- Alert support teams when a job exits with a nonzero status.
- Monitor job completion and execution logs.
- Confirm input file arrival before initiating dependent jobs.

## 10. Scope and Limitations
This was a local Bash training simulation. The script counts CSV
records; it does not process real orders or update the MySQL database.
No actual AutoSys scheduler was used.

## 11. Final Status
Resolved in the training environment. The rerun completed successfully.
