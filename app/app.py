from flask import Flask, jsonify
import mysql.connector
import logging
from config.db_config import DB_CONFIG

app = Flask(__name__)

# Application logging
logging.basicConfig(
    filename="logs/application.log",
    level=logging.INFO,
    format="%(asctime)s %(levelname)s [OrderService] %(message)s"
)

logger = logging.getLogger("OrderService")

# Keep framework and database connector diagnostic logs out
logging.getLogger("werkzeug").setLevel(logging.WARNING)
logging.getLogger("mysql.connector").setLevel(logging.WARNING)


@app.route("/health", methods=["GET"])
def health():
    logger.info("Health check requested")

    return jsonify({
        "status": "UP",
        "application": "E-Commerce Order Management",
        "message": "Application is healthy"
    }), 200


@app.route("/orders", methods=["GET"])
def get_orders():

    logger.info("All orders request received")

    try:
        conn = mysql.connector.connect(**DB_CONFIG)
        logger.info("Database connection successful | endpoint=/orders")

        cursor = conn.cursor(dictionary=True)

        query = """
            SELECT
                o.order_id,
                c.customer_name,
                o.total_amount,
                o.order_status,
                o.payment_status,
                o.shipping_city
            FROM orders o
            JOIN customers c ON o.customer_id = c.customer_id
            ORDER BY o.order_id
        """

        cursor.execute(query)
        orders = cursor.fetchall()

        cursor.close()
        conn.close()

        logger.info(
            "Orders retrieved successfully | count=%s",
            len(orders)
        )

        return jsonify({
            "count": len(orders),
            "orders": orders
        }), 200

    except mysql.connector.Error as e:

        logger.error(
            "Database error | endpoint=/orders | error=%s",
            str(e)
        )

        return jsonify({
            "error": "Database connection/query failed"
        }), 500


@app.route("/orders/<int:order_id>", methods=["GET"])
def get_order(order_id):

    logger.info("Order request received | order_id=%s", order_id)

    try:
        conn = mysql.connector.connect(**DB_CONFIG)
        logger.info("Database connection successful | order_id=%s", order_id)

        cursor = conn.cursor(dictionary=True)

        query = """
            SELECT
                o.order_id,
                c.customer_name,
                o.total_amount,
                o.order_status,
                o.payment_status
            FROM orders o
            JOIN customers c ON o.customer_id = c.customer_id
            WHERE o.order_id = %s
        """

        cursor.execute(query, (order_id,))
        order = cursor.fetchone()

        cursor.close()
        conn.close()

        if order is None:
            logger.warning("Order not found | order_id=%s", order_id)

            return jsonify({
                "error": "Order not found",
                "order_id": order_id
            }), 404

        logger.info(
            "Order retrieved | order_id=%s | status=%s | payment_status=%s",
            order["order_id"],
            order["order_status"],
            order["payment_status"]
        )

        # Business-level warning
        if (
            order["payment_status"] == "SUCCESS"
            and order["order_status"] == "PENDING"
        ):
            logger.warning(
                "Payment successful but order status still pending | order_id=%s",
                order_id
            )

        return jsonify(order), 200

    except mysql.connector.Error as e:

        logger.error(
            "Database error | order_id=%s | error=%s",
            order_id,
            str(e)
        )

        return jsonify({
            "error": "Database connection/query failed"
        }), 500


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
