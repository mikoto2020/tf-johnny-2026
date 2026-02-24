from flask import Flask, request, jsonify, render_template_string

app = Flask(__name__)

# 將模板存放在記憶體變數中，避免讀取本地檔案的 I/O 負擔
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

        # 設定預設值
        context = {
            "region": data.get('region', 'us-east-1'),
            "bucket_name": data.get('bucket_name', 'my-default-bucket')
        }

        # 直接從記憶體渲染模板
        terraform_content = render_template_string(TF_TEMPLATE, **context)

        return jsonify({
            "status": "success",
            "terraform_content": terraform_content.strip()
        })
    except Exception as e:
        return jsonify({"status": "error", "message": str(e)}), 500

if __name__ == '__main__':
    # SRE 提醒：生產環境建議使用 gunicorn，本地測試則用 Flask debug mode
    app.run(host='0.0.0.0', port=5000)