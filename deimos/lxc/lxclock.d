module deimos.lxc.lxclock;

import deimos.lxc.lxccontainer;
import core.sys.posix.semaphore;

extern (C) nothrow @nogc:

struct lxc_lock
{
	short type;
	union
	{
		sem_t* sem;
		struct
		{
			int fd;
			char* fname;
		}
	}
}

lxc_lock* lxc_newlock(const(char)* lxcpath, const(char)* name);
int lxclock(lxc_lock* lock, int timeout);
int lxcunlock(lxc_lock* lock);
void lxc_putlock(lxc_lock* lock);
void process_lock();
void process_unlock();

int container_mem_lock(lxc_container* c);
void container_mem_unlock(lxc_container* c);
int container_disk_lock(lxc_container* c);
void container_disk_unlock(lxc_container* c);
