import bluetooth

# Bluetooth stuff
bd_addr = "E4:17:D8:4C:15:ED"
port = 1
sock = bluetooth.BluetoothSocket( bluetooth.RFCOMM )
sock.connect((bd_addr, port))

# 0x1X for straight forward and 0x11 for very slow to 0x1F for fastest
sock.send("\x1A")
