# INC-009 — Application Deployment Validation

## 1. Exercise Summary
- Exercise ID: INC-009
- Category: Post-Deployment Validation
- Environment: Local Ubuntu WSL
- Application: E-Commerce Order Management
- Validation Date: 2026-10-09
- Final Status: Technical validation passed; business warning identified

## 2. Objective
Practise L1 support checks performed after an application deployment
or change, including process verification, port verification, health
checks, API validation, and application log analysis.

Note: This was a simulated validation exercise. No new deployment
or application code change was performed.

## 3. Checks Performed

### Check 1: Application Process
Command:
ps -ef | grep '[p]ython -m app.app'

Result:
The Flask application process was running with PID 836 at the time
of verification.

Status: PASS

### Check 2: Listening Port
Command:
sudo ss -tulnp | grep ':5000'

Result:
Port 5000 was in LISTEN state and associated with the Python process.

Status: PASS

### Check 3: Health Endpoint
Command:
curl -i http://127.0.0.1:5000/health

Result:
HTTP 200 OK. The response reported application status UP.

Status: PASS

### Check 4: Order API
Command:
curl -i http://127.0.0.1:5000/orders/8

Result:
HTTP 200 OK. The API returned order 8 with customer name
Amit Deshmukh, total amount 2299.00, order status PENDING,
and payment status SUCCESS.

Status: PASS for API functionality

### Check 5: Application Logs
Command:
tail -20 logs/application.log

Findings:
- Health-check requests were logged.
- Database connections succeeded.
- Order 8 was retrieved successfully.
- A warning reported that payment was successful while the order
  remained pending.
- Historical slow-response test entries were present.

Status: REVIEW REQUIRED for the business-data warning

## 4. Investigation Assessment
The application process, listening port, health endpoint, and order
API passed the checks performed.

The logs revealed a business-data inconsistency for order 8:
payment_status=SUCCESS while order_status=PENDING.

This warning does not demonstrate an application availability failure.
The underlying reason for the inconsistent business state has not
been established by this validation exercise.

## 5. Recommended L1 Actions
1. Record the order ID and relevant status values.
2. Verify the order and payment records using approved read-only queries.
3. Review the documented order-processing workflow.
4. Check for related errors or delayed processing.
5. Escalate to the application or payment team if the mismatch persists.
6. Do not manually update production order or payment records without
   authorization and an approved recovery procedure.

## 6. Final Assessment
Technical checks passed in the local training environment.
A business-data warning was identified and requires separate
investigation. No actual deployment was performed.

## 7. Skills Practised
- Linux process verification
- TCP listening-port verification
- HTTP health checks using curl
- API response validation
- Application log analysis
- Identification of business-data inconsistencies
- Evidence-based incident assessment
- Appropriate L1 escalation
