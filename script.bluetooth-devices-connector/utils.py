from subprocess import PIPE, Popen

def exeCmd(cmd):
        with Popen(cmd, stdout=PIPE, stderr=None, shell=True) as process:
                return process.communicate()[0].decode("utf-8")

def exeBtCmd(action, dev):
	return exeCmd("bluetoothctl " + action + " " +dev)

def isDeviceState(state, dev):
	return state + ": yes" in exeBtCmd("info", dev)

def connectDevice(dev, attempts = 3):
	if isDeviceState("Connected", dev) and isDeviceState("Paired", dev):
		return True

	i = 0

	while not "Connection successful" in exeBtCmd("connect", dev):
		if i == attempts:
			return False

		i = i + 1

	exeBtCmd("pair", dev)

	exeBtCmd("trust", dev)

	return True
