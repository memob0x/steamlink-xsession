from subprocess import PIPE, Popen

from os.path import exists

def noop(arg):
	return None

def exeCmd(cmd):
        with Popen(cmd, stdout=PIPE, stderr=None, shell=True) as process:
                return process.communicate()[0].decode("utf-8")

def exeBtCmd(action, dev):
	return exeCmd("bluetoothctl " + action + " " +dev)

def isDeviceState(state, dev):
	return state + ": yes" in exeBtCmd("info", dev)

def disconnectDevice(dev):
	if type(dev) == list:
		def predicate(x):
			disconnectDevice(x)

		return list(map(predicate, dev))

	exeBtCmd("disconnect", dev)

def connectDevice(dev, onSuccess = noop, onError = noop):
	if type(dev) == list:
		def predicate(x):
			connectDevice(x, onSuccess, onError)

		return list(map(predicate, dev))

	if isDeviceState("Connected", dev) and isDeviceState("Paired", dev):
		onSuccess(dev)

		return True

	if not "Connection successful" in exeBtCmd("connect", dev):
		onError(dev)

		return False

	exeBtCmd("pair", dev)

	exeBtCmd("trust", dev)

	onSuccess(dev)

	return True

def connectDeviceWithRetry(dev, attempts, onSuccess, onError):
	if type(dev) == list:
		def predicate(x):
			connectDeviceWithRetrye(x, attempts, onSuccess, onError)

		return list(map(predicate, dev))

	i = 0

	while not connectDevice(dev, attempts, onSuccess, onError):
		if i == attempts:
			return False

		i = i + 1

	return True

def writeFile(path, contents, append = False):
	flag = "w"

	if append:
		flag = "a"

	f = open(path, flag)

	f.write(contents)

	f.close()

def readFile(path):
	if not exists(path):
		return ""

	data = open(path, "r")

	contents = data.read()

	data.close()

	return contents

def deleteFile(path):
	if exists(path):
		os.remove(path)
