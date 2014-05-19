meta
====

Project for avoiding boilerplate code by using templates for entities, parsers, web services, etc.

Goals
-----

It is based on [Mustache][] and the Bohemian Coding's [coma][]. 

Platform
--------

Meta is implemented in python using [Pystache][], so it should work on any major platform.

Installation
------------

Download the project. You'll need these:

- [Python][] (Latest 2.x)
- [Pystache][]:
	pip install pystache
- [Inflect][] (Pluralizes words):
	pip install -e git+https://github.com/benthor/inflect.py#egg=inflect



[Python]:https://www.python.org "Python"
[Mustache]:http://mustache.github.io "Mustache"
[Pystache]:https://github.com/defunkt/pystache "pystache"
[coma]:https://github.com/BohemianCoding/Coma "Coma"
[BohemianBlog]:http://bohemiancoders.tumblr.com "Bohemian Coders"
[Inflect]:https://pypi.python.org/pypi/inflect "Inflect"