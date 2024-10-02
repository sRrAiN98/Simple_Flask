from flask import Flask, request, jsonify

app = Flask(__name__)
data = {"value": "Initial Value 3"}

@app.route('/update', methods=['POST'])
def update():
    global data
    data = request.json
    return jsonify({"message": "Service 3 updated!", "new_value": data["value"]})

@app.route('/get_value', methods=['GET'])
def get_value():
    return jsonify(data)

@app.route('/health', methods=['GET'])
def health():
    # 여기서 서비스가 정상인지 체크하는 로직을 추가할 수 있습니다.
    return jsonify({"status": "healthy"}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5003)  # app3