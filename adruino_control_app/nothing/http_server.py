from http.server import BaseHTTPRequestHandler, HTTPServer


class RequestHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        # Check the path for the command
        if self.path.startswith("/LED="):
            flag_value = self.path.split("=")[1]  # Get the value after '='
            print(f"Received command: LED={flag_value}")

            # Send a response back to the client
            self.send_response(200)
            self.send_header("Content-type", "text/html")
            self.end_headers()
            self.wfile.write(b"Command received")
        # else if self.path.startswith("/LED=")
        else:
            # If the path does not match the expected format
            self.send_response(400)
            self.send_header("Content-type", "text/html")
            self.end_headers()
            self.wfile.write(b"Bad Request: Invalid command format")


def run(server_class=HTTPServer, port=80):
    server_address = ("", port)  # Listen on all interfaces
    httpd = server_class(server_address, RequestHandler)
    print(f"Server running on port {port}...")
    httpd.serve_forever()


if __name__ == "__main__":
    run()
