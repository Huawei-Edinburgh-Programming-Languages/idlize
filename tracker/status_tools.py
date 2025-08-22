#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import argparse
from dataclasses import astuple, dataclass
import json
from collections import namedtuple
import os

JSON_FILE = 'packages-filter.json'
FULL_SDK_STATUS = '../doc/FULL_SDK_STATUS.md'
SDK_STATUS = '../doc/SDK_STATUS.md'
DELETED_SDK_STATUS = '../doc/DELETED_SDK_STATUS.md'
CAPI_STATUS = '../doc/COMPONENTS.md'
TS_STATUS = '../doc/MANAGED.md'
TS_STATUS_INPUT = '../doc/MANAGED_STATUS.md'
FULL_API_STATUS = '../doc/FULL_API_STATUS.md'

SdkStatus = namedtuple('SdkStatus', ['i','pkg','old_pkg','parent','name','ovr','type','status','source'])
CapiStatus = namedtuple('CapiStatus', ['i','pkg','parent','name','ovr','c_parent','c_name','type','owner','status','test_status','test_version','comment','ii'])
TsStatus = namedtuple('CapiStatus', ['i','pkg','parent','name','ovr','owner','status','test_status','test_version','comment','ii'])
#FullStatus = namedtuple('FullStatus', ['i','pkg','parent','name','ovr','type','status','c_parent','c_name','ts_status','c_status','owner','test_status','test_version','comment','source'])

@dataclass
class FullStatus:
    i: str
    pkg: str
    parent: str
    name: str
    ovr: str
    type: str
    status: str
    c_parent: str
    c_name: str
    ts_status: str
    c_status: str
    owner: str
    test_status: str
    test_version: str
    comment: str
    source: str

def ReadSdk(fname=SDK_STATUS):
    sdk = []
    with open(fname, 'r') as f:
        firstLine = True
        for line in f:
            if firstLine:
                firstLine = False
                continue
            cols = line.split('|', 8)
            st = SdkStatus(*map(str.strip, cols))
            sdk.append(st)
    return sdk

def ReadCapi():
    result = []
    with open(CAPI_STATUS, 'r') as f:
        skip = True
        for line in f:
            cols = line.split('|')
            if skip:
                if len(cols) > 10 and cols[1].strip().startswith('-'):
                    skip = False
                continue
            st = CapiStatus(*map(lambda x: x.strip(' *`'),cols))
            result.append(st)
    return result

def ReadManaged(inp):
    fname = TS_STATUS_INPUT if inp else TS_STATUS
    result = []
    if not os.path.exists(fname):
        return result
    with open(fname, 'r') as f:
        firstLine = True
        for line in f:
            if firstLine:
                firstLine = False
                continue
            cols = line.split('|')
            st = TsStatus(*map(str.strip,cols))
            result.append(st)
    return result

def FindStatus(statuses, pkg, parent, name, ovr):
    for s in statuses:
        if s.pkg == pkg and s.parent == parent and s.name == name and s.ovr == ovr:
            return s
    return None

def FindStatusExt(statuses, pkg, parent, name, ovr):
    last = None
    for s in statuses:
        if s.pkg == pkg and s.parent == parent and s.name == name and s.ovr == ovr:
            if last:
                return last, s
            last = s
        elif last:
            return last, None
    return None, None

def PrintStatus(f, s):
    def add_space(s):
        return f' {s} '
    r = map(add_space, s)
    f.write('|'.join(r).strip())
    f.write('\n')

def Split():
    sdk = ReadSdk()
    capi = ReadCapi()
    old = ReadManaged(True)
    ms = []
    for s in sdk:
        res = FindStatus(capi, s.pkg, s.parent, s.name, s.ovr)
        if not res:
            ms.append(s)
    with open(TS_STATUS, 'w') as f:
        f.write(f'| Package | Parent | Name | Ovr | Owner | Status | Test status | Test version | Comment |\n')
        for s in ms:
            res = FindStatus(old, s.pkg, s.parent, s.name, s.ovr)
            if res:
                PrintStatus(f, res)
            else:
                f.write(f'| {s.pkg} | {s.parent} | {s.name} | {s.ovr} |  | {s.status} |  |  |  |\n')

def PrepareSdk():
    with open(JSON_FILE) as f:
        config = json.load(f)

    include = config['include']
    exclude = config['exclude']

    def inpkg(s, packages):
        for pkg in packages:
            if s.startswith(pkg):
                return True
        return False

    with open(SDK_STATUS, 'w') as fo:
        with open(FULL_SDK_STATUS) as fi:
            fo.write(fi.readline())
            for line in fi:
                pkg = line.split('|')[1].strip()
                if inpkg(pkg, include) and not inpkg(pkg, exclude):
                    fo.write(line)

        # Append deleted packages        
        deleted = ReadSdk(DELETED_SDK_STATUS)
        for i in deleted:
            r = list(i)
            r[7] = 'Deleted package'
            PrintStatus(fo, r)

def PostprocessStatus(inp):
    if inp.type in ['interface', 'enum_class', 'class', 'namespace']:
        inp.parent = inp.name if inp.parent == 'unnamed' else f'{inp.parent}.{inp.name}'

def GenerateFullStatus():
    sdk = ReadSdk()
    capi = ReadCapi()
    managed = ReadManaged(False)
    def common_status(cs, ts):
        if cs == ts:
            return cs
        if not cs or cs == 'done':
            return ts
        if not ts or ts == 'done':
            return cs
        if ts == 'blocked' or cs == 'blocked':
            return 'blocked'
        return f'{cs}/{ts}'
    with open(FULL_API_STATUS, 'w') as f:
        f.write(f'| Package | SDK Parent | SDK Name | Override | Type | Item Status | C API Parent | C API Name | TS Status | C API Status | Owner | Last test status | Last test version | Comments | Declaration |\n')
        def print_status(cs, ts):
            init = [''] * 16
            res = FullStatus(*init)
            res.pkg = s.pkg
            res.parent = s.parent
            res.name = s.name
            res.ovr = s.ovr
            res.type = s.type
            res.source = s.source
            if cs and not ts:
                res.status = cs.status
                res.c_parent = cs.c_parent
                res.c_name = cs.c_name
                res.c_status = cs.status
                res.ts_status = '-'
                res.owner = cs.owner
                res.test_status = cs.test_status
                res.test_version = cs.test_version
                res.comment = cs.comment
            elif ts and not cs:
                res.status = ts.status
                res.c_status = 'TS only'
                res.ts_status = ts.status
                res.owner = ts.owner
                res.test_status = ts.test_status
                res.test_version = ts.test_version
                res.comment = ts.comment
            elif ts and cs:
                res.status = common_status(cs.status, ts.status)
                res.c_parent = cs.c_parent
                res.c_name = cs.c_name
                res.c_status = cs.status
                res.ts_status = 'Native only'
                res.owner = f'{cs.owner}/{ts.owner}'
                res.test_status = f'{cs.test_status}/{ts.test_status}'
                res.test_version = f'{cs.test_version}/{ts.test_version}'
                res.comment = f'{cs.comment}/{ts.comment}'
            PostprocessStatus(res)
            PrintStatus(f, astuple(res))
        for s in sdk:
            cs, ps = FindStatusExt(capi, s.pkg, s.parent, s.name, s.ovr)
            ts = FindStatus(managed, s.pkg, s.parent, s.name, s.ovr)
            print_status(cs, ts)
            if ps:
                print_status(ps, ts)

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('command')
    args = parser.parse_args()
    match args.command:
        case 'prepare':
            PrepareSdk()
        case 'split':
            Split()
        case 'generate':
            GenerateFullStatus()
        case 'all':
            PrepareSdk()
            Split()
            GenerateFullStatus()
        case _:
            print('Invalid command!')

if __name__ == "__main__":
    main()
