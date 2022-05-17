import os

from subprocess import check_output

def log(string):
	if os.environ.get("BLUETOOTH_DEVICES_CONNECTOR_DEBUG") == "1":
		print(string)

	return string

def exeCmd(cmd):
	try:
		output = check_output(cmd, shell=True)

		log("exeCmd produced output: " + output)

		return output

	except Exception as e:
		log("exeCmd returned error: "+ str(e))

		return ""

def exeBtCmd(arg0, arg1):
	cmd = "sudo -u pi -E bluetoothctl " + arg0 + " " + arg1

	log("executing bt command \"" + cmd + "\"")

	return exeCmd(cmd)

def isBtInfoState(info, state):
	result = state + ": yes" in info

	return result
