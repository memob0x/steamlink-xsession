import os

from utils import readFile, connectDevice

cwd = os.path.dirname(__file__)

connectDevice(readFile(cwd + "/devs.txt").split(","))
