module deimos.lxc.lxccontainer;

import core.stdc.config;
import core.sys.posix.stdlib;

public import deimos.lxc.attach_options;
import deimos.lxc.lxclock;

extern (C) nothrow @nogc:

enum LXC_CLONE_KEEPNAME = (1 << 0);
enum LXC_CLONE_KEEPMACADDR = (1 << 1);
enum LXC_CLONE_SNAPSHOT = (1 << 2);
enum LXC_CLONE_KEEPBDEVTYPE = (1 << 3);
enum LXC_CLONE_MAYBE_SNAPSHOT = (1 << 4);
enum LXC_CLONE_MAXFLAGS = (1 << 5);
enum LXC_CREATE_QUIET = (1 << 0);
enum LXC_CREATE_MAXFLAGS = (1 << 1);

struct lxc_conf;

struct lxc_container
{
	char* name;
	char* configfile;
	char* pidfile;
	lxc_lock* slock;
	lxc_lock* privlock;
	int numthreads;
	lxc_conf* conf;
	char* error_string;
	int error_num;
	bool daemonize;
	char* config_path;
	bool function(lxc_container* c) is_defined;
	const(char)* function(lxc_container* c) state;
	bool function(lxc_container* c) is_running;
	bool function(lxc_container* c) freeze;
	bool function(lxc_container* c) unfreeze;
	pid_t function(lxc_container* c) init_pid;
	bool function(lxc_container* c, const(char)* alt_file) load_config;
	bool function(lxc_container* c, int useinit, const(char*)* argv) start;
	bool function(lxc_container* c, int useinit, ...) startl;
	bool function(lxc_container* c) stop;
	bool function(lxc_container* c, bool state) want_daemonize;
	bool function(lxc_container* c, bool state) want_close_all_fds;
	char* function(lxc_container* c) config_file_name;
	bool function(lxc_container* c, const(char)* state, int timeout) wait;
	bool function(lxc_container* c, const(char)* key, const(char)* value) set_config_item;
	bool function(lxc_container* c) destroy;
	bool function(lxc_container* c, const(char)* alt_file) save_config;
	bool function(lxc_container* c, const(char)* t, const(char)* bdevtype,
			bdev_specs* specs, int flags, const(char*)* argv) create;
	bool function(lxc_container* c, const(char)* t, const(char)* bdevtype,
			bdev_specs* specs, int flags, ...) createl;
	bool function(lxc_container* c, const(char)* newname) rename;
	bool function(lxc_container* c) reboot;
	bool function(lxc_container* c, int timeout) shutdown;
	void function(lxc_container* c) clear_config;
	bool function(lxc_container* c, const(char)* key) clear_config_item;
	int function(lxc_container* c, const(char)* key, char* retv, int inlen) get_config_item;
	char* function(lxc_container* c, const(char)* key) get_running_config_item;
	int function(lxc_container* c, const(char)* key, char* retv, int inlen) get_keys;
	char** function(lxc_container* c) get_interfaces;
	char** function(lxc_container* c, const(char)* interface_, const(char)* family, int scope_) get_ips;
	int function(lxc_container* c, const(char)* subsys, char* retv, int inlen) get_cgroup_item;
	bool function(lxc_container* c, const(char)* subsys, const(char)* value) set_cgroup_item;
	const(char)* function(lxc_container* c) get_config_path;
	bool function(lxc_container* c, const(char)* path) set_config_path;
	lxc_container* function(lxc_container* c, const(char)* newname,
			const(char)* lxcpath, int flags, const(char)* bdevtype,
			const(char)* bdevdata, ulong newsize, char** hookargs) clone;
	int function(lxc_container* c, int* ttynum, int* masterfd) console_getfd;
	int function(lxc_container* c, int ttynum, int stdinfd, int stdoutfd, int stderrfd, int escape) console;
	int function(lxc_container* c, lxc_attach_exec_t exec_function,
			void* exec_payload, lxc_attach_options_t* options, pid_t* attached_process) attach;
	int function(lxc_container* c, lxc_attach_options_t* options,
			const(char)* program, const(char*)* argv) attach_run_wait;
	int function(lxc_container* c, lxc_attach_options_t* options,
			const(char)* program, const(char)* arg, ...) attach_run_waitl;
	int function(lxc_container* c, const(char)* commentfile) snapshot;
	int function(lxc_container* c, lxc_snapshot** snapshots) snapshot_list;
	bool function(lxc_container* c, const(char)* snapname, const(char)* newname) snapshot_restore;
	bool function(lxc_container* c, const(char)* snapname) snapshot_destroy;
	bool function(lxc_container* c) may_control;
	bool function(lxc_container* c, const(char)* src_path, const(char)* dest_path) add_device_node;
	bool function(lxc_container* c, const(char)* src_path, const(char)* dest_path) remove_device_node;
	bool function(lxc_container* c, const(char)* dev, const(char)* dst_dev) attach_interface;
	bool function(lxc_container* c, const(char)* dev, const(char)* dst_dev) detach_interface;
	bool function(lxc_container* c, char* directory, bool stop, bool verbose) checkpoint;
	bool function(lxc_container* c, char* directory, bool verbose) restore;
	bool function(lxc_container* c) destroy_with_snapshots;
	bool function(lxc_container* c) snapshot_destroy_all;
	int function(lxc_container* c, uint cmd, migrate_opts* opts, uint size) migrate;
}

struct lxc_snapshot
{
	char* name;
	char* comment_pathname;
	char* timestamp;
	char* lxcpath;
	void function(lxc_snapshot* s) free;
}

struct bdev_specs
{
	char* fstype;
	ulong fssize;
	struct
	{
		char* zfsroot;
	}

	struct
	{
		char* vg;
		char* lv;
		char* thinpool;
	}

	char* dir;
	struct
	{
		char* rbdname;
		char* rbdpool;
	}
}

enum
{
	MIGRATE_PRE_DUMP,
	MIGRATE_DUMP,
	MIGRATE_RESTORE,
}

struct migrate_opts
{
	char* directory;
	bool verbose;
	bool stop;
	char* predump_dir;
	char* pageserver_address;
	char* pageserver_port;
	bool preserves_inodes;
}

lxc_container* lxc_container_new(const(char)* name, const(char)* configpath);
int lxc_container_get(lxc_container* c);
int lxc_container_put(lxc_container* c);
int lxc_get_wait_states(const(char)** states);
const(char)* lxc_get_global_config_item(const(char)* key);
const(char)* lxc_get_version();
int list_defined_containers(const(char)* lxcpath, char*** names, lxc_container*** cret);
int list_active_containers(const(char)* lxcpath, char*** names, lxc_container*** cret);
int list_all_containers(const(char)* lxcpath, char*** names, lxc_container*** cret);
void lxc_log_close();
