# INC-006 — Linux Disk-Space Investigation

## Objective
Practise Linux filesystem monitoring, file-size investigation,
and safe cleanup procedures.

## Environment
- OS: Ubuntu 24.04.2 LTS under WSL 2
- Project: E-Commerce Order Management Support

## Investigation Performed
1. Ran df -h to inspect filesystem capacity.
2. Used du -sh to check project directory size.
3. Used du -h --max-depth=1 to identify large subdirectories.
4. Used find and sort to identify the ten largest project files.
5. Inspected a temporary test file using ls and stat.
6. Removed the test file and its empty directory.

## Findings
- Root filesystem size: approximately 1007G.
- Root filesystem used: approximately 2.8G.
- Root filesystem available: approximately 953G.
- Root filesystem utilization: approximately 1%.
- Project directory size: approximately 86M.
- Virtual environment size: approximately 86M.
- Temporary test file size: 10485760 bytes.

## Assessment
No actual disk-space shortage was observed.
The temporary file was created solely for safe file-management practice.

## Cleanup
Removed the test file and the empty temporary directory.
No application files, database files, logs, or dependencies were deleted.

## Real-World L1 Procedure
For a genuine disk-space alert:
1. Identify the affected filesystem using df -h.
2. Identify large directories using du.
3. Investigate large files and determine their purpose.
4. Check log rotation and retention policies.
5. Obtain authorization before deleting or archiving files.
6. Escalate if cleanup requires elevated permissions or application downtime.
7. Verify available space after approved cleanup.

## Final Status
Disk-space investigation practice completed.
No actual disk-full incident was reproduced.
