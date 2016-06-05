import deimos.lxc.lxccontainer;

import std.stdio;
import std.string;

void main()
{
	lxc_container* c = lxc_container_new("apicontainer".toStringz, null);
	scope (exit)
		lxc_container_put(c);
	if (!c)
		throw new Exception("Failed to setup lxc_container struct");

	if (c.is_defined(c))
		throw new Exception("Container already exists");

	if (!c.create(c, "download".toStringz, null, null, LXC_CREATE_QUIET,
			["-d".toStringz, "ubuntu".toStringz, "-r".toStringz,
			"trusty".toStringz, "-a".toStringz, "i386".toStringz, null].ptr))
		throw new Exception("Failed to create container rootfs");

	if (!c.start(c, 0, null))
		throw new Exception("Failed to start the container");

	writeln("Container state: ", c.state(c));
	writeln("Container PID: ", c.init_pid(c));

	if (!c.shutdown(c, 5))
	{
		writeln("Failed to cleanly shutdown the container, forcing.");
		if (!c.stop(c))
			throw new Exception("Failed to kill the container.");
	}

	if (!c.destroy(c))
		throw new Exception("Failed to destroy the container");
}
