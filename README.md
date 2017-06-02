# firewall_wrap

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with firewall_wrap](#setup)
    * [Setup requirements](#setup-requirements)
    * [Beginning with firewall_wrap](#beginning-with-firewall_wrap)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This module is a "wrapper" module around the Puppet Labs Firewall module for
the purpose of being able to manage firewall rules within your hiera data
without needing to write specific manifests to manage iptables rules for a host.

The purpose of this is to enable the separation of the "what" of your configuration
data from the "how" of your manifests.  This is an opinionated approach to the
problem and it is acknowledge this approach may not work for everyone.  The core
functionality is based around the "create_resource" function

## Setup

### Setup Requirements 

Since this is a wrapper around the Firewall module, it depends on the official
Firewall module from Puppet Labs.

### Beginning with firewall_wrap

The default stance of this module is to purge unmanaged firewall rules and chains
as a result, it is essential to define the default iptables changes for your OS.

## Usage

Here is an example of how to get started with the firewall_wrap module in hiera,
using a couple of levels:

common.yaml:
```
classes:
  - firewall_wrap

lookup_options:
  classes:
    merge: unique
  '^firewall_wrap::(.*)$':
    merge: deep

firewall_wrap::firewall:
  #IPv4
  '000 accept all icmp':
    proto: 'icmp'
    action: 'accept'
  '001 accept all to lo interface':
    proto: 'all'
    iniface: 'lo'
    action: 'accept'
  '002 reject local traffic not on loopback interface':
    iniface: '! lo'
    proto: 'all'
    destination: '127.0.0.1/8'
    action: 'reject'
  '003 accept related established rules':
    proto: 'all'
    state: ['RELATED', 'ESTABLISHED']
    action: 'accept'
  '998 Log drops':
    jump: 'LOG'
    log_level: '6'
    log_prefix: 'iptables: '
    proto: 'all'
  '999 drop all':
    proto: 'all'
    action: 'drop'
```

os\RedHat.yaml:
```
firewall_wrap::firewallchain:
  'INPUT:filter:IPv4':
    policy: accept
  'OUTPUT:filter:IPv4':
    policy: accept
  'FORWARD:filter:IPv4':
    policy: drop
```

Depending on the specific release version, there may be other default chains that
you have to add to prevent Puppet from trying to purge a built-in chain that can't
be removed.

Also, since the firewall module manages iptables and not firewalld on newer Linux
distributions, you may choose to also remove the firewalld packages with my
"vpackages" module:

```
vpackages::packages:
  firewalld:
    ensure: absent

vpackages::realize_packages:
  - firewalld
```

## Reference

Please refer to the official Puppet Labs documentation for the Firewall module for
the proper usage of it.  This just provides an opinionated way to interact with it
fully within hiera.

## Limitations

This module should work with any OS supported by the official Puppet Labs firewall
module.  However, it has only been tested on Red Hat Enterprise Linux.

