# this is a simple UDP socket echo-server (send back upper-case)

import json
import socketserver

class MyUDPHandler(socketserver.BaseRequestHandler):
    def handle(self):
        data = self.request[0].strip()
        socket = self.request[1]
        print(data)
        inp = json.loads(data)
        print(f"{self.client_address[0]} command: {inp[0]}")
        if inp[0] == "hello":
          r = json.dumps([f"oh hi {inp[1]}, how's it going?"])
          print(r)
          socket.sendto(r, self.client_address)

print("Starting simple UDP socket server on port 12345")
with socketserver.UDPServer(('0.0.0.0', 12345), MyUDPHandler) as server:
    server.serve_forever()