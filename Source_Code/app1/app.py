from flask import Flask, render_template, jsonify
import requests

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/update_service2/<value>', methods=['POST'])
def update_service2(value):
    requests.post('http://app2:5002/update', json={"value": value})
    return jsonify({"message": "Service 2 updated!"})

@app.route('/update_service3/<value>', methods=['POST'])
def update_service3(value):
    requests.post('http://app3:5003/update', json={"value": value})
    return jsonify({"message": "Service 3 updated!"})

@app.route('/health', methods=['GET'])
def health():
    # 여기서 서비스가 정상인지 체크하는 로직을 추가할 수 있습니다.
    return jsonify({"status": "healthy"}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)  # app1