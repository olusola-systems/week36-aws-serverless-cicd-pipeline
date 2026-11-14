import json
import sys
import unittest
from pathlib import Path

# Add the Lambda application directory to Python's import path
sys.path.insert(
    0,
    str(Path(__file__).resolve().parents[1] / "lambda")
)

from lambda_app import lambda_handler


class TestLambdaApplication(unittest.TestCase):

    def test_task_is_processed_successfully(self):
        event = {"task": "Deploy Week 36 application"}

        response = lambda_handler(event, None)

        self.assertEqual(response["statusCode"], 200)

        body = json.loads(response["body"])

        self.assertEqual(
            body["message"],
            "Task processed successfully"
        )
        self.assertEqual(
            body["task"],
            "Deploy Week 36 application"
        )
        self.assertEqual(body["status"], "COMPLETED")

    def test_missing_task_uses_default_value(self):
        event = {}

        response = lambda_handler(event, None)

        body = json.loads(response["body"])

        self.assertEqual(
            body["task"],
            "No task provided"
        )

    def test_response_contains_timestamp(self):
        event = {"task": "Test timestamp"}

        response = lambda_handler(event, None)

        body = json.loads(response["body"])

        self.assertIn("timestamp", body)
        self.assertTrue(body["timestamp"])


if __name__ == "__main__":
    unittest.main()
