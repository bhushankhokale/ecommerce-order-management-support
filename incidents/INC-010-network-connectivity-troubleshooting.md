# INC-010 — Network Connectivity Troubleshooting

## 1. Exercise Summary
- Exercise ID: INC-010
- Category: Network and Connectivity Troubleshooting
- Environment: Local Ubuntu WSL
- Application: E-Commerce Order Management
- Final Assessment: Network and application checks passed; CLI authentication issue remains unexplained

## 2. Objective
Practise L1 connectivity checks using ping, nc, ss, and curl.
Compare network reachability, TCP connectivity, HTTP responses,
and database authentication.

This was a local training exercise, not a real production outage.

## 3. Tests and Evidence

### Test 1: Local Loopback
Command:
ping -c 4 127.0.0.1

Result:
Four packets transmitted, four received, zero percent packet loss.

Assessment: PASS

### Test 2: Flask TCP Port
Command:
nc -zv 127.0.0.1 5000

Result:
TCP connection succeeded.

Assessment: PASS

### Test 3: HTTP Health Check
Endpoint:
http://127.0.0.1:5000/health

Result:
HTTP 200. Application status UP.
Measured response time during one test: approximately 0.003653 seconds.

Assessment: PASS

### Test 4: MySQL Listening Port
Command:
sudo ss -tulnp | grep ':3306'

Result:
MySQL was listening on 127.0.0.1:3306.

Assessment: PASS

### Test 5: Direct MySQL TCP Connectivity
Command:
nc -zv 127.0.0.1 3306

Result:
TCP connection succeeded.

Assessment: PASS

### Test 6: Direct MySQL CLI Authentication
A login attempt using the ecommerce_app account returned:

ERROR 1045 (28000): Access denied for user
'ecommerce_app'@'localhost' (using password: YES)

Assessment:
Authentication failed for this attempt. The exact cause was not
established. The account password and MySQL account configuration
were not changed.

### Test 7: Database-Backed Application API
Endpoint:
http://127.0.0.1:5000/orders/8

Result:
HTTP 200. The application returned order 8 and its associated data.

Assessment: PASS

## 4. Investigation Conclusion
Local loopback connectivity, the Flask TCP port, the MySQL TCP port,
the health endpoint, and the database-backed order API all passed
their respective checks.

The direct MySQL CLI authentication attempt failed with error 1045.
Because the application API successfully retrieved order data, the
evidence does not indicate a general MySQL network outage.

The reason for the CLI authentication failure remains unconfirmed.

## 5. L1 Support Learning
- Use ping to test ICMP reachability.
- Use nc to test TCP connectivity to a specific port.
- Use ss to check listening sockets.
- Use curl to inspect HTTP status and response time.
- Distinguish connectivity problems from authentication problems.
- Validate database-backed application functionality.
- Base conclusions on evidence rather than assumptions.

## 6. Scope and Limitations
All tests were performed in a local Ubuntu WSL training environment.
No remote production server was tested. No database passwords,
permissions, or service configuration were changed.

## 7. Final Status
Connectivity and application checks passed. The separate CLI
authentication failure was recorded for further investigation.
