from flask import Flask, request, jsonify, render_template_string

app = Flask(__name__)

# Store templates in memory variables to avoid the I/O burden of reading local files
TF_TEMPLATE = """
provider "aws" {
  region = "{{ region }}"
}

resource "aws_s3_bucket" "this" {
  bucket = "{{ bucket_name }}"
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id
  acl    = "private"
}
"""

@app.route('/parse', methods=['POST'])
def parse_terraform():
    try:
        data = request.get_json()
        if not data:
            return jsonify({"error": "Invalid JSON"}), 400

        # Set default value
        context = {
            "region": data.get('region', 'us-east-1'),
            "bucket_name": data.get('bucket_name', 'my-default-bucket')
        }

        # Render templates directly from memory
        terraform_content = render_template_string(TF_TEMPLATE, **context)

        return jsonify({
            "status": "success",
            "terraform_content": terraform_content.strip()
        })
    except Exception as e:
        return jsonify({"status": "error", "message": str(e)}), 500

if __name__ == '__main__':
    # SRE reminder: It is recommended to use gunicorn for production environment and Flask debug mode for local testing.
    app.run(host='0.0.0.0', port=5000)