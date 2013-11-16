#!/usr/bin/env python

from distutils.core import setup

setup(name='tankcore',
	version='9999',
	py_modules=['tankcore'],
	packages=['Tank', 'Tank.MonCollector', 'Tank.MonCollector.agent', 'Tank.Plugins', 'Tank.Plugins.bfg', 'Tank.stepper'],
)
