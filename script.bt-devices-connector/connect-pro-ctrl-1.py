from utils import connectDevice
from utils import exeCmd

dev="E4:17:D8:AC:F7:E2"

print(exeCmd("bluetoothctl info "+dev))

print(connectDevice(dev, 2))
