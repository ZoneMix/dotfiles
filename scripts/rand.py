#!/usr/local/bin/python3
import requests
import argparse
import os
import socket
import random
import datetime
from pprint import pprint

online = None
try:
    socket.create_connection(('https://api.random.org', 80))
    online = True
except:
    print("No internet connection detected, using local pseudo random number generation")
    online = False

methods = {
    'i': 'generateIntegers',
    'int': 'generateIntegers',
    'integer': 'generateIntegers',
    'd': 'generateDecimalFractions',
    'dec': 'generateDecimalFractions',
    'decimal': 'generateDecimalFractions',
    's': 'generateStrings',
    'str': 'generateStrings',
    'string': 'generateStrings',
}

charactersets = {
    'alpha': 'abcdefghijklmnopqrstuvwxyz',
    'numeric': '0123456789',
    'special': '`~!@#$%^&*()-=_+[]{}\\|;\':",.<>/?',
    'alphanumeric': 'abcdefghijklmnopqrstuvwxyz0123456789',
    'special_alpha': '`~!@#$%^&*()-=_+[]{}\\|;\':",.<>/?abcdefghijklmnopqrstuvwxyz',
    'special_numeric': '`~!@#$%^&*()-=_+[]{}\\|;\':",.<>/?0123456789',
    'special_alphanumeric': '`~!@#$%^&*()-=_+[]{}\\|;\':",.<>/?abcdefghijklmnopqrstuvwxyz0123456789'
}

parser = argparse.ArgumentParser()
parser.add_argument('-n', '--amount', type=int, metavar='N', default=1, help='Amount of random integers to generate')
parser.add_argument('-min', '--minimum', type=int, metavar='MIN', default=None, help='The minimum value for the random numbers to be generated')
parser.add_argument('-max', '--maximum', type=int, metavar='MAX', default=None, help='The maximum value for the random numbers to be generated')
parser.add_argument('-b', '--base', type=int, metavar='BASE', default=10, help='Numerical base for the numbers to be generated in')
parser.add_argument('-u', '--unique', action='store_const', const=True, default=False, help='Include this option to generate unique values')
parser.add_argument('-D', '--decision', nargs='?', type=int, const=2, default=False, help='Include this option to get a odd or even value for making random decisions')
parser.add_argument('-t', '--type', type=str, default='integer', help='The type of random value to generate', choices=['i', 'int', 'integer', 'd', 'dec', 'decimal', 's', 'str', 'string'])
parser.add_argument('-p', '--places', type=int, default=5, choices=range(1,15), help='The amount of decimal places to generate when using --type=decimal')
parser.add_argument('-s', '--separator', type=str, default='\n', help='The separator to put between elements of the output')
parser.add_argument('-c', '--characterset', type=str, default='alpha', help='The character set to use when generating random strings', choices=['alpha', 'numeric', 'alphanumeric', 'special', 'special_alpha', 'special_numeric', 'special_alphanumeric'])
parser.add_argument('-cc', '--characters', type=str, default=None, help='The characters to use when generating random strings')
parser.add_argument('-ca', '--case', type=str, default='any', help='Case to use for generated strings', choices=['upper', 'lower', 'any'])
parser.add_argument('-l', '--length', type=int, default=8, help='Length of strings to be generated', choices=range(1,33))
args = parser.parse_args()

if args.decision and args.type in ['d', 'dec', 'decimal', 's', 'str', 'string']:
    print('The --decision option may only be used with --type=integer')
    exit()

args.separator = args.separator.replace('\\n', '\n')

reqData = {
    "jsonrpc": "2.0",
    "method": methods[args.type],
    "params": {
        "apiKey": os.environ["RANDOM_DOT_ORG_APIKEY"],
        "n": args.amount if not args.decision else 1,
        "replacement": not args.unique
    },
    "id": 42
}

if args.type in ['i', 'int', 'integer']:
    reqData['params']['min'] = args.minimum if args.minimum else 1
    reqData['params']['max'] = args.maximum if args.maximum else 100
    reqData['params']['base'] = args.base
elif args.type in ['d', 'dec', 'decimal']:
    reqData['params']['decimalPlaces'] = args.places
elif args.type in ['s', 'str', 'string']:
    reqData['params']['length'] = args.length
    reqData['params']['characters'] = args.characters if args.characters else charactersets[args.characterset]
    if args.case == 'lower':
        reqData['params']['characters'] = reqData['params']['characters'].lower()
    elif args.case == 'upper':
        reqData['params']['characters'] = reqData['params']['characters'].upper()
    elif args.case == 'any':
        reqData['params']['characters'] = reqData['params']['characters'].lower()
        for c in reqData['params']['characters'].upper():
            if c not in reqData['params']['characters']:
                reqData['params']['characters'] += c
    if len(reqData['params']['characters']) > 128:
        print('Too many characters supplied, supplied: {}, max: 128'.format(len(reqData["params"]["characters"])))
        exit()

# pprint(reqData)

json = {}
if online:
    response = requests.post('https://api.random.org/json-rpc/2/invoke', json=reqData)
    response.raise_for_status()
    json = response.json()
else:
    random.seed()
    data = []
    if reqData['method'] == 'generateIntegers':
        for i in range(reqData['params']['n']):
            if reqData['params']['replacement']:
                data.append(int(str(random.randint(reqData['params']['min'], reqData['params']['max'])), base=reqData['params']['base']))
            else:
                while True:
                    num = int(str(random.randint(reqData['params']['min'], reqData['params']['max'])), base=reqData['params']['base'])
                    if num not in data:
                        data.append(num)
                        break
    if reqData['method'] == 'generateDecimalFractions':
        for i in range(reqData['params']['n']):
            if reqData['params']['replacement']:
                data.append(round(random.random(), reqData['params']['decimalPlaces']))
            else:
                while True:
                    num = round(random.random(), reqData['params']['decimalPlaces'])
                    if num not in data:
                        data.append(num)
                        break
    if reqData['method'] == 'generateStrings':
        chars = [c for c in reqData['params']['characters']]
        for i in range(reqData['params']['n']):
            if reqData['params']['replacement']:
                data.append(''.join([random.choice(chars) for _ in range(reqData['params']['length'])]))
            else:
                while True:
                    string = ''.join([random.choice(chars) for _ in range(reqData['params']['length'])])
                    if string not in data:
                        data.append(string)
                        break
    zulutime = datetime.datetime.now() + datetime.timedelta(hours=5)
    json = {"id":reqData['id'],"jsonrpc":'2.0',"result":{'advisoryDelay':0,"bitLeft":-1,"bitsUsed":-1,"random":{"completionTime":zulutime.strftime("%Y-%m-%d %H:%M:%SZ"),"data":data},"requestsLeft":-1}}

# pprint(json)

if not args.decision:
    if args.type in ['d', 'dec', 'decimal']:
        args.minimum = args.minimum if args.minimum else 0
        args.maximum = args.maximum if args.maximum else 1
        print(args.separator.join([str(x * (args.maximum - args.minimum) + args.minimum) for x in json["result"]["random"]["data"]]))
    else:
        print(args.separator.join([str(x) for x in json["result"]["random"]["data"]]))
else:
    print((json["result"]["random"]["data"][0] % args.decision) + 1)
