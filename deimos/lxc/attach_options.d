module deimos.lxc.attach_options;

import core.sys.posix.sys.types;
import core.stdc.config;

extern (C) nothrow @nogc:

enum lxc_attach_env_policy_t
{
	LXC_ATTACH_KEEP_ENV = 0,
	LXC_ATTACH_CLEAR_ENV = 1
}

enum
{
	LXC_ATTACH_MOVE_TO_CGROUP = 0x00000001,
	LXC_ATTACH_DROP_CAPABILITIES = 0x00000002,
	LXC_ATTACH_SET_PERSONALITY = 0x00000004,
	LXC_ATTACH_LSM_EXEC = 0x00000008,

	LXC_ATTACH_REMOUNT_PROC_SYS = 0x00010000,
	LXC_ATTACH_LSM_NOW = 0x00020000,

	LXC_ATTACH_DEFAULT = 0x0000FFFF
}

enum LXC_ATTACH_LSM = (LXC_ATTACH_LSM_EXEC | LXC_ATTACH_LSM_NOW);

alias lxc_attach_exec_t = int function(void* payload);

struct lxc_attach_options_t
{
	int attach_flags;
	int namespaces;
	c_long personality;
	char* initial_cwd;
	uid_t uid;
	gid_t gid;
	lxc_attach_env_policy_t env_policy;
	char** extra_env_vars;
	char** extra_keep_env;
	int stdin_fd;
	int stdout_fd;
	int stderr_fd;
}

enum LXC_ATTACH_OPTIONS_DEFAULT = lxc_attach_options_t(LXC_ATTACH_DEFAULT, -1, -1,
			null, -1, -1, lxc_attach_env_policy_t.LXC_ATTACH_KEEP_ENV, null, null, 0, 1, 2);

struct lxc_attach_command_t
{
	char* program;
	char** argv;
}

int lxc_attach_run_command(void* payload);
int lxc_attach_run_shell(void* payload);
