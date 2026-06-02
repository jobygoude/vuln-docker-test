import http.server
import socketserver
import yaml
import subprocess

PORT = 8080

# VULN: yaml.load() without Loader= is RCE (CVE-2017-18342)
def parse_config(data):
    return yaml.load(data)

# VULN: shell=True with user input is command injection
def run_cmd(user_input):
    return subprocess.check_output("echo " + user_input, shell=True)

class Handler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"vuln-docker-test: security scan demo app")

with socketserver.TCPServer(("", PORT), Handler) as httpd:
    print(f"Serving on port {PORT}")
    httpd.serve_forever()
