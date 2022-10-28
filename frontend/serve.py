#!/usr/bin/env python
import http.server
import socketserver
import os

PORT = os.environ.get('PORT', 8080)

Handler = http.server.SimpleHTTPRequestHandler

with socketserver.TCPServer(("", int(PORT)), Handler) as httpd:
    print("serving at port", PORT)
    httpd.serve_forever()
