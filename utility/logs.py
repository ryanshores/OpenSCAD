from utility import LOG_LEVEL
import logging

class Logger(logging.Logger):
    def __init__(self, name):
        super().__init__(name, LOG_LEVEL)
        ch = logging.StreamHandler()
        ch.setLevel(logging.DEBUG)
        formatter = logging.Formatter('[%(levelname)s] %(name)s.%(funcName)s(%(message)s)')
        ch.setFormatter(formatter)
        self.addHandler(ch)