# INC-005 — Slow API Response

## Incident Summary
A controlled test endpoint was used to practise investigating
slow API responses.

## Test Details
- Incident ID: INC-005
- Endpoint: GET /test-slow
- HTTP status: 200 OK
- Measured response time: 3.277763 seconds
- Deliberate application delay: 3 seconds

## Investigation Performed
1. Measured the normal /orders/8 API response time.
2. Repeated the normal API test three times.
3. Recorded the normal response times: approximately 0.092 to 0.101 seconds.
4. Added a separate test endpoint with a deliberate three-second delay.
5. Measured its response time using curl.
6. Checked application logs for the start and completion timestamps.

## Evidence
- Normal API requests returned HTTP 200 in approximately 0.092–0.101 seconds.
- The controlled slow endpoint returned HTTP 200 in approximately 3.278 seconds.
- Application logs recorded the test start at 17:16:12.637.
- Application logs recorded completion at 17:16:15.638.

## Finding
The controlled endpoint was slow because it deliberately waited three seconds.
The test demonstrates that HTTP 200 does not necessarily mean an API response
was fast.

## Real-World L1 Investigation
For an actual slow API incident, check:
- Response-time trends and monitoring alerts.
- Application logs and request timestamps.
- Database query performance.
- CPU, memory, and disk utilization.
- Network latency and downstream service response times.

Do not assume the root cause without supporting evidence.

## Final Status
Controlled test completed and evidence recorded.
The temporary test endpoint should be removed after documentation.
