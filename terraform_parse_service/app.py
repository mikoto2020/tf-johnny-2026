from flask import Flask, request, jsonify
from renderer import TerraformRenderer

app = Flask(__name__)

# Initialize renderer globally
tf_renderer = TerraformRenderer()

@app.route('/parse', methods=['POST'])
def parse_terraform():
    try:
        # Get the JSON passed in by the API
        data = request.get_json()
        
        # Check if the Payload structure is correct
        if not data or 'payload' not in data:
            return jsonify({"error": "Invalid payload format"}), 400
        
        properties = data['payload']['properties']
        
        # Call independent rendering logic
        rendered_content = tf_renderer.render_s3(properties)
        
        # Return JSON results
        return jsonify({
            "status": "success",
            "terraform_content": rendered_content
        })

    except Exception as e:
        # Capture and return error messages (for SRE Debug)
        return jsonify({"status": "error", "message": str(e)}), 500

if __name__ == '__main__':
    # Start Flask and listen on port 5000
    app.run(host='0.0.0.0', port=5000)