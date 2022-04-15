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

def connectDevice(dev, attempts = 0, onSuccess = noop, onError = noop):
	if type(dev) == list:
		def predicate(x):
			connectDevice(x, attempts, onSuccess, onError)

		return list(map(predicate, dev))

	if isDeviceState("Connected", dev) and isDeviceState("Paired", dev):
		onSuccess(dev)

		return True

	i = 0

	while not "Connection successful" in exeBtCmd("connect", dev):
		if i == attempts:
			onError(dev)

			return False

		i = i + 1

	exeBtCmd("pair", dev)

	exeBtCmd("trust", dev)

	onSuccess(dev)

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
