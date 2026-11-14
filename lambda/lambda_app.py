import json
from datetime import datetime, timezone


def lambda_handler(event, context):
    """
    Simple serverless task application.
    Processes an incoming task and returns a JSON response.
    """

    task = event.get("task", "No task provided")

    response = {
        "message": "Task processed successfully",
        "task": task,
        "status": "COMPLETED",
        "timestamp": datetime.now(timezone.utc).isoformat()
    }

    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps(response)
    }
