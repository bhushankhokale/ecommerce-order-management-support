# INC-001: Payment Successful but Order Pending

## Incident Summary
Order 8 has a successful payment, but its order status remains PENDING.

## Impact
The order state is inconsistent with the recorded payment state. Further order fulfilment may require investigation.

## Evidence Collected
- Order ID: 8
- Customer: Amit Deshmukh
- Order amount: 2299.00
- Order status: PENDING
- Payment status: SUCCESS
- Transaction ID: TXN100008
- API endpoint: GET /orders/8
- API response: HTTP 200

## Investigation
1. Queried the order and payment records in MySQL.
2. Confirmed that the payment record is SUCCESS while the order remains PENDING.
3. Checked MySQL service availability and connectivity during investigation.
4. Reviewed application logs for related order-processing messages.

## Root Cause
Not confirmed. Historical log messages alone do not prove the underlying cause.

## Resolution / Next Actions
- Verify the order-processing workflow and status-update logic.
- Check whether an asynchronous job or downstream process is responsible for confirming orders.
- Follow the approved reconciliation procedure before changing order or payment status.
- Escalate to the application or payment team if the inconsistency persists.

## Prevention
Add monitoring for orders where payment is SUCCESS but order status remains PENDING.

## Exercise Type
Training investigation using seeded application data and historical log entries.
