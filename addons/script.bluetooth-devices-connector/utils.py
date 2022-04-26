from subprocess import PIPE, Popen

def exeCmd(cmd):
	try:
	        with Popen(cmd, stdout=PIPE, stderr=None, shell=True) as process:
        	        return process.communicate()[0].decode("utf-8")
	except:
		return ""

def exeBtCmd(action, dev):
	return exeCmd("sudo bluetoothctl " + action + " " + dev)

def isDeviceState(state, dev):
	return state + ": yes" in exeBtCmd("info", dev)
