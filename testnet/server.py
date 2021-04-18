# this is a simple UDP socket echo-server (send back upper-case)

import json
import socketserver

class MyUDPHandler(socketserver.BaseRequestHandler):
    def handle(self):
        data = self.request[0].strip()
        socket = self.request[1]
        inp = json.loads(data.decode('utf8'))
        cmd = inp['cmd']
        args = inp['args']
        print(f"{self.client_address[0]} command: {cmd}")
        if cmd == "hello":
          r = json.dumps({msg: f"oh hi {args[0]}, how's it going?"})
          socket.sendto(r.encode('utf8'), self.client_address)

print("Starting simple UDP socket server on port 12345")
with socketserver.UDPServer(('0.0.0.0', 12345), MyUDPHandler) as server:
    server.serve_forever()
