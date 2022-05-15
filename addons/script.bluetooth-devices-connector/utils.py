from subprocess import check_output

BOOL_DEBUG = True

def log(string):
	if BOOL_DEBUG:
		print(string)

def exeCmd(cmd):
	try:
		output = check_output(cmd, shell=True)

		log(__file__ + " exeCmd produced output: " + output)

		return output

	except Exception as e:
		log(__file__ + " exeCmd returned error: "+ str(e))

		return ""

def exeBtCmd(arg0, arg1):
	cmd = "bluetoothctl " + arg0 + " " + arg1

	log(__file__ + " executing bt command \"" + cmd + "\"")

	return exeCmd(cmd)

def isDeviceState(state, dev):
	result = state + ": yes" in exeBtCmd("info", dev)

	log(__file__ + " " + dev + " " + state + " " + str(result))

	return result
