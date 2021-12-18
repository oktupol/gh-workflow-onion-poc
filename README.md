# Github Workflow Onion Proof of Concept

Proof of concept for a github workflow which pushes files onto a remote ssh
server over Tor.

This proof of concept consists of a script that echoes the current date into a
file, which is then pushed onto one of my devices.

This roughly translates into compiling a project and pushing the compiled files
on a remote onion server.

## Example use case

You're running a Reddit bot on a Raspberry Pi in your home and want to update
it automatically on every push to a repository, without having to do any of
following:

- Periodically polling for changes.
- Opening and forwarding a port on your home router, potentially exposing your
  device to attackers.
- Setting up DynDNS or similar if your home network doesn't have a static IP
  address.
  
Instead, you set up an SSH server and
[an onion service](https://community.torproject.org/onion-services/setup/) on
the same port, allowing you to SSH into your Raspberry from anywhere over Tor.
The way onion services function allows them to be reachable even behind NAT
setups and firewalls.

With [Client Authorization](https://community.torproject.org/onion-services/advanced/client-auth/),
even if someone knew your Raspberry's onion url, they wouldn't be able to
resolve and connect to it due to not having the correct private key.