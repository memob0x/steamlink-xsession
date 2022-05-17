from utils import isBtInfoState, exeBtCmd, log

argsList = [
	["trust", "Trusted"],

	["pair", "Paired"],

	["connect", "Connected"]
]

def connect(devs):
	report = ""

	for dev in devs:
                log("-------------------------------------------------------------")
		log("connection " + dev + " start")
		log("-------------------------------------------------------------")

		info = exeBtCmd("info", dev)

		for args in argsList:
			action, state = args

			isState = isBtInfoState(info, state)

			if isState:
				report += "\n" + log(dev + " already " + state)
			else:
				isState = "succeeded" in exeBtCmd(action, dev)

				report += "\n" + log(dev + " " + state + ": " + str(isState))

		log("-------------------------------------------------------------")
		log("connection " + dev + " end")
		log("-------------------------------------------------------------")

	return report

