import jwt
import time

# Replace this with your GitHub App ID
app_id = "YOUR_APP_ID"

# Replace this with the content of your private key file (e.g., private-key.pem)
private_key = """
-----BEGIN RSA PRIVATE KEY-----
<YOUR_PRIVATE_KEY>
-----END RSA PRIVATE KEY-----
"""

# Generate the JWT
now = int(time.time())
payload = {
    "iat": now,  # Issued at: current time
    "exp": now + (10 * 60),  # Expiration: 10 minutes from iat
    "iss": app_id  # GitHub App ID
}

jwt_token = jwt.encode(payload, private_key, algorithm="RS256")

# Print the JWT token
print("Your JWT Token:", jwt_token)
