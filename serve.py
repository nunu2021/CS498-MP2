from flask import Flask, request, jsonify
import json
import socket
import subprocess

app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def get_number():
    global current_number
    if request.method == 'GET':
        return jsonify(socket.gethostname())
    elif request.method == 'POST':
        try:

            subprocess.Popen(['python3', 'stress_cpu.py'])
            return jsonify({'message':'Stress Test started successfully'})

        except Exception as e:
            return jsonify({'error': str(e)}), 400


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
