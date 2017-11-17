from setuptools import setup, find_packages
from codecs import open
from os import path

here = path.abspath(path.dirname(__file__))

with open(path.join(here, 'README.rst'), encoding='utf-8') as f:
    long_description = f.read()

setup(
    name='modeldb-basic',
    version=__import__('modeldb').VERSION,
    description='A system to manage machine learning models',
    long_description=long_description,
    url='https://github.com/engapa/modeldb-basic/tree/master',
    license='MIT',
    classifiers=[
        'Development Status :: 3 - Alpha',
        'Intended Audience :: Developers',
        'Intended Audience :: Science/Research',
        'Topic :: Scientific/Engineering',
        'License :: OSI Approved :: MIT License',
        'Programming Language :: Python :: 2.7',
        'Programming Language :: Python :: 3.5',
        'Programming Language :: Python :: 3.6'
    ],
    keywords='Machine Learning ML model catalog',
    packages=find_packages(exclude=['*.tests.*', '*.tests']),
    install_requires=['thrift', 'pyyaml', 'requests', 'dpath'],
    package_data={
        '': ['syncer.json'],
    },
    entry_points={
        'console_scripts': [
            'modeldb-config = modeldb.__main__:main'
        ],
    }
)
