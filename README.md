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

The very basic steps needed for a user to get the module up and running. This
can include setup steps, if necessary, or it can be an example of the most
basic use of the module.

## Usage

This section is where you describe how to customize, configure, and do the
fancy stuff with your module here. It's especially helpful if you include usage
examples and code samples for doing things with your module.

## Reference

Here, include a complete list of your module's classes, types, providers,
facts, along with the parameters for each. Users refer to this section (thus
the name "Reference") to find specific details; most users don't read it per
se.

## Limitations

This is where you list OS compatibility, version compatibility, etc. If there
are Known Issues, you might want to include them under their own heading here.

## Development

Since your module is awesome, other users will want to play with it. Let them
know what the ground rules for contributing are.

## Release Notes/Contributors/Etc. **Optional**

If you aren't using changelog, put your release notes here (though you should
consider using changelog). You can also add any additional sections you feel
are necessary or important to include here. Please use the `## ` header.
