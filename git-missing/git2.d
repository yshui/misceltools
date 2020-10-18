


        import core.stdc.config;
        import core.stdc.stdarg: va_list;
        static import core.simd;
        static import std.conv;

        struct Int128 { long lower; long upper; }
        struct UInt128 { ulong lower; ulong upper; }

        struct __locale_data { int dummy; }



alias _Bool = bool;
struct dpp {
    static struct Opaque(int N) {
        void[N] bytes;
    }

    static bool isEmpty(T)() {
        return T.tupleof.length == 0;
    }
    static struct Move(T) {
        T* ptr;
    }


    static auto move(T)(ref T value) {
        return Move!T(&value);
    }
    mixin template EnumD(string name, T, string prefix) if(is(T == enum)) {
        private static string _memberMixinStr(string member) {
            import std.conv: text;
            import std.array: replace;
            return text(` `, member.replace(prefix, ""), ` = `, T.stringof, `.`, member, `,`);
        }
        private static string _enumMixinStr() {
            import std.array: join;
            string[] ret;
            ret ~= "enum " ~ name ~ "{";
            static foreach(member; __traits(allMembers, T)) {
                ret ~= _memberMixinStr(member);
            }
            ret ~= "}";
            return ret.join("\n");
        }
        mixin(_enumMixinStr());
    }
}

extern(C)
{
    alias wchar_t = int;
    alias size_t = c_ulong;
    int timespec_get(timespec*, int) @nogc nothrow;
    int timer_getoverrun(void*) @nogc nothrow;
    int timer_gettime(void*, itimerspec*) @nogc nothrow;
    int timer_settime(void*, int, const(itimerspec)*, itimerspec*) @nogc nothrow;
    int timer_delete(void*) @nogc nothrow;
    int timer_create(int, sigevent*, void**) @nogc nothrow;
    int clock_getcpuclockid(int, int*) @nogc nothrow;
    int clock_nanosleep(int, int, const(timespec)*, timespec*) @nogc nothrow;
    int clock_settime(int, const(timespec)*) @nogc nothrow;
    int clock_gettime(int, timespec*) @nogc nothrow;
    int clock_getres(int, timespec*) @nogc nothrow;
    int nanosleep(const(timespec)*, timespec*) @nogc nothrow;
    int dysize(int) @nogc nothrow;
    c_long timelocal(tm*) @nogc nothrow;
    c_long timegm(tm*) @nogc nothrow;
    extern __gshared c_long timezone;
    extern __gshared int daylight;
    void tzset() @nogc nothrow;
    extern __gshared char*[2] tzname;
    extern __gshared c_long __timezone;
    extern __gshared int __daylight;
    extern __gshared char*[2] __tzname;
    char* ctime_r(const(c_long)*, char*) @nogc nothrow;
    char* asctime_r(const(tm)*, char*) @nogc nothrow;
    char* ctime(const(c_long)*) @nogc nothrow;
    char* asctime(const(tm)*) @nogc nothrow;
    tm* localtime_r(const(c_long)*, tm*) @nogc nothrow;
    tm* gmtime_r(const(c_long)*, tm*) @nogc nothrow;
    tm* localtime(const(c_long)*) @nogc nothrow;
    tm* gmtime(const(c_long)*) @nogc nothrow;
    c_ulong strftime_l(char*, c_ulong, const(char)*, const(tm)*, __locale_struct*) @nogc nothrow;
    c_ulong strftime(char*, c_ulong, const(char)*, const(tm)*) @nogc nothrow;
    c_long mktime(tm*) @nogc nothrow;
    double difftime(c_long, c_long) @nogc nothrow;
    c_long time(c_long*) @nogc nothrow;
    c_long clock() @nogc nothrow;
    alias pid_t = int;
    struct sigevent;
    alias fsfilcnt_t = c_ulong;
    alias fsblkcnt_t = c_ulong;
    alias blkcnt_t = c_long;
    alias blksize_t = c_long;
    alias register_t = c_long;
    alias u_int64_t = c_ulong;
    alias u_int32_t = uint;
    alias u_int16_t = ushort;
    alias u_int8_t = ubyte;
    alias key_t = int;
    alias caddr_t = char*;
    alias daddr_t = int;
    alias ssize_t = c_long;
    alias id_t = uint;
    alias off_t = c_long;
    alias uid_t = uint;
    alias nlink_t = c_ulong;
    alias mode_t = uint;
    alias gid_t = uint;
    alias dev_t = c_ulong;
    alias ino_t = c_ulong;
    alias loff_t = c_long;
    alias fsid_t = __fsid_t;
    alias u_quad_t = c_ulong;
    alias quad_t = c_long;
    alias u_long = c_ulong;
    alias u_int = uint;
    alias u_short = ushort;
    alias u_char = ubyte;
    int pselect(int, fd_set*, fd_set*, fd_set*, const(timespec)*, const(__sigset_t)*) @nogc nothrow;
    int select(int, fd_set*, fd_set*, fd_set*, timeval*) @nogc nothrow;
    alias fd_mask = c_long;
    struct fd_set
    {
        c_long[16] __fds_bits;
    }
    alias __fd_mask = c_long;
    alias suseconds_t = c_long;
    int getloadavg(double*, int) @nogc nothrow;
    int getsubopt(char**, char**, char**) @nogc nothrow;
    int rpmatch(const(char)*) @nogc nothrow;
    c_ulong wcstombs(char*, const(int)*, c_ulong) @nogc nothrow;
    c_ulong mbstowcs(int*, const(char)*, c_ulong) @nogc nothrow;
    int wctomb(char*, int) @nogc nothrow;
    int mbtowc(int*, const(char)*, c_ulong) @nogc nothrow;
    int mblen(const(char)*, c_ulong) @nogc nothrow;
    int qfcvt_r(real, int, int*, int*, char*, c_ulong) @nogc nothrow;
    int qecvt_r(real, int, int*, int*, char*, c_ulong) @nogc nothrow;
    int fcvt_r(double, int, int*, int*, char*, c_ulong) @nogc nothrow;
    int ecvt_r(double, int, int*, int*, char*, c_ulong) @nogc nothrow;
    char* qgcvt(real, int, char*) @nogc nothrow;
    char* qfcvt(real, int, int*, int*) @nogc nothrow;
    char* qecvt(real, int, int*, int*) @nogc nothrow;
    char* gcvt(double, int, char*) @nogc nothrow;
    char* fcvt(double, int, int*, int*) @nogc nothrow;
    pragma(mangle, "alloca") void* alloca_(c_ulong) @nogc nothrow;
    char* ecvt(double, int, int*, int*) @nogc nothrow;
    static ushort __bswap_16(ushort) @nogc nothrow;
    static uint __bswap_32(uint) @nogc nothrow;
    static c_ulong __bswap_64(c_ulong) @nogc nothrow;
    lldiv_t lldiv(long, long) @nogc nothrow;
    ldiv_t ldiv(c_long, c_long) @nogc nothrow;
    div_t div(int, int) @nogc nothrow;
    long llabs(long) @nogc nothrow;
    c_long labs(c_long) @nogc nothrow;
    int abs(int) @nogc nothrow;
    void qsort(void*, c_ulong, c_ulong, int function(const(void)*, const(void)*)) @nogc nothrow;
    void* bsearch(const(void)*, const(void)*, c_ulong, c_ulong, int function(const(void)*, const(void)*)) @nogc nothrow;
    alias __compar_fn_t = int function(const(void)*, const(void)*);
    char* realpath(const(char)*, char*) @nogc nothrow;
    alias _Float32 = float;
    int system(const(char)*) @nogc nothrow;
    alias _Float64 = double;
    char* mkdtemp(char*) @nogc nothrow;
    alias _Float32x = double;
    int mkstemps(char*, int) @nogc nothrow;
    alias _Float64x = real;
    int mkstemp(char*) @nogc nothrow;
    char* mktemp(char*) @nogc nothrow;
    int clearenv() @nogc nothrow;
    int unsetenv(const(char)*) @nogc nothrow;
    int setenv(const(char)*, const(char)*, int) @nogc nothrow;
    int putenv(char*) @nogc nothrow;
    char* getenv(const(char)*) @nogc nothrow;
    void _Exit(int) @nogc nothrow;
    void quick_exit(int) @nogc nothrow;
    void exit(int) @nogc nothrow;
    alias pthread_t = c_ulong;
    union pthread_mutexattr_t
    {
        char[4] __size;
        int __align;
    }
    union pthread_condattr_t
    {
        char[4] __size;
        int __align;
    }
    alias pthread_key_t = uint;
    alias pthread_once_t = int;
    union pthread_attr_t
    {
        char[56] __size;
        c_long __align;
    }
    int on_exit(void function(int, void*), void*) @nogc nothrow;
    union pthread_mutex_t
    {
        __pthread_mutex_s __data;
        char[40] __size;
        c_long __align;
    }
    union pthread_cond_t
    {
        __pthread_cond_s __data;
        char[48] __size;
        long __align;
    }
    union pthread_rwlock_t
    {
        __pthread_rwlock_arch_t __data;
        char[56] __size;
        c_long __align;
    }
    union pthread_rwlockattr_t
    {
        char[8] __size;
        c_long __align;
    }
    alias pthread_spinlock_t = int;
    union pthread_barrier_t
    {
        char[32] __size;
        c_long __align;
    }
    union pthread_barrierattr_t
    {
        char[4] __size;
        int __align;
    }
    int at_quick_exit(void function()) @nogc nothrow;
    alias int8_t = byte;
    alias int16_t = short;
    alias int32_t = int;
    alias int64_t = c_long;
    alias uint8_t = ubyte;
    alias uint16_t = ushort;
    alias uint32_t = uint;
    alias uint64_t = ulong;
    struct __pthread_mutex_s
    {
        int __lock;
        uint __count;
        int __owner;
        uint __nusers;
        int __kind;
        short __spins;
        short __elision;
        __pthread_internal_list __list;
    }
    int atexit(void function()) @nogc nothrow;
    void abort() @nogc nothrow;
    struct __pthread_rwlock_arch_t
    {
        uint __readers;
        uint __writers;
        uint __wrphase_futex;
        uint __writers_futex;
        uint __pad3;
        uint __pad4;
        int __cur_writer;
        int __shared;
        byte __rwelision;
        ubyte[7] __pad1;
        c_ulong __pad2;
        uint __flags;
    }
    alias __pthread_list_t = __pthread_internal_list;
    struct __pthread_internal_list
    {
        __pthread_internal_list* __prev;
        __pthread_internal_list* __next;
    }
    alias __pthread_slist_t = __pthread_internal_slist;
    struct __pthread_internal_slist
    {
        __pthread_internal_slist* __next;
    }
    struct __pthread_cond_s
    {
        static union _Anonymous_0
        {
            ulong __wseq;
            static struct _Anonymous_1
            {
                uint __low;
                uint __high;
            }
            _Anonymous_1 __wseq32;
        }
        _Anonymous_0 _anonymous_2;
        auto __wseq() @property @nogc pure nothrow { return _anonymous_2.__wseq; }
        void __wseq(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_2.__wseq = val; }
        auto __wseq32() @property @nogc pure nothrow { return _anonymous_2.__wseq32; }
        void __wseq32(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_2.__wseq32 = val; }
        static union _Anonymous_3
        {
            ulong __g1_start;
            static struct _Anonymous_4
            {
                uint __low;
                uint __high;
            }
            _Anonymous_4 __g1_start32;
        }
        _Anonymous_3 _anonymous_5;
        auto __g1_start() @property @nogc pure nothrow { return _anonymous_5.__g1_start; }
        void __g1_start(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_5.__g1_start = val; }
        auto __g1_start32() @property @nogc pure nothrow { return _anonymous_5.__g1_start32; }
        void __g1_start32(_T_)(auto ref _T_ val) @property @nogc pure nothrow { _anonymous_5.__g1_start32 = val; }
        uint[2] __g_refs;
        uint[2] __g_size;
        uint __g1_orig_size;
        uint __wrefs;
        uint[2] __g_signals;
    }
    alias __tss_t = uint;
    alias __thrd_t = c_ulong;
    struct __once_flag
    {
        int __data;
    }
    void* aligned_alloc(c_ulong, c_ulong) @nogc nothrow;
    int posix_memalign(void**, c_ulong, c_ulong) @nogc nothrow;
    void* valloc(c_ulong) @nogc nothrow;
    void free(void*) @nogc nothrow;
    alias __u_char = ubyte;
    alias __u_short = ushort;
    alias __u_int = uint;
    alias __u_long = c_ulong;
    alias __int8_t = byte;
    alias __uint8_t = ubyte;
    alias __int16_t = short;
    alias __uint16_t = ushort;
    alias __int32_t = int;
    alias __uint32_t = uint;
    alias __int64_t = c_long;
    alias __uint64_t = c_ulong;
    alias __int_least8_t = byte;
    alias __uint_least8_t = ubyte;
    alias __int_least16_t = short;
    alias __uint_least16_t = ushort;
    alias __int_least32_t = int;
    alias __uint_least32_t = uint;
    alias __int_least64_t = c_long;
    alias __uint_least64_t = c_ulong;
    alias __quad_t = c_long;
    alias __u_quad_t = c_ulong;
    alias __intmax_t = c_long;
    alias __uintmax_t = c_ulong;
    void* reallocarray(void*, c_ulong, c_ulong) @nogc nothrow;
    void* realloc(void*, c_ulong) @nogc nothrow;
    void* calloc(c_ulong, c_ulong) @nogc nothrow;
    alias __dev_t = c_ulong;
    alias __uid_t = uint;
    alias __gid_t = uint;
    alias __ino_t = c_ulong;
    alias __ino64_t = c_ulong;
    alias __mode_t = uint;
    alias __nlink_t = c_ulong;
    alias __off_t = c_long;
    alias __off64_t = c_long;
    alias __pid_t = int;
    struct __fsid_t
    {
        int[2] __val;
    }
    alias __clock_t = c_long;
    alias __rlim_t = c_ulong;
    alias __rlim64_t = c_ulong;
    alias __id_t = uint;
    alias __time_t = c_long;
    alias __useconds_t = uint;
    alias __suseconds_t = c_long;
    alias __suseconds64_t = c_long;
    alias __daddr_t = int;
    alias __key_t = int;
    alias __clockid_t = int;
    alias __timer_t = void*;
    alias __blksize_t = c_long;
    alias __blkcnt_t = c_long;
    alias __blkcnt64_t = c_long;
    alias __fsblkcnt_t = c_ulong;
    alias __fsblkcnt64_t = c_ulong;
    alias __fsfilcnt_t = c_ulong;
    alias __fsfilcnt64_t = c_ulong;
    alias __fsword_t = c_long;
    alias __ssize_t = c_long;
    alias __syscall_slong_t = c_long;
    alias __syscall_ulong_t = c_ulong;
    alias __loff_t = c_long;
    alias __caddr_t = char*;
    alias __intptr_t = c_long;
    alias __socklen_t = uint;
    alias __sig_atomic_t = int;
    struct __locale_struct
    {
        __locale_data*[13] __locales;
        const(ushort)* __ctype_b;
        const(int)* __ctype_tolower;
        const(int)* __ctype_toupper;
        const(char)*[13] __names;
    }
    alias __locale_t = __locale_struct*;
    struct __sigset_t
    {
        c_ulong[16] __val;
    }
    void* malloc(c_ulong) @nogc nothrow;
    alias clock_t = c_long;
    alias clockid_t = int;
    alias locale_t = __locale_struct*;
    int lcong48_r(ushort*, drand48_data*) @nogc nothrow;
    alias sigset_t = __sigset_t;
    struct itimerspec
    {
        timespec it_interval;
        timespec it_value;
    }
    struct timespec
    {
        c_long tv_sec;
        c_long tv_nsec;
    }
    int seed48_r(ushort*, drand48_data*) @nogc nothrow;
    struct timeval
    {
        c_long tv_sec;
        c_long tv_usec;
    }
    struct tm
    {
        int tm_sec;
        int tm_min;
        int tm_hour;
        int tm_mday;
        int tm_mon;
        int tm_year;
        int tm_wday;
        int tm_yday;
        int tm_isdst;
        c_long tm_gmtoff;
        const(char)* tm_zone;
    }
    alias time_t = c_long;
    int srand48_r(c_long, drand48_data*) @nogc nothrow;
    alias timer_t = void*;
    int jrand48_r(ushort*, drand48_data*, c_long*) @nogc nothrow;
    int mrand48_r(drand48_data*, c_long*) @nogc nothrow;
    int nrand48_r(ushort*, drand48_data*, c_long*) @nogc nothrow;
    int lrand48_r(drand48_data*, c_long*) @nogc nothrow;
    int erand48_r(ushort*, drand48_data*, double*) @nogc nothrow;
    int drand48_r(drand48_data*, double*) @nogc nothrow;
    struct drand48_data
    {
        ushort[3] __x;
        ushort[3] __old_x;
        ushort __c;
        ushort __init;
        ulong __a;
    }
    void lcong48(ushort*) @nogc nothrow;
    ushort* seed48(ushort*) @nogc nothrow;
    void srand48(c_long) @nogc nothrow;
    c_long jrand48(ushort*) @nogc nothrow;
    c_long mrand48() @nogc nothrow;
    c_long nrand48(ushort*) @nogc nothrow;
    c_long lrand48() @nogc nothrow;
    double erand48(ushort*) @nogc nothrow;
    double drand48() @nogc nothrow;
    static ushort __uint16_identity(ushort) @nogc nothrow;
    static uint __uint32_identity(uint) @nogc nothrow;
    static c_ulong __uint64_identity(c_ulong) @nogc nothrow;
    int rand_r(uint*) @nogc nothrow;
    void srand(uint) @nogc nothrow;
    int rand() @nogc nothrow;
    int setstate_r(char*, random_data*) @nogc nothrow;
    int initstate_r(uint, char*, c_ulong, random_data*) @nogc nothrow;
    int srandom_r(uint, random_data*) @nogc nothrow;
    int random_r(random_data*, int*) @nogc nothrow;
    struct random_data
    {
        int* fptr;
        int* rptr;
        int* state;
        int rand_type;
        int rand_deg;
        int rand_sep;
        int* end_ptr;
    }
    char* setstate(char*) @nogc nothrow;
    char* initstate(uint, char*, c_ulong) @nogc nothrow;
    void srandom(uint) @nogc nothrow;
    c_long random() @nogc nothrow;
    c_long a64l(const(char)*) @nogc nothrow;
    char* l64a(c_long) @nogc nothrow;
    ulong strtoull(const(char)*, char**, int) @nogc nothrow;
    long strtoll(const(char)*, char**, int) @nogc nothrow;
    ulong strtouq(const(char)*, char**, int) @nogc nothrow;
    long strtoq(const(char)*, char**, int) @nogc nothrow;
    c_ulong strtoul(const(char)*, char**, int) @nogc nothrow;
    c_long strtol(const(char)*, char**, int) @nogc nothrow;
    int git_annotated_commit_from_ref(git_annotated_commit**, git_repository*, const(git_reference)*) @nogc nothrow;
    int git_annotated_commit_from_fetchhead(git_annotated_commit**, git_repository*, const(char)*, const(char)*, const(git_oid)*) @nogc nothrow;
    int git_annotated_commit_lookup(git_annotated_commit**, git_repository*, const(git_oid)*) @nogc nothrow;
    int git_annotated_commit_from_revspec(git_annotated_commit**, git_repository*, const(char)*) @nogc nothrow;
    const(git_oid)* git_annotated_commit_id(const(git_annotated_commit)*) @nogc nothrow;
    const(char)* git_annotated_commit_ref(const(git_annotated_commit)*) @nogc nothrow;
    void git_annotated_commit_free(git_annotated_commit*) @nogc nothrow;
    alias git_apply_delta_cb = int function(const(git_diff_delta)*, void*);
    alias git_apply_hunk_cb = int function(const(git_diff_hunk)*, void*);
    alias git_apply_flags_t = _Anonymous_6;
    enum _Anonymous_6
    {
        GIT_APPLY_CHECK = 1,
    }
    enum GIT_APPLY_CHECK = _Anonymous_6.GIT_APPLY_CHECK;
    struct git_apply_options
    {
        uint version_;
        int function(const(git_diff_delta)*, void*) delta_cb;
        int function(const(git_diff_hunk)*, void*) hunk_cb;
        void* payload;
        uint flags;
    }
    int git_apply_options_init(git_apply_options*, uint) @nogc nothrow;
    int git_apply_to_tree(git_index**, git_repository*, git_tree*, git_diff*, const(git_apply_options)*) @nogc nothrow;
    alias git_apply_location_t = _Anonymous_7;
    enum _Anonymous_7
    {
        GIT_APPLY_LOCATION_WORKDIR = 0,
        GIT_APPLY_LOCATION_INDEX = 1,
        GIT_APPLY_LOCATION_BOTH = 2,
    }
    enum GIT_APPLY_LOCATION_WORKDIR = _Anonymous_7.GIT_APPLY_LOCATION_WORKDIR;
    enum GIT_APPLY_LOCATION_INDEX = _Anonymous_7.GIT_APPLY_LOCATION_INDEX;
    enum GIT_APPLY_LOCATION_BOTH = _Anonymous_7.GIT_APPLY_LOCATION_BOTH;
    int git_apply(git_repository*, git_diff*, git_apply_location_t, const(git_apply_options)*) @nogc nothrow;
    alias git_attr_value_t = _Anonymous_8;
    enum _Anonymous_8
    {
        GIT_ATTR_VALUE_UNSPECIFIED = 0,
        GIT_ATTR_VALUE_TRUE = 1,
        GIT_ATTR_VALUE_FALSE = 2,
        GIT_ATTR_VALUE_STRING = 3,
    }
    enum GIT_ATTR_VALUE_UNSPECIFIED = _Anonymous_8.GIT_ATTR_VALUE_UNSPECIFIED;
    enum GIT_ATTR_VALUE_TRUE = _Anonymous_8.GIT_ATTR_VALUE_TRUE;
    enum GIT_ATTR_VALUE_FALSE = _Anonymous_8.GIT_ATTR_VALUE_FALSE;
    enum GIT_ATTR_VALUE_STRING = _Anonymous_8.GIT_ATTR_VALUE_STRING;
    git_attr_value_t git_attr_value(const(char)*) @nogc nothrow;
    real strtold(const(char)*, char**) @nogc nothrow;
    float strtof(const(char)*, char**) @nogc nothrow;
    int git_attr_get(const(char)**, git_repository*, uint, const(char)*, const(char)*) @nogc nothrow;
    int git_attr_get_many(const(char)**, git_repository*, uint, const(char)*, c_ulong, const(char)**) @nogc nothrow;
    alias git_attr_foreach_cb = int function(const(char)*, const(char)*, void*);
    int git_attr_foreach(git_repository*, uint, const(char)*, int function(const(char)*, const(char)*, void*), void*) @nogc nothrow;
    int git_attr_cache_flush(git_repository*) @nogc nothrow;
    int git_attr_add_macro(git_repository*, const(char)*, const(char)*) @nogc nothrow;
    alias git_blame_flag_t = _Anonymous_9;
    enum _Anonymous_9
    {
        GIT_BLAME_NORMAL = 0,
        GIT_BLAME_TRACK_COPIES_SAME_FILE = 1,
        GIT_BLAME_TRACK_COPIES_SAME_COMMIT_MOVES = 2,
        GIT_BLAME_TRACK_COPIES_SAME_COMMIT_COPIES = 4,
        GIT_BLAME_TRACK_COPIES_ANY_COMMIT_COPIES = 8,
        GIT_BLAME_FIRST_PARENT = 16,
        GIT_BLAME_USE_MAILMAP = 32,
    }
    enum GIT_BLAME_NORMAL = _Anonymous_9.GIT_BLAME_NORMAL;
    enum GIT_BLAME_TRACK_COPIES_SAME_FILE = _Anonymous_9.GIT_BLAME_TRACK_COPIES_SAME_FILE;
    enum GIT_BLAME_TRACK_COPIES_SAME_COMMIT_MOVES = _Anonymous_9.GIT_BLAME_TRACK_COPIES_SAME_COMMIT_MOVES;
    enum GIT_BLAME_TRACK_COPIES_SAME_COMMIT_COPIES = _Anonymous_9.GIT_BLAME_TRACK_COPIES_SAME_COMMIT_COPIES;
    enum GIT_BLAME_TRACK_COPIES_ANY_COMMIT_COPIES = _Anonymous_9.GIT_BLAME_TRACK_COPIES_ANY_COMMIT_COPIES;
    enum GIT_BLAME_FIRST_PARENT = _Anonymous_9.GIT_BLAME_FIRST_PARENT;
    enum GIT_BLAME_USE_MAILMAP = _Anonymous_9.GIT_BLAME_USE_MAILMAP;
    struct git_blame_options
    {
        uint version_;
        uint flags;
        ushort min_match_characters;
        git_oid newest_commit;
        git_oid oldest_commit;
        c_ulong min_line;
        c_ulong max_line;
    }
    double strtod(const(char)*, char**) @nogc nothrow;
    int git_blame_options_init(git_blame_options*, uint) @nogc nothrow;
    struct git_blame_hunk
    {
        c_ulong lines_in_hunk;
        git_oid final_commit_id;
        c_ulong final_start_line_number;
        git_signature* final_signature;
        git_oid orig_commit_id;
        const(char)* orig_path;
        c_ulong orig_start_line_number;
        git_signature* orig_signature;
        char boundary;
    }
    struct git_blame;
    uint git_blame_get_hunk_count(git_blame*) @nogc nothrow;
    const(git_blame_hunk)* git_blame_get_hunk_byindex(git_blame*, uint) @nogc nothrow;
    const(git_blame_hunk)* git_blame_get_hunk_byline(git_blame*, c_ulong) @nogc nothrow;
    int git_blame_file(git_blame**, git_repository*, const(char)*, git_blame_options*) @nogc nothrow;
    int git_blame_buffer(git_blame**, git_blame*, const(char)*, c_ulong) @nogc nothrow;
    void git_blame_free(git_blame*) @nogc nothrow;
    int git_blob_lookup(git_blob**, git_repository*, const(git_oid)*) @nogc nothrow;
    int git_blob_lookup_prefix(git_blob**, git_repository*, const(git_oid)*, c_ulong) @nogc nothrow;
    void git_blob_free(git_blob*) @nogc nothrow;
    const(git_oid)* git_blob_id(const(git_blob)*) @nogc nothrow;
    git_repository* git_blob_owner(const(git_blob)*) @nogc nothrow;
    const(void)* git_blob_rawcontent(const(git_blob)*) @nogc nothrow;
    c_ulong git_blob_rawsize(const(git_blob)*) @nogc nothrow;
    alias git_blob_filter_flag_t = _Anonymous_10;
    enum _Anonymous_10
    {
        GIT_BLOB_FILTER_CHECK_FOR_BINARY = 1,
        GIT_BLOB_FILTER_NO_SYSTEM_ATTRIBUTES = 2,
        GIT_BLOB_FILTER_ATTTRIBUTES_FROM_HEAD = 4,
    }
    enum GIT_BLOB_FILTER_CHECK_FOR_BINARY = _Anonymous_10.GIT_BLOB_FILTER_CHECK_FOR_BINARY;
    enum GIT_BLOB_FILTER_NO_SYSTEM_ATTRIBUTES = _Anonymous_10.GIT_BLOB_FILTER_NO_SYSTEM_ATTRIBUTES;
    enum GIT_BLOB_FILTER_ATTTRIBUTES_FROM_HEAD = _Anonymous_10.GIT_BLOB_FILTER_ATTTRIBUTES_FROM_HEAD;
    struct git_blob_filter_options
    {
        int version_;
        uint flags;
    }
    int git_blob_filter(git_buf*, git_blob*, const(char)*, git_blob_filter_options*) @nogc nothrow;
    int git_blob_create_from_workdir(git_oid*, git_repository*, const(char)*) @nogc nothrow;
    int git_blob_create_from_disk(git_oid*, git_repository*, const(char)*) @nogc nothrow;
    int git_blob_create_from_stream(git_writestream**, git_repository*, const(char)*) @nogc nothrow;
    int git_blob_create_from_stream_commit(git_oid*, git_writestream*) @nogc nothrow;
    int git_blob_create_from_buffer(git_oid*, git_repository*, const(void)*, c_ulong) @nogc nothrow;
    int git_blob_is_binary(const(git_blob)*) @nogc nothrow;
    int git_blob_dup(git_blob**, git_blob*) @nogc nothrow;
    int git_branch_create(git_reference**, git_repository*, const(char)*, const(git_commit)*, int) @nogc nothrow;
    int git_branch_create_from_annotated(git_reference**, git_repository*, const(char)*, const(git_annotated_commit)*, int) @nogc nothrow;
    int git_branch_delete(git_reference*) @nogc nothrow;
    struct git_branch_iterator;
    int git_branch_iterator_new(git_branch_iterator**, git_repository*, git_branch_t) @nogc nothrow;
    int git_branch_next(git_reference**, git_branch_t*, git_branch_iterator*) @nogc nothrow;
    void git_branch_iterator_free(git_branch_iterator*) @nogc nothrow;
    int git_branch_move(git_reference**, git_reference*, const(char)*, int) @nogc nothrow;
    int git_branch_lookup(git_reference**, git_repository*, const(char)*, git_branch_t) @nogc nothrow;
    int git_branch_name(const(char)**, const(git_reference)*) @nogc nothrow;
    int git_branch_upstream(git_reference**, const(git_reference)*) @nogc nothrow;
    int git_branch_set_upstream(git_reference*, const(char)*) @nogc nothrow;
    int git_branch_upstream_name(git_buf*, git_repository*, const(char)*) @nogc nothrow;
    int git_branch_is_head(const(git_reference)*) @nogc nothrow;
    int git_branch_is_checked_out(const(git_reference)*) @nogc nothrow;
    int git_branch_remote_name(git_buf*, git_repository*, const(char)*) @nogc nothrow;
    int git_branch_upstream_remote(git_buf*, git_repository*, const(char)*) @nogc nothrow;
    long atoll(const(char)*) @nogc nothrow;
    struct git_buf
    {
        char* ptr;
        c_ulong asize;
        c_ulong size;
    }
    void git_buf_dispose(git_buf*) @nogc nothrow;
    int git_buf_grow(git_buf*, c_ulong) @nogc nothrow;
    int git_buf_set(git_buf*, const(void)*, c_ulong) @nogc nothrow;
    int git_buf_is_binary(const(git_buf)*) @nogc nothrow;
    int git_buf_contains_nul(const(git_buf)*) @nogc nothrow;
    enum git_cert_t
    {
        GIT_CERT_NONE = 0,
        GIT_CERT_X509 = 1,
        GIT_CERT_HOSTKEY_LIBSSH2 = 2,
        GIT_CERT_STRARRAY = 3,
    }
    enum GIT_CERT_NONE = git_cert_t.GIT_CERT_NONE;
    enum GIT_CERT_X509 = git_cert_t.GIT_CERT_X509;
    enum GIT_CERT_HOSTKEY_LIBSSH2 = git_cert_t.GIT_CERT_HOSTKEY_LIBSSH2;
    enum GIT_CERT_STRARRAY = git_cert_t.GIT_CERT_STRARRAY;
    alias git_transport_certificate_check_cb = int function(git_cert*, int, const(char)*, void*);
    alias git_cert_ssh_t = _Anonymous_11;
    enum _Anonymous_11
    {
        GIT_CERT_SSH_MD5 = 1,
        GIT_CERT_SSH_SHA1 = 2,
        GIT_CERT_SSH_SHA256 = 4,
    }
    enum GIT_CERT_SSH_MD5 = _Anonymous_11.GIT_CERT_SSH_MD5;
    enum GIT_CERT_SSH_SHA1 = _Anonymous_11.GIT_CERT_SSH_SHA1;
    enum GIT_CERT_SSH_SHA256 = _Anonymous_11.GIT_CERT_SSH_SHA256;
    struct git_cert_hostkey
    {
        git_cert parent;
        git_cert_ssh_t type;
        ubyte[16] hash_md5;
        ubyte[20] hash_sha1;
        ubyte[32] hash_sha256;
    }
    struct git_cert_x509
    {
        git_cert parent;
        void* data;
        c_ulong len;
    }
    alias git_checkout_strategy_t = _Anonymous_12;
    enum _Anonymous_12
    {
        GIT_CHECKOUT_NONE = 0,
        GIT_CHECKOUT_SAFE = 1,
        GIT_CHECKOUT_FORCE = 2,
        GIT_CHECKOUT_RECREATE_MISSING = 4,
        GIT_CHECKOUT_ALLOW_CONFLICTS = 16,
        GIT_CHECKOUT_REMOVE_UNTRACKED = 32,
        GIT_CHECKOUT_REMOVE_IGNORED = 64,
        GIT_CHECKOUT_UPDATE_ONLY = 128,
        GIT_CHECKOUT_DONT_UPDATE_INDEX = 256,
        GIT_CHECKOUT_NO_REFRESH = 512,
        GIT_CHECKOUT_SKIP_UNMERGED = 1024,
        GIT_CHECKOUT_USE_OURS = 2048,
        GIT_CHECKOUT_USE_THEIRS = 4096,
        GIT_CHECKOUT_DISABLE_PATHSPEC_MATCH = 8192,
        GIT_CHECKOUT_SKIP_LOCKED_DIRECTORIES = 262144,
        GIT_CHECKOUT_DONT_OVERWRITE_IGNORED = 524288,
        GIT_CHECKOUT_CONFLICT_STYLE_MERGE = 1048576,
        GIT_CHECKOUT_CONFLICT_STYLE_DIFF3 = 2097152,
        GIT_CHECKOUT_DONT_REMOVE_EXISTING = 4194304,
        GIT_CHECKOUT_DONT_WRITE_INDEX = 8388608,
        GIT_CHECKOUT_UPDATE_SUBMODULES = 65536,
        GIT_CHECKOUT_UPDATE_SUBMODULES_IF_CHANGED = 131072,
    }
    enum GIT_CHECKOUT_NONE = _Anonymous_12.GIT_CHECKOUT_NONE;
    enum GIT_CHECKOUT_SAFE = _Anonymous_12.GIT_CHECKOUT_SAFE;
    enum GIT_CHECKOUT_FORCE = _Anonymous_12.GIT_CHECKOUT_FORCE;
    enum GIT_CHECKOUT_RECREATE_MISSING = _Anonymous_12.GIT_CHECKOUT_RECREATE_MISSING;
    enum GIT_CHECKOUT_ALLOW_CONFLICTS = _Anonymous_12.GIT_CHECKOUT_ALLOW_CONFLICTS;
    enum GIT_CHECKOUT_REMOVE_UNTRACKED = _Anonymous_12.GIT_CHECKOUT_REMOVE_UNTRACKED;
    enum GIT_CHECKOUT_REMOVE_IGNORED = _Anonymous_12.GIT_CHECKOUT_REMOVE_IGNORED;
    enum GIT_CHECKOUT_UPDATE_ONLY = _Anonymous_12.GIT_CHECKOUT_UPDATE_ONLY;
    enum GIT_CHECKOUT_DONT_UPDATE_INDEX = _Anonymous_12.GIT_CHECKOUT_DONT_UPDATE_INDEX;
    enum GIT_CHECKOUT_NO_REFRESH = _Anonymous_12.GIT_CHECKOUT_NO_REFRESH;
    enum GIT_CHECKOUT_SKIP_UNMERGED = _Anonymous_12.GIT_CHECKOUT_SKIP_UNMERGED;
    enum GIT_CHECKOUT_USE_OURS = _Anonymous_12.GIT_CHECKOUT_USE_OURS;
    enum GIT_CHECKOUT_USE_THEIRS = _Anonymous_12.GIT_CHECKOUT_USE_THEIRS;
    enum GIT_CHECKOUT_DISABLE_PATHSPEC_MATCH = _Anonymous_12.GIT_CHECKOUT_DISABLE_PATHSPEC_MATCH;
    enum GIT_CHECKOUT_SKIP_LOCKED_DIRECTORIES = _Anonymous_12.GIT_CHECKOUT_SKIP_LOCKED_DIRECTORIES;
    enum GIT_CHECKOUT_DONT_OVERWRITE_IGNORED = _Anonymous_12.GIT_CHECKOUT_DONT_OVERWRITE_IGNORED;
    enum GIT_CHECKOUT_CONFLICT_STYLE_MERGE = _Anonymous_12.GIT_CHECKOUT_CONFLICT_STYLE_MERGE;
    enum GIT_CHECKOUT_CONFLICT_STYLE_DIFF3 = _Anonymous_12.GIT_CHECKOUT_CONFLICT_STYLE_DIFF3;
    enum GIT_CHECKOUT_DONT_REMOVE_EXISTING = _Anonymous_12.GIT_CHECKOUT_DONT_REMOVE_EXISTING;
    enum GIT_CHECKOUT_DONT_WRITE_INDEX = _Anonymous_12.GIT_CHECKOUT_DONT_WRITE_INDEX;
    enum GIT_CHECKOUT_UPDATE_SUBMODULES = _Anonymous_12.GIT_CHECKOUT_UPDATE_SUBMODULES;
    enum GIT_CHECKOUT_UPDATE_SUBMODULES_IF_CHANGED = _Anonymous_12.GIT_CHECKOUT_UPDATE_SUBMODULES_IF_CHANGED;
    alias git_checkout_notify_t = _Anonymous_13;
    enum _Anonymous_13
    {
        GIT_CHECKOUT_NOTIFY_NONE = 0,
        GIT_CHECKOUT_NOTIFY_CONFLICT = 1,
        GIT_CHECKOUT_NOTIFY_DIRTY = 2,
        GIT_CHECKOUT_NOTIFY_UPDATED = 4,
        GIT_CHECKOUT_NOTIFY_UNTRACKED = 8,
        GIT_CHECKOUT_NOTIFY_IGNORED = 16,
        GIT_CHECKOUT_NOTIFY_ALL = 65535,
    }
    enum GIT_CHECKOUT_NOTIFY_NONE = _Anonymous_13.GIT_CHECKOUT_NOTIFY_NONE;
    enum GIT_CHECKOUT_NOTIFY_CONFLICT = _Anonymous_13.GIT_CHECKOUT_NOTIFY_CONFLICT;
    enum GIT_CHECKOUT_NOTIFY_DIRTY = _Anonymous_13.GIT_CHECKOUT_NOTIFY_DIRTY;
    enum GIT_CHECKOUT_NOTIFY_UPDATED = _Anonymous_13.GIT_CHECKOUT_NOTIFY_UPDATED;
    enum GIT_CHECKOUT_NOTIFY_UNTRACKED = _Anonymous_13.GIT_CHECKOUT_NOTIFY_UNTRACKED;
    enum GIT_CHECKOUT_NOTIFY_IGNORED = _Anonymous_13.GIT_CHECKOUT_NOTIFY_IGNORED;
    enum GIT_CHECKOUT_NOTIFY_ALL = _Anonymous_13.GIT_CHECKOUT_NOTIFY_ALL;
    struct git_checkout_perfdata
    {
        c_ulong mkdir_calls;
        c_ulong stat_calls;
        c_ulong chmod_calls;
    }
    alias git_checkout_notify_cb = int function(git_checkout_notify_t, const(char)*, const(git_diff_file)*, const(git_diff_file)*, const(git_diff_file)*, void*);
    alias git_checkout_progress_cb = void function(const(char)*, c_ulong, c_ulong, void*);
    alias git_checkout_perfdata_cb = void function(const(git_checkout_perfdata)*, void*);
    struct git_checkout_options
    {
        uint version_;
        uint checkout_strategy;
        int disable_filters;
        uint dir_mode;
        uint file_mode;
        int file_open_flags;
        uint notify_flags;
        int function(git_checkout_notify_t, const(char)*, const(git_diff_file)*, const(git_diff_file)*, const(git_diff_file)*, void*) notify_cb;
        void* notify_payload;
        void function(const(char)*, c_ulong, c_ulong, void*) progress_cb;
        void* progress_payload;
        git_strarray paths;
        git_tree* baseline;
        git_index* baseline_index;
        const(char)* target_directory;
        const(char)* ancestor_label;
        const(char)* our_label;
        const(char)* their_label;
        void function(const(git_checkout_perfdata)*, void*) perfdata_cb;
        void* perfdata_payload;
    }
    int git_checkout_options_init(git_checkout_options*, uint) @nogc nothrow;
    int git_checkout_head(git_repository*, const(git_checkout_options)*) @nogc nothrow;
    int git_checkout_index(git_repository*, git_index*, const(git_checkout_options)*) @nogc nothrow;
    int git_checkout_tree(git_repository*, const(git_object)*, const(git_checkout_options)*) @nogc nothrow;
    c_long atol(const(char)*) @nogc nothrow;
    struct git_cherrypick_options
    {
        uint version_;
        uint mainline;
        git_merge_options merge_opts;
        git_checkout_options checkout_opts;
    }
    int git_cherrypick_options_init(git_cherrypick_options*, uint) @nogc nothrow;
    int git_cherrypick_commit(git_index**, git_repository*, git_commit*, git_commit*, uint, const(git_merge_options)*) @nogc nothrow;
    int git_cherrypick(git_repository*, git_commit*, const(git_cherrypick_options)*) @nogc nothrow;
    alias git_clone_local_t = _Anonymous_14;
    enum _Anonymous_14
    {
        GIT_CLONE_LOCAL_AUTO = 0,
        GIT_CLONE_LOCAL = 1,
        GIT_CLONE_NO_LOCAL = 2,
        GIT_CLONE_LOCAL_NO_LINKS = 3,
    }
    enum GIT_CLONE_LOCAL_AUTO = _Anonymous_14.GIT_CLONE_LOCAL_AUTO;
    enum GIT_CLONE_LOCAL = _Anonymous_14.GIT_CLONE_LOCAL;
    enum GIT_CLONE_NO_LOCAL = _Anonymous_14.GIT_CLONE_NO_LOCAL;
    enum GIT_CLONE_LOCAL_NO_LINKS = _Anonymous_14.GIT_CLONE_LOCAL_NO_LINKS;
    alias git_remote_create_cb = int function(git_remote**, git_repository*, const(char)*, const(char)*, void*);
    alias git_repository_create_cb = int function(git_repository**, const(char)*, int, void*);
    struct git_clone_options
    {
        uint version_;
        git_checkout_options checkout_opts;
        git_fetch_options fetch_opts;
        int bare;
        git_clone_local_t local;
        const(char)* checkout_branch;
        int function(git_repository**, const(char)*, int, void*) repository_cb;
        void* repository_cb_payload;
        int function(git_remote**, git_repository*, const(char)*, const(char)*, void*) remote_cb;
        void* remote_cb_payload;
    }
    int atoi(const(char)*) @nogc nothrow;
    int git_clone_options_init(git_clone_options*, uint) @nogc nothrow;
    int git_clone(git_repository**, const(char)*, const(char)*, const(git_clone_options)*) @nogc nothrow;
    int git_commit_lookup(git_commit**, git_repository*, const(git_oid)*) @nogc nothrow;
    int git_commit_lookup_prefix(git_commit**, git_repository*, const(git_oid)*, c_ulong) @nogc nothrow;
    void git_commit_free(git_commit*) @nogc nothrow;
    const(git_oid)* git_commit_id(const(git_commit)*) @nogc nothrow;
    git_repository* git_commit_owner(const(git_commit)*) @nogc nothrow;
    const(char)* git_commit_message_encoding(const(git_commit)*) @nogc nothrow;
    const(char)* git_commit_message(const(git_commit)*) @nogc nothrow;
    const(char)* git_commit_message_raw(const(git_commit)*) @nogc nothrow;
    const(char)* git_commit_summary(git_commit*) @nogc nothrow;
    const(char)* git_commit_body(git_commit*) @nogc nothrow;
    c_long git_commit_time(const(git_commit)*) @nogc nothrow;
    int git_commit_time_offset(const(git_commit)*) @nogc nothrow;
    const(git_signature)* git_commit_committer(const(git_commit)*) @nogc nothrow;
    const(git_signature)* git_commit_author(const(git_commit)*) @nogc nothrow;
    int git_commit_committer_with_mailmap(git_signature**, const(git_commit)*, const(git_mailmap)*) @nogc nothrow;
    int git_commit_author_with_mailmap(git_signature**, const(git_commit)*, const(git_mailmap)*) @nogc nothrow;
    const(char)* git_commit_raw_header(const(git_commit)*) @nogc nothrow;
    int git_commit_tree(git_tree**, const(git_commit)*) @nogc nothrow;
    const(git_oid)* git_commit_tree_id(const(git_commit)*) @nogc nothrow;
    uint git_commit_parentcount(const(git_commit)*) @nogc nothrow;
    int git_commit_parent(git_commit**, const(git_commit)*, uint) @nogc nothrow;
    const(git_oid)* git_commit_parent_id(const(git_commit)*, uint) @nogc nothrow;
    int git_commit_nth_gen_ancestor(git_commit**, const(git_commit)*, uint) @nogc nothrow;
    int git_commit_header_field(git_buf*, const(git_commit)*, const(char)*) @nogc nothrow;
    int git_commit_extract_signature(git_buf*, git_buf*, git_repository*, git_oid*, const(char)*) @nogc nothrow;
    int git_commit_create(git_oid*, git_repository*, const(char)*, const(git_signature)*, const(git_signature)*, const(char)*, const(char)*, const(git_tree)*, c_ulong, const(git_commit)**) @nogc nothrow;
    int git_commit_create_v(git_oid*, git_repository*, const(char)*, const(git_signature)*, const(git_signature)*, const(char)*, const(char)*, const(git_tree)*, c_ulong, ...) @nogc nothrow;
    int git_commit_amend(git_oid*, const(git_commit)*, const(char)*, const(git_signature)*, const(git_signature)*, const(char)*, const(char)*, const(git_tree)*) @nogc nothrow;
    int git_commit_create_buffer(git_buf*, git_repository*, const(git_signature)*, const(git_signature)*, const(char)*, const(char)*, const(git_tree)*, c_ulong, const(git_commit)**) @nogc nothrow;
    int git_commit_create_with_signature(git_oid*, git_repository*, const(char)*, const(char)*, const(char)*) @nogc nothrow;
    int git_commit_dup(git_commit**, git_commit*) @nogc nothrow;
    alias git_commit_signing_cb = int function(git_buf*, git_buf*, const(char)*, void*);
    double atof(const(char)*) @nogc nothrow;
    c_ulong __ctype_get_mb_cur_max() @nogc nothrow;
    struct lldiv_t
    {
        long quot;
        long rem;
    }
    int git_libgit2_version(int*, int*, int*) @nogc nothrow;
    alias git_feature_t = _Anonymous_15;
    enum _Anonymous_15
    {
        GIT_FEATURE_THREADS = 1,
        GIT_FEATURE_HTTPS = 2,
        GIT_FEATURE_SSH = 4,
        GIT_FEATURE_NSEC = 8,
    }
    enum GIT_FEATURE_THREADS = _Anonymous_15.GIT_FEATURE_THREADS;
    enum GIT_FEATURE_HTTPS = _Anonymous_15.GIT_FEATURE_HTTPS;
    enum GIT_FEATURE_SSH = _Anonymous_15.GIT_FEATURE_SSH;
    enum GIT_FEATURE_NSEC = _Anonymous_15.GIT_FEATURE_NSEC;
    int git_libgit2_features() @nogc nothrow;
    alias git_libgit2_opt_t = _Anonymous_16;
    enum _Anonymous_16
    {
        GIT_OPT_GET_MWINDOW_SIZE = 0,
        GIT_OPT_SET_MWINDOW_SIZE = 1,
        GIT_OPT_GET_MWINDOW_MAPPED_LIMIT = 2,
        GIT_OPT_SET_MWINDOW_MAPPED_LIMIT = 3,
        GIT_OPT_GET_SEARCH_PATH = 4,
        GIT_OPT_SET_SEARCH_PATH = 5,
        GIT_OPT_SET_CACHE_OBJECT_LIMIT = 6,
        GIT_OPT_SET_CACHE_MAX_SIZE = 7,
        GIT_OPT_ENABLE_CACHING = 8,
        GIT_OPT_GET_CACHED_MEMORY = 9,
        GIT_OPT_GET_TEMPLATE_PATH = 10,
        GIT_OPT_SET_TEMPLATE_PATH = 11,
        GIT_OPT_SET_SSL_CERT_LOCATIONS = 12,
        GIT_OPT_SET_USER_AGENT = 13,
        GIT_OPT_ENABLE_STRICT_OBJECT_CREATION = 14,
        GIT_OPT_ENABLE_STRICT_SYMBOLIC_REF_CREATION = 15,
        GIT_OPT_SET_SSL_CIPHERS = 16,
        GIT_OPT_GET_USER_AGENT = 17,
        GIT_OPT_ENABLE_OFS_DELTA = 18,
        GIT_OPT_ENABLE_FSYNC_GITDIR = 19,
        GIT_OPT_GET_WINDOWS_SHAREMODE = 20,
        GIT_OPT_SET_WINDOWS_SHAREMODE = 21,
        GIT_OPT_ENABLE_STRICT_HASH_VERIFICATION = 22,
        GIT_OPT_SET_ALLOCATOR = 23,
        GIT_OPT_ENABLE_UNSAVED_INDEX_SAFETY = 24,
        GIT_OPT_GET_PACK_MAX_OBJECTS = 25,
        GIT_OPT_SET_PACK_MAX_OBJECTS = 26,
        GIT_OPT_DISABLE_PACK_KEEP_FILE_CHECKS = 27,
        GIT_OPT_ENABLE_HTTP_EXPECT_CONTINUE = 28,
    }
    enum GIT_OPT_GET_MWINDOW_SIZE = _Anonymous_16.GIT_OPT_GET_MWINDOW_SIZE;
    enum GIT_OPT_SET_MWINDOW_SIZE = _Anonymous_16.GIT_OPT_SET_MWINDOW_SIZE;
    enum GIT_OPT_GET_MWINDOW_MAPPED_LIMIT = _Anonymous_16.GIT_OPT_GET_MWINDOW_MAPPED_LIMIT;
    enum GIT_OPT_SET_MWINDOW_MAPPED_LIMIT = _Anonymous_16.GIT_OPT_SET_MWINDOW_MAPPED_LIMIT;
    enum GIT_OPT_GET_SEARCH_PATH = _Anonymous_16.GIT_OPT_GET_SEARCH_PATH;
    enum GIT_OPT_SET_SEARCH_PATH = _Anonymous_16.GIT_OPT_SET_SEARCH_PATH;
    enum GIT_OPT_SET_CACHE_OBJECT_LIMIT = _Anonymous_16.GIT_OPT_SET_CACHE_OBJECT_LIMIT;
    enum GIT_OPT_SET_CACHE_MAX_SIZE = _Anonymous_16.GIT_OPT_SET_CACHE_MAX_SIZE;
    enum GIT_OPT_ENABLE_CACHING = _Anonymous_16.GIT_OPT_ENABLE_CACHING;
    enum GIT_OPT_GET_CACHED_MEMORY = _Anonymous_16.GIT_OPT_GET_CACHED_MEMORY;
    enum GIT_OPT_GET_TEMPLATE_PATH = _Anonymous_16.GIT_OPT_GET_TEMPLATE_PATH;
    enum GIT_OPT_SET_TEMPLATE_PATH = _Anonymous_16.GIT_OPT_SET_TEMPLATE_PATH;
    enum GIT_OPT_SET_SSL_CERT_LOCATIONS = _Anonymous_16.GIT_OPT_SET_SSL_CERT_LOCATIONS;
    enum GIT_OPT_SET_USER_AGENT = _Anonymous_16.GIT_OPT_SET_USER_AGENT;
    enum GIT_OPT_ENABLE_STRICT_OBJECT_CREATION = _Anonymous_16.GIT_OPT_ENABLE_STRICT_OBJECT_CREATION;
    enum GIT_OPT_ENABLE_STRICT_SYMBOLIC_REF_CREATION = _Anonymous_16.GIT_OPT_ENABLE_STRICT_SYMBOLIC_REF_CREATION;
    enum GIT_OPT_SET_SSL_CIPHERS = _Anonymous_16.GIT_OPT_SET_SSL_CIPHERS;
    enum GIT_OPT_GET_USER_AGENT = _Anonymous_16.GIT_OPT_GET_USER_AGENT;
    enum GIT_OPT_ENABLE_OFS_DELTA = _Anonymous_16.GIT_OPT_ENABLE_OFS_DELTA;
    enum GIT_OPT_ENABLE_FSYNC_GITDIR = _Anonymous_16.GIT_OPT_ENABLE_FSYNC_GITDIR;
    enum GIT_OPT_GET_WINDOWS_SHAREMODE = _Anonymous_16.GIT_OPT_GET_WINDOWS_SHAREMODE;
    enum GIT_OPT_SET_WINDOWS_SHAREMODE = _Anonymous_16.GIT_OPT_SET_WINDOWS_SHAREMODE;
    enum GIT_OPT_ENABLE_STRICT_HASH_VERIFICATION = _Anonymous_16.GIT_OPT_ENABLE_STRICT_HASH_VERIFICATION;
    enum GIT_OPT_SET_ALLOCATOR = _Anonymous_16.GIT_OPT_SET_ALLOCATOR;
    enum GIT_OPT_ENABLE_UNSAVED_INDEX_SAFETY = _Anonymous_16.GIT_OPT_ENABLE_UNSAVED_INDEX_SAFETY;
    enum GIT_OPT_GET_PACK_MAX_OBJECTS = _Anonymous_16.GIT_OPT_GET_PACK_MAX_OBJECTS;
    enum GIT_OPT_SET_PACK_MAX_OBJECTS = _Anonymous_16.GIT_OPT_SET_PACK_MAX_OBJECTS;
    enum GIT_OPT_DISABLE_PACK_KEEP_FILE_CHECKS = _Anonymous_16.GIT_OPT_DISABLE_PACK_KEEP_FILE_CHECKS;
    enum GIT_OPT_ENABLE_HTTP_EXPECT_CONTINUE = _Anonymous_16.GIT_OPT_ENABLE_HTTP_EXPECT_CONTINUE;
    int git_libgit2_opts(int, ...) @nogc nothrow;
    alias git_config_level_t = _Anonymous_17;
    enum _Anonymous_17
    {
        GIT_CONFIG_LEVEL_PROGRAMDATA = 1,
        GIT_CONFIG_LEVEL_SYSTEM = 2,
        GIT_CONFIG_LEVEL_XDG = 3,
        GIT_CONFIG_LEVEL_GLOBAL = 4,
        GIT_CONFIG_LEVEL_LOCAL = 5,
        GIT_CONFIG_LEVEL_APP = 6,
        GIT_CONFIG_HIGHEST_LEVEL = -1,
    }
    enum GIT_CONFIG_LEVEL_PROGRAMDATA = _Anonymous_17.GIT_CONFIG_LEVEL_PROGRAMDATA;
    enum GIT_CONFIG_LEVEL_SYSTEM = _Anonymous_17.GIT_CONFIG_LEVEL_SYSTEM;
    enum GIT_CONFIG_LEVEL_XDG = _Anonymous_17.GIT_CONFIG_LEVEL_XDG;
    enum GIT_CONFIG_LEVEL_GLOBAL = _Anonymous_17.GIT_CONFIG_LEVEL_GLOBAL;
    enum GIT_CONFIG_LEVEL_LOCAL = _Anonymous_17.GIT_CONFIG_LEVEL_LOCAL;
    enum GIT_CONFIG_LEVEL_APP = _Anonymous_17.GIT_CONFIG_LEVEL_APP;
    enum GIT_CONFIG_HIGHEST_LEVEL = _Anonymous_17.GIT_CONFIG_HIGHEST_LEVEL;
    struct git_config_entry
    {
        const(char)* name;
        const(char)* value;
        uint include_depth;
        git_config_level_t level;
        void function(git_config_entry*) free;
        void* payload;
    }
    void git_config_entry_free(git_config_entry*) @nogc nothrow;
    alias git_config_foreach_cb = int function(const(git_config_entry)*, void*);
    struct git_config_iterator;
    alias git_configmap_t = _Anonymous_18;
    enum _Anonymous_18
    {
        GIT_CONFIGMAP_FALSE = 0,
        GIT_CONFIGMAP_TRUE = 1,
        GIT_CONFIGMAP_INT32 = 2,
        GIT_CONFIGMAP_STRING = 3,
    }
    enum GIT_CONFIGMAP_FALSE = _Anonymous_18.GIT_CONFIGMAP_FALSE;
    enum GIT_CONFIGMAP_TRUE = _Anonymous_18.GIT_CONFIGMAP_TRUE;
    enum GIT_CONFIGMAP_INT32 = _Anonymous_18.GIT_CONFIGMAP_INT32;
    enum GIT_CONFIGMAP_STRING = _Anonymous_18.GIT_CONFIGMAP_STRING;
    struct git_configmap
    {
        git_configmap_t type;
        const(char)* str_match;
        int map_value;
    }
    int git_config_find_global(git_buf*) @nogc nothrow;
    int git_config_find_xdg(git_buf*) @nogc nothrow;
    int git_config_find_system(git_buf*) @nogc nothrow;
    int git_config_find_programdata(git_buf*) @nogc nothrow;
    int git_config_open_default(git_config**) @nogc nothrow;
    int git_config_new(git_config**) @nogc nothrow;
    int git_config_add_file_ondisk(git_config*, const(char)*, git_config_level_t, const(git_repository)*, int) @nogc nothrow;
    int git_config_open_ondisk(git_config**, const(char)*) @nogc nothrow;
    int git_config_open_level(git_config**, const(git_config)*, git_config_level_t) @nogc nothrow;
    int git_config_open_global(git_config**, git_config*) @nogc nothrow;
    int git_config_snapshot(git_config**, git_config*) @nogc nothrow;
    void git_config_free(git_config*) @nogc nothrow;
    int git_config_get_entry(git_config_entry**, const(git_config)*, const(char)*) @nogc nothrow;
    int git_config_get_int32(int*, const(git_config)*, const(char)*) @nogc nothrow;
    int git_config_get_int64(c_long*, const(git_config)*, const(char)*) @nogc nothrow;
    int git_config_get_bool(int*, const(git_config)*, const(char)*) @nogc nothrow;
    int git_config_get_path(git_buf*, const(git_config)*, const(char)*) @nogc nothrow;
    int git_config_get_string(const(char)**, const(git_config)*, const(char)*) @nogc nothrow;
    int git_config_get_string_buf(git_buf*, const(git_config)*, const(char)*) @nogc nothrow;
    int git_config_get_multivar_foreach(const(git_config)*, const(char)*, const(char)*, int function(const(git_config_entry)*, void*), void*) @nogc nothrow;
    int git_config_multivar_iterator_new(git_config_iterator**, const(git_config)*, const(char)*, const(char)*) @nogc nothrow;
    int git_config_next(git_config_entry**, git_config_iterator*) @nogc nothrow;
    void git_config_iterator_free(git_config_iterator*) @nogc nothrow;
    int git_config_set_int32(git_config*, const(char)*, int) @nogc nothrow;
    int git_config_set_int64(git_config*, const(char)*, c_long) @nogc nothrow;
    int git_config_set_bool(git_config*, const(char)*, int) @nogc nothrow;
    int git_config_set_string(git_config*, const(char)*, const(char)*) @nogc nothrow;
    int git_config_set_multivar(git_config*, const(char)*, const(char)*, const(char)*) @nogc nothrow;
    int git_config_delete_entry(git_config*, const(char)*) @nogc nothrow;
    int git_config_delete_multivar(git_config*, const(char)*, const(char)*) @nogc nothrow;
    int git_config_foreach(const(git_config)*, int function(const(git_config_entry)*, void*), void*) @nogc nothrow;
    int git_config_iterator_new(git_config_iterator**, const(git_config)*) @nogc nothrow;
    int git_config_iterator_glob_new(git_config_iterator**, const(git_config)*, const(char)*) @nogc nothrow;
    int git_config_foreach_match(const(git_config)*, const(char)*, int function(const(git_config_entry)*, void*), void*) @nogc nothrow;
    int git_config_get_mapped(int*, const(git_config)*, const(char)*, const(git_configmap)*, c_ulong) @nogc nothrow;
    int git_config_lookup_map_value(int*, const(git_configmap)*, c_ulong, const(char)*) @nogc nothrow;
    int git_config_parse_bool(int*, const(char)*) @nogc nothrow;
    int git_config_parse_int32(int*, const(char)*) @nogc nothrow;
    int git_config_parse_int64(c_long*, const(char)*) @nogc nothrow;
    int git_config_parse_path(git_buf*, const(char)*) @nogc nothrow;
    int git_config_backend_foreach_match(git_config_backend*, const(char)*, int function(const(git_config_entry)*, void*), void*) @nogc nothrow;
    int git_config_lock(git_transaction**, git_config*) @nogc nothrow;
    struct ldiv_t
    {
        c_long quot;
        c_long rem;
    }
    alias git_credential_t = _Anonymous_19;
    enum _Anonymous_19
    {
        GIT_CREDENTIAL_USERPASS_PLAINTEXT = 1,
        GIT_CREDENTIAL_SSH_KEY = 2,
        GIT_CREDENTIAL_SSH_CUSTOM = 4,
        GIT_CREDENTIAL_DEFAULT = 8,
        GIT_CREDENTIAL_SSH_INTERACTIVE = 16,
        GIT_CREDENTIAL_USERNAME = 32,
        GIT_CREDENTIAL_SSH_MEMORY = 64,
    }
    enum GIT_CREDENTIAL_USERPASS_PLAINTEXT = _Anonymous_19.GIT_CREDENTIAL_USERPASS_PLAINTEXT;
    enum GIT_CREDENTIAL_SSH_KEY = _Anonymous_19.GIT_CREDENTIAL_SSH_KEY;
    enum GIT_CREDENTIAL_SSH_CUSTOM = _Anonymous_19.GIT_CREDENTIAL_SSH_CUSTOM;
    enum GIT_CREDENTIAL_DEFAULT = _Anonymous_19.GIT_CREDENTIAL_DEFAULT;
    enum GIT_CREDENTIAL_SSH_INTERACTIVE = _Anonymous_19.GIT_CREDENTIAL_SSH_INTERACTIVE;
    enum GIT_CREDENTIAL_USERNAME = _Anonymous_19.GIT_CREDENTIAL_USERNAME;
    enum GIT_CREDENTIAL_SSH_MEMORY = _Anonymous_19.GIT_CREDENTIAL_SSH_MEMORY;
    struct git_credential
    {
        git_credential_t credtype;
        void function(git_credential*) free;
    }
    struct git_credential_userpass_plaintext
    {
        git_credential parent;
        char* username;
        char* password;
    }
    struct git_credential_username
    {
        git_credential parent;
        char[1] username;
    }
    alias git_credential_default = git_credential;
    struct git_credential_ssh_key
    {
        git_credential parent;
        char* username;
        char* publickey;
        char* privatekey;
        char* passphrase;
    }
    struct git_credential_ssh_interactive
    {
        git_credential parent;
        char* username;
        void function(const(char)*, int, const(char)*, int, int, const(_LIBSSH2_USERAUTH_KBDINT_PROMPT)*, _LIBSSH2_USERAUTH_KBDINT_RESPONSE*, void**) prompt_callback;
        void* payload;
    }
    struct git_credential_ssh_custom
    {
        git_credential parent;
        char* username;
        char* publickey;
        c_ulong publickey_len;
        int function(_LIBSSH2_SESSION*, ubyte**, c_ulong*, const(ubyte)*, c_ulong, void**) sign_callback;
        void* payload;
    }
    alias git_credential_acquire_cb = int function(git_credential**, const(char)*, const(char)*, uint, void*);
    void git_credential_free(git_credential*) @nogc nothrow;
    int git_credential_has_username(git_credential*) @nogc nothrow;
    const(char)* git_credential_get_username(git_credential*) @nogc nothrow;
    int git_credential_userpass_plaintext_new(git_credential**, const(char)*, const(char)*) @nogc nothrow;
    int git_credential_default_new(git_credential**) @nogc nothrow;
    int git_credential_username_new(git_credential**, const(char)*) @nogc nothrow;
    int git_credential_ssh_key_new(git_credential**, const(char)*, const(char)*, const(char)*, const(char)*) @nogc nothrow;
    int git_credential_ssh_key_memory_new(git_credential**, const(char)*, const(char)*, const(char)*, const(char)*) @nogc nothrow;
    alias LIBSSH2_SESSION = _LIBSSH2_SESSION;
    struct _LIBSSH2_SESSION;
    alias LIBSSH2_USERAUTH_KBDINT_PROMPT = _LIBSSH2_USERAUTH_KBDINT_PROMPT;
    struct _LIBSSH2_USERAUTH_KBDINT_PROMPT;
    alias LIBSSH2_USERAUTH_KBDINT_RESPONSE = _LIBSSH2_USERAUTH_KBDINT_RESPONSE;
    struct _LIBSSH2_USERAUTH_KBDINT_RESPONSE;
    alias git_credential_ssh_interactive_cb = void function(const(char)*, int, const(char)*, int, int, const(_LIBSSH2_USERAUTH_KBDINT_PROMPT)*, _LIBSSH2_USERAUTH_KBDINT_RESPONSE*, void**);
    int git_credential_ssh_interactive_new(git_credential**, const(char)*, void function(const(char)*, int, const(char)*, int, int, const(_LIBSSH2_USERAUTH_KBDINT_PROMPT)*, _LIBSSH2_USERAUTH_KBDINT_RESPONSE*, void**), void*) @nogc nothrow;
    int git_credential_ssh_key_from_agent(git_credential**, const(char)*) @nogc nothrow;
    alias git_credential_sign_cb = int function(_LIBSSH2_SESSION*, ubyte**, c_ulong*, const(ubyte)*, c_ulong, void**);
    int git_credential_ssh_custom_new(git_credential**, const(char)*, const(char)*, c_ulong, int function(_LIBSSH2_SESSION*, ubyte**, c_ulong*, const(ubyte)*, c_ulong, void**), void*) @nogc nothrow;
    struct git_credential_userpass_payload
    {
        const(char)* username;
        const(char)* password;
    }
    int git_credential_userpass(git_credential**, const(char)*, const(char)*, uint, void*) @nogc nothrow;
    struct div_t
    {
        int quot;
        int rem;
    }
    alias git_attr_t = git_attr_value_t;
    int git_blob_create_fromworkdir(git_oid*, git_repository*, const(char)*) @nogc nothrow;
    int git_blob_create_fromdisk(git_oid*, git_repository*, const(char)*) @nogc nothrow;
    int git_blob_create_fromstream(git_writestream**, git_repository*, const(char)*) @nogc nothrow;
    int git_blob_create_fromstream_commit(git_oid*, git_writestream*) @nogc nothrow;
    int git_blob_create_frombuffer(git_oid*, git_repository*, const(void)*, c_ulong) @nogc nothrow;
    int git_blob_filtered_content(git_buf*, git_blob*, const(char)*, int) @nogc nothrow;
    void git_buf_free(git_buf*) @nogc nothrow;
    alias git_cvar_map = git_configmap;
    alias uintmax_t = c_ulong;
    alias intmax_t = c_long;
    alias uintptr_t = c_ulong;
    alias intptr_t = c_long;
    alias uint_fast64_t = c_ulong;
    alias uint_fast32_t = c_ulong;
    alias uint_fast16_t = c_ulong;
    alias uint_fast8_t = ubyte;
    alias int_fast64_t = c_long;
    alias int_fast32_t = c_long;
    alias int_fast16_t = c_long;
    alias int_fast8_t = byte;
    alias uint_least64_t = c_ulong;
    alias uint_least32_t = uint;
    alias uint_least16_t = ushort;
    alias uint_least8_t = ubyte;
    alias int_least64_t = c_long;
    alias int_least32_t = int;
    alias int_least16_t = short;
    alias int_least8_t = byte;
    const(git_error)* giterr_last() @nogc nothrow;
    void giterr_clear() @nogc nothrow;
    void giterr_set_str(int, const(char)*) @nogc nothrow;
    void giterr_set_oom() @nogc nothrow;
    c_ulong wcstoumax(const(int)*, int**, int) @nogc nothrow;
    c_long wcstoimax(const(int)*, int**, int) @nogc nothrow;
    c_ulong strtoumax(const(char)*, char**, int) @nogc nothrow;
    c_long strtoimax(const(char)*, char**, int) @nogc nothrow;
    imaxdiv_t imaxdiv(c_long, c_long) @nogc nothrow;
    c_long imaxabs(c_long) @nogc nothrow;
    struct imaxdiv_t
    {
        c_long quot;
        c_long rem;
    }
    alias __gwchar_t = int;
    int git_index_add_frombuffer(git_index*, const(git_index_entry)*, const(void)*, c_ulong) @nogc nothrow;
    int git_worktree_prune(git_worktree*, git_worktree_prune_options*) @nogc nothrow;
    int git_worktree_is_prunable(git_worktree*, git_worktree_prune_options*) @nogc nothrow;
    c_ulong git_object__size(git_object_t) @nogc nothrow;
    int git_worktree_prune_options_init(git_worktree_prune_options*, uint) @nogc nothrow;
    struct git_worktree_prune_options
    {
        uint version_;
        uint flags;
    }
    enum _Anonymous_20
    {
        GIT_WORKTREE_PRUNE_VALID = 1,
        GIT_WORKTREE_PRUNE_LOCKED = 2,
        GIT_WORKTREE_PRUNE_WORKING_TREE = 4,
    }
    enum GIT_WORKTREE_PRUNE_VALID = _Anonymous_20.GIT_WORKTREE_PRUNE_VALID;
    enum GIT_WORKTREE_PRUNE_LOCKED = _Anonymous_20.GIT_WORKTREE_PRUNE_LOCKED;
    enum GIT_WORKTREE_PRUNE_WORKING_TREE = _Anonymous_20.GIT_WORKTREE_PRUNE_WORKING_TREE;
    alias git_worktree_prune_t = _Anonymous_20;
    const(char)* git_worktree_path(const(git_worktree)*) @nogc nothrow;
    const(char)* git_worktree_name(const(git_worktree)*) @nogc nothrow;
    int git_tag_create_frombuffer(git_oid*, git_repository*, const(char)*, int) @nogc nothrow;
    alias git_cred = git_credential;
    alias git_cred_userpass_plaintext = git_credential_userpass_plaintext;
    alias git_cred_username = git_credential_username;
    alias git_cred_default = git_credential;
    alias git_cred_ssh_key = git_credential_ssh_key;
    alias git_cred_ssh_interactive = git_credential_ssh_interactive;
    alias git_cred_ssh_custom = git_credential_ssh_custom;
    alias git_cred_acquire_cb = int function(git_credential**, const(char)*, const(char)*, uint, void*);
    alias git_cred_sign_callback = int function(_LIBSSH2_SESSION*, ubyte**, c_ulong*, const(ubyte)*, c_ulong, void**);
    alias git_cred_sign_cb = int function(_LIBSSH2_SESSION*, ubyte**, c_ulong*, const(ubyte)*, c_ulong, void**);
    alias git_cred_ssh_interactive_callback = void function(const(char)*, int, const(char)*, int, int, const(_LIBSSH2_USERAUTH_KBDINT_PROMPT)*, _LIBSSH2_USERAUTH_KBDINT_RESPONSE*, void**);
    alias git_cred_ssh_interactive_cb = void function(const(char)*, int, const(char)*, int, int, const(_LIBSSH2_USERAUTH_KBDINT_PROMPT)*, _LIBSSH2_USERAUTH_KBDINT_RESPONSE*, void**);
    int git_worktree_is_locked(git_buf*, const(git_worktree)*) @nogc nothrow;
    int git_worktree_unlock(git_worktree*) @nogc nothrow;
    int git_worktree_lock(git_worktree*, const(char)*) @nogc nothrow;
    int git_worktree_add(git_worktree**, git_repository*, const(char)*, const(char)*, const(git_worktree_add_options)*) @nogc nothrow;
    void git_cred_free(git_credential*) @nogc nothrow;
    int git_cred_has_username(git_credential*) @nogc nothrow;
    const(char)* git_cred_get_username(git_credential*) @nogc nothrow;
    int git_cred_userpass_plaintext_new(git_credential**, const(char)*, const(char)*) @nogc nothrow;
    int git_cred_default_new(git_credential**) @nogc nothrow;
    int git_cred_username_new(git_credential**, const(char)*) @nogc nothrow;
    int git_cred_ssh_key_new(git_credential**, const(char)*, const(char)*, const(char)*, const(char)*) @nogc nothrow;
    int git_cred_ssh_key_memory_new(git_credential**, const(char)*, const(char)*, const(char)*, const(char)*) @nogc nothrow;
    int git_cred_ssh_interactive_new(git_credential**, const(char)*, void function(const(char)*, int, const(char)*, int, int, const(_LIBSSH2_USERAUTH_KBDINT_PROMPT)*, _LIBSSH2_USERAUTH_KBDINT_RESPONSE*, void**), void*) @nogc nothrow;
    int git_cred_ssh_key_from_agent(git_credential**, const(char)*) @nogc nothrow;
    int git_cred_ssh_custom_new(git_credential**, const(char)*, const(char)*, c_ulong, int function(_LIBSSH2_SESSION*, ubyte**, c_ulong*, const(ubyte)*, c_ulong, void**), void*) @nogc nothrow;
    alias git_cred_userpass_payload = git_credential_userpass_payload;
    int git_cred_userpass(git_credential**, const(char)*, const(char)*, uint, void*) @nogc nothrow;
    alias git_trace_callback = void function(git_trace_level_t, const(char)*);
    int git_oid_iszero(const(git_oid)*) @nogc nothrow;
    alias git_transfer_progress = git_indexer_progress;
    alias git_transfer_progress_cb = int function(const(git_indexer_progress)*, void*);
    alias git_push_transfer_progress = int function(uint, uint, c_ulong, void*);
    alias git_headlist_cb = int function(git_remote_head*, void*);
    int git_blame_init_options(git_blame_options*, uint) @nogc nothrow;
    int git_checkout_init_options(git_checkout_options*, uint) @nogc nothrow;
    int git_cherrypick_init_options(git_cherrypick_options*, uint) @nogc nothrow;
    int git_clone_init_options(git_clone_options*, uint) @nogc nothrow;
    int git_describe_init_options(git_describe_options*, uint) @nogc nothrow;
    int git_describe_init_format_options(git_describe_format_options*, uint) @nogc nothrow;
    int git_diff_init_options(git_diff_options*, uint) @nogc nothrow;
    int git_diff_find_init_options(git_diff_find_options*, uint) @nogc nothrow;
    int git_diff_format_email_init_options(git_diff_format_email_options*, uint) @nogc nothrow;
    int git_diff_patchid_init_options(git_diff_patchid_options*, uint) @nogc nothrow;
    int git_fetch_init_options(git_fetch_options*, uint) @nogc nothrow;
    int git_indexer_init_options(git_indexer_options*, uint) @nogc nothrow;
    int git_merge_init_options(git_merge_options*, uint) @nogc nothrow;
    int git_merge_file_init_input(git_merge_file_input*, uint) @nogc nothrow;
    int git_merge_file_init_options(git_merge_file_options*, uint) @nogc nothrow;
    int git_proxy_init_options(git_proxy_options*, uint) @nogc nothrow;
    int git_push_init_options(git_push_options*, uint) @nogc nothrow;
    int git_rebase_init_options(git_rebase_options*, uint) @nogc nothrow;
    int git_remote_create_init_options(git_remote_create_options*, uint) @nogc nothrow;
    int git_repository_init_init_options(git_repository_init_options*, uint) @nogc nothrow;
    int git_revert_init_options(git_revert_options*, uint) @nogc nothrow;
    int git_stash_apply_init_options(git_stash_apply_options*, uint) @nogc nothrow;
    int git_status_init_options(git_status_options*, uint) @nogc nothrow;
    int git_submodule_update_init_options(git_submodule_update_options*, uint) @nogc nothrow;
    int git_worktree_add_init_options(git_worktree_add_options*, uint) @nogc nothrow;
    int git_worktree_prune_init_options(git_worktree_prune_options*, uint) @nogc nothrow;
    int git_worktree_add_options_init(git_worktree_add_options*, uint) @nogc nothrow;
    alias git_describe_strategy_t = _Anonymous_21;
    enum _Anonymous_21
    {
        GIT_DESCRIBE_DEFAULT = 0,
        GIT_DESCRIBE_TAGS = 1,
        GIT_DESCRIBE_ALL = 2,
    }
    enum GIT_DESCRIBE_DEFAULT = _Anonymous_21.GIT_DESCRIBE_DEFAULT;
    enum GIT_DESCRIBE_TAGS = _Anonymous_21.GIT_DESCRIBE_TAGS;
    enum GIT_DESCRIBE_ALL = _Anonymous_21.GIT_DESCRIBE_ALL;
    struct git_describe_options
    {
        uint version_;
        uint max_candidates_tags;
        uint describe_strategy;
        const(char)* pattern;
        int only_follow_first_parent;
        int show_commit_oid_as_fallback;
    }
    struct git_worktree_add_options
    {
        uint version_;
        int lock;
        git_reference* ref_;
    }
    int git_worktree_validate(const(git_worktree)*) @nogc nothrow;
    int git_describe_options_init(git_describe_options*, uint) @nogc nothrow;
    struct git_describe_format_options
    {
        uint version_;
        uint abbreviated_size;
        int always_use_long_format;
        const(char)* dirty_suffix;
    }
    void git_worktree_free(git_worktree*) @nogc nothrow;
    int git_describe_format_options_init(git_describe_format_options*, uint) @nogc nothrow;
    struct git_describe_result;
    int git_describe_commit(git_describe_result**, git_object*, git_describe_options*) @nogc nothrow;
    int git_describe_workdir(git_describe_result**, git_repository*, git_describe_options*) @nogc nothrow;
    int git_describe_format(git_buf*, const(git_describe_result)*, const(git_describe_format_options)*) @nogc nothrow;
    void git_describe_result_free(git_describe_result*) @nogc nothrow;
    int git_worktree_open_from_repository(git_worktree**, git_repository*) @nogc nothrow;
    alias git_diff_option_t = _Anonymous_22;
    enum _Anonymous_22
    {
        GIT_DIFF_NORMAL = 0,
        GIT_DIFF_REVERSE = 1,
        GIT_DIFF_INCLUDE_IGNORED = 2,
        GIT_DIFF_RECURSE_IGNORED_DIRS = 4,
        GIT_DIFF_INCLUDE_UNTRACKED = 8,
        GIT_DIFF_RECURSE_UNTRACKED_DIRS = 16,
        GIT_DIFF_INCLUDE_UNMODIFIED = 32,
        GIT_DIFF_INCLUDE_TYPECHANGE = 64,
        GIT_DIFF_INCLUDE_TYPECHANGE_TREES = 128,
        GIT_DIFF_IGNORE_FILEMODE = 256,
        GIT_DIFF_IGNORE_SUBMODULES = 512,
        GIT_DIFF_IGNORE_CASE = 1024,
        GIT_DIFF_INCLUDE_CASECHANGE = 2048,
        GIT_DIFF_DISABLE_PATHSPEC_MATCH = 4096,
        GIT_DIFF_SKIP_BINARY_CHECK = 8192,
        GIT_DIFF_ENABLE_FAST_UNTRACKED_DIRS = 16384,
        GIT_DIFF_UPDATE_INDEX = 32768,
        GIT_DIFF_INCLUDE_UNREADABLE = 65536,
        GIT_DIFF_INCLUDE_UNREADABLE_AS_UNTRACKED = 131072,
        GIT_DIFF_INDENT_HEURISTIC = 262144,
        GIT_DIFF_FORCE_TEXT = 1048576,
        GIT_DIFF_FORCE_BINARY = 2097152,
        GIT_DIFF_IGNORE_WHITESPACE = 4194304,
        GIT_DIFF_IGNORE_WHITESPACE_CHANGE = 8388608,
        GIT_DIFF_IGNORE_WHITESPACE_EOL = 16777216,
        GIT_DIFF_SHOW_UNTRACKED_CONTENT = 33554432,
        GIT_DIFF_SHOW_UNMODIFIED = 67108864,
        GIT_DIFF_PATIENCE = 268435456,
        GIT_DIFF_MINIMAL = 536870912,
        GIT_DIFF_SHOW_BINARY = 1073741824,
    }
    enum GIT_DIFF_NORMAL = _Anonymous_22.GIT_DIFF_NORMAL;
    enum GIT_DIFF_REVERSE = _Anonymous_22.GIT_DIFF_REVERSE;
    enum GIT_DIFF_INCLUDE_IGNORED = _Anonymous_22.GIT_DIFF_INCLUDE_IGNORED;
    enum GIT_DIFF_RECURSE_IGNORED_DIRS = _Anonymous_22.GIT_DIFF_RECURSE_IGNORED_DIRS;
    enum GIT_DIFF_INCLUDE_UNTRACKED = _Anonymous_22.GIT_DIFF_INCLUDE_UNTRACKED;
    enum GIT_DIFF_RECURSE_UNTRACKED_DIRS = _Anonymous_22.GIT_DIFF_RECURSE_UNTRACKED_DIRS;
    enum GIT_DIFF_INCLUDE_UNMODIFIED = _Anonymous_22.GIT_DIFF_INCLUDE_UNMODIFIED;
    enum GIT_DIFF_INCLUDE_TYPECHANGE = _Anonymous_22.GIT_DIFF_INCLUDE_TYPECHANGE;
    enum GIT_DIFF_INCLUDE_TYPECHANGE_TREES = _Anonymous_22.GIT_DIFF_INCLUDE_TYPECHANGE_TREES;
    enum GIT_DIFF_IGNORE_FILEMODE = _Anonymous_22.GIT_DIFF_IGNORE_FILEMODE;
    enum GIT_DIFF_IGNORE_SUBMODULES = _Anonymous_22.GIT_DIFF_IGNORE_SUBMODULES;
    enum GIT_DIFF_IGNORE_CASE = _Anonymous_22.GIT_DIFF_IGNORE_CASE;
    enum GIT_DIFF_INCLUDE_CASECHANGE = _Anonymous_22.GIT_DIFF_INCLUDE_CASECHANGE;
    enum GIT_DIFF_DISABLE_PATHSPEC_MATCH = _Anonymous_22.GIT_DIFF_DISABLE_PATHSPEC_MATCH;
    enum GIT_DIFF_SKIP_BINARY_CHECK = _Anonymous_22.GIT_DIFF_SKIP_BINARY_CHECK;
    enum GIT_DIFF_ENABLE_FAST_UNTRACKED_DIRS = _Anonymous_22.GIT_DIFF_ENABLE_FAST_UNTRACKED_DIRS;
    enum GIT_DIFF_UPDATE_INDEX = _Anonymous_22.GIT_DIFF_UPDATE_INDEX;
    enum GIT_DIFF_INCLUDE_UNREADABLE = _Anonymous_22.GIT_DIFF_INCLUDE_UNREADABLE;
    enum GIT_DIFF_INCLUDE_UNREADABLE_AS_UNTRACKED = _Anonymous_22.GIT_DIFF_INCLUDE_UNREADABLE_AS_UNTRACKED;
    enum GIT_DIFF_INDENT_HEURISTIC = _Anonymous_22.GIT_DIFF_INDENT_HEURISTIC;
    enum GIT_DIFF_FORCE_TEXT = _Anonymous_22.GIT_DIFF_FORCE_TEXT;
    enum GIT_DIFF_FORCE_BINARY = _Anonymous_22.GIT_DIFF_FORCE_BINARY;
    enum GIT_DIFF_IGNORE_WHITESPACE = _Anonymous_22.GIT_DIFF_IGNORE_WHITESPACE;
    enum GIT_DIFF_IGNORE_WHITESPACE_CHANGE = _Anonymous_22.GIT_DIFF_IGNORE_WHITESPACE_CHANGE;
    enum GIT_DIFF_IGNORE_WHITESPACE_EOL = _Anonymous_22.GIT_DIFF_IGNORE_WHITESPACE_EOL;
    enum GIT_DIFF_SHOW_UNTRACKED_CONTENT = _Anonymous_22.GIT_DIFF_SHOW_UNTRACKED_CONTENT;
    enum GIT_DIFF_SHOW_UNMODIFIED = _Anonymous_22.GIT_DIFF_SHOW_UNMODIFIED;
    enum GIT_DIFF_PATIENCE = _Anonymous_22.GIT_DIFF_PATIENCE;
    enum GIT_DIFF_MINIMAL = _Anonymous_22.GIT_DIFF_MINIMAL;
    enum GIT_DIFF_SHOW_BINARY = _Anonymous_22.GIT_DIFF_SHOW_BINARY;
    struct git_diff;
    alias git_diff_flag_t = _Anonymous_23;
    enum _Anonymous_23
    {
        GIT_DIFF_FLAG_BINARY = 1,
        GIT_DIFF_FLAG_NOT_BINARY = 2,
        GIT_DIFF_FLAG_VALID_ID = 4,
        GIT_DIFF_FLAG_EXISTS = 8,
    }
    enum GIT_DIFF_FLAG_BINARY = _Anonymous_23.GIT_DIFF_FLAG_BINARY;
    enum GIT_DIFF_FLAG_NOT_BINARY = _Anonymous_23.GIT_DIFF_FLAG_NOT_BINARY;
    enum GIT_DIFF_FLAG_VALID_ID = _Anonymous_23.GIT_DIFF_FLAG_VALID_ID;
    enum GIT_DIFF_FLAG_EXISTS = _Anonymous_23.GIT_DIFF_FLAG_EXISTS;
    alias git_delta_t = _Anonymous_24;
    enum _Anonymous_24
    {
        GIT_DELTA_UNMODIFIED = 0,
        GIT_DELTA_ADDED = 1,
        GIT_DELTA_DELETED = 2,
        GIT_DELTA_MODIFIED = 3,
        GIT_DELTA_RENAMED = 4,
        GIT_DELTA_COPIED = 5,
        GIT_DELTA_IGNORED = 6,
        GIT_DELTA_UNTRACKED = 7,
        GIT_DELTA_TYPECHANGE = 8,
        GIT_DELTA_UNREADABLE = 9,
        GIT_DELTA_CONFLICTED = 10,
    }
    enum GIT_DELTA_UNMODIFIED = _Anonymous_24.GIT_DELTA_UNMODIFIED;
    enum GIT_DELTA_ADDED = _Anonymous_24.GIT_DELTA_ADDED;
    enum GIT_DELTA_DELETED = _Anonymous_24.GIT_DELTA_DELETED;
    enum GIT_DELTA_MODIFIED = _Anonymous_24.GIT_DELTA_MODIFIED;
    enum GIT_DELTA_RENAMED = _Anonymous_24.GIT_DELTA_RENAMED;
    enum GIT_DELTA_COPIED = _Anonymous_24.GIT_DELTA_COPIED;
    enum GIT_DELTA_IGNORED = _Anonymous_24.GIT_DELTA_IGNORED;
    enum GIT_DELTA_UNTRACKED = _Anonymous_24.GIT_DELTA_UNTRACKED;
    enum GIT_DELTA_TYPECHANGE = _Anonymous_24.GIT_DELTA_TYPECHANGE;
    enum GIT_DELTA_UNREADABLE = _Anonymous_24.GIT_DELTA_UNREADABLE;
    enum GIT_DELTA_CONFLICTED = _Anonymous_24.GIT_DELTA_CONFLICTED;
    struct git_diff_file
    {
        git_oid id;
        const(char)* path;
        c_ulong size;
        uint flags;
        ushort mode;
        ushort id_abbrev;
    }
    struct git_diff_delta
    {
        git_delta_t status;
        uint flags;
        ushort similarity;
        ushort nfiles;
        git_diff_file old_file;
        git_diff_file new_file;
    }
    alias git_diff_notify_cb = int function(const(git_diff)*, const(git_diff_delta)*, const(char)*, void*);
    alias git_diff_progress_cb = int function(const(git_diff)*, const(char)*, const(char)*, void*);
    struct git_diff_options
    {
        uint version_;
        uint flags;
        git_submodule_ignore_t ignore_submodules;
        git_strarray pathspec;
        int function(const(git_diff)*, const(git_diff_delta)*, const(char)*, void*) notify_cb;
        int function(const(git_diff)*, const(char)*, const(char)*, void*) progress_cb;
        void* payload;
        uint context_lines;
        uint interhunk_lines;
        ushort id_abbrev;
        c_long max_size;
        const(char)* old_prefix;
        const(char)* new_prefix;
    }
    int git_worktree_lookup(git_worktree**, git_repository*, const(char)*) @nogc nothrow;
    int git_diff_options_init(git_diff_options*, uint) @nogc nothrow;
    alias git_diff_file_cb = int function(const(git_diff_delta)*, float, void*);
    alias git_diff_binary_t = _Anonymous_25;
    enum _Anonymous_25
    {
        GIT_DIFF_BINARY_NONE = 0,
        GIT_DIFF_BINARY_LITERAL = 1,
        GIT_DIFF_BINARY_DELTA = 2,
    }
    enum GIT_DIFF_BINARY_NONE = _Anonymous_25.GIT_DIFF_BINARY_NONE;
    enum GIT_DIFF_BINARY_LITERAL = _Anonymous_25.GIT_DIFF_BINARY_LITERAL;
    enum GIT_DIFF_BINARY_DELTA = _Anonymous_25.GIT_DIFF_BINARY_DELTA;
    struct git_diff_binary_file
    {
        git_diff_binary_t type;
        const(char)* data;
        c_ulong datalen;
        c_ulong inflatedlen;
    }
    struct git_diff_binary
    {
        uint contains_data;
        git_diff_binary_file old_file;
        git_diff_binary_file new_file;
    }
    alias git_diff_binary_cb = int function(const(git_diff_delta)*, const(git_diff_binary)*, void*);
    struct git_diff_hunk
    {
        int old_start;
        int old_lines;
        int new_start;
        int new_lines;
        c_ulong header_len;
        char[128] header;
    }
    alias git_diff_hunk_cb = int function(const(git_diff_delta)*, const(git_diff_hunk)*, void*);
    alias git_diff_line_t = _Anonymous_26;
    enum _Anonymous_26
    {
        GIT_DIFF_LINE_CONTEXT = 32,
        GIT_DIFF_LINE_ADDITION = 43,
        GIT_DIFF_LINE_DELETION = 45,
        GIT_DIFF_LINE_CONTEXT_EOFNL = 61,
        GIT_DIFF_LINE_ADD_EOFNL = 62,
        GIT_DIFF_LINE_DEL_EOFNL = 60,
        GIT_DIFF_LINE_FILE_HDR = 70,
        GIT_DIFF_LINE_HUNK_HDR = 72,
        GIT_DIFF_LINE_BINARY = 66,
    }
    enum GIT_DIFF_LINE_CONTEXT = _Anonymous_26.GIT_DIFF_LINE_CONTEXT;
    enum GIT_DIFF_LINE_ADDITION = _Anonymous_26.GIT_DIFF_LINE_ADDITION;
    enum GIT_DIFF_LINE_DELETION = _Anonymous_26.GIT_DIFF_LINE_DELETION;
    enum GIT_DIFF_LINE_CONTEXT_EOFNL = _Anonymous_26.GIT_DIFF_LINE_CONTEXT_EOFNL;
    enum GIT_DIFF_LINE_ADD_EOFNL = _Anonymous_26.GIT_DIFF_LINE_ADD_EOFNL;
    enum GIT_DIFF_LINE_DEL_EOFNL = _Anonymous_26.GIT_DIFF_LINE_DEL_EOFNL;
    enum GIT_DIFF_LINE_FILE_HDR = _Anonymous_26.GIT_DIFF_LINE_FILE_HDR;
    enum GIT_DIFF_LINE_HUNK_HDR = _Anonymous_26.GIT_DIFF_LINE_HUNK_HDR;
    enum GIT_DIFF_LINE_BINARY = _Anonymous_26.GIT_DIFF_LINE_BINARY;
    struct git_diff_line
    {
        char origin;
        int old_lineno;
        int new_lineno;
        int num_lines;
        c_ulong content_len;
        c_long content_offset;
        const(char)* content;
    }
    alias git_diff_line_cb = int function(const(git_diff_delta)*, const(git_diff_hunk)*, const(git_diff_line)*, void*);
    alias git_diff_find_t = _Anonymous_27;
    enum _Anonymous_27
    {
        GIT_DIFF_FIND_BY_CONFIG = 0,
        GIT_DIFF_FIND_RENAMES = 1,
        GIT_DIFF_FIND_RENAMES_FROM_REWRITES = 2,
        GIT_DIFF_FIND_COPIES = 4,
        GIT_DIFF_FIND_COPIES_FROM_UNMODIFIED = 8,
        GIT_DIFF_FIND_REWRITES = 16,
        GIT_DIFF_BREAK_REWRITES = 32,
        GIT_DIFF_FIND_AND_BREAK_REWRITES = 48,
        GIT_DIFF_FIND_FOR_UNTRACKED = 64,
        GIT_DIFF_FIND_ALL = 255,
        GIT_DIFF_FIND_IGNORE_LEADING_WHITESPACE = 0,
        GIT_DIFF_FIND_IGNORE_WHITESPACE = 4096,
        GIT_DIFF_FIND_DONT_IGNORE_WHITESPACE = 8192,
        GIT_DIFF_FIND_EXACT_MATCH_ONLY = 16384,
        GIT_DIFF_BREAK_REWRITES_FOR_RENAMES_ONLY = 32768,
        GIT_DIFF_FIND_REMOVE_UNMODIFIED = 65536,
    }
    enum GIT_DIFF_FIND_BY_CONFIG = _Anonymous_27.GIT_DIFF_FIND_BY_CONFIG;
    enum GIT_DIFF_FIND_RENAMES = _Anonymous_27.GIT_DIFF_FIND_RENAMES;
    enum GIT_DIFF_FIND_RENAMES_FROM_REWRITES = _Anonymous_27.GIT_DIFF_FIND_RENAMES_FROM_REWRITES;
    enum GIT_DIFF_FIND_COPIES = _Anonymous_27.GIT_DIFF_FIND_COPIES;
    enum GIT_DIFF_FIND_COPIES_FROM_UNMODIFIED = _Anonymous_27.GIT_DIFF_FIND_COPIES_FROM_UNMODIFIED;
    enum GIT_DIFF_FIND_REWRITES = _Anonymous_27.GIT_DIFF_FIND_REWRITES;
    enum GIT_DIFF_BREAK_REWRITES = _Anonymous_27.GIT_DIFF_BREAK_REWRITES;
    enum GIT_DIFF_FIND_AND_BREAK_REWRITES = _Anonymous_27.GIT_DIFF_FIND_AND_BREAK_REWRITES;
    enum GIT_DIFF_FIND_FOR_UNTRACKED = _Anonymous_27.GIT_DIFF_FIND_FOR_UNTRACKED;
    enum GIT_DIFF_FIND_ALL = _Anonymous_27.GIT_DIFF_FIND_ALL;
    enum GIT_DIFF_FIND_IGNORE_LEADING_WHITESPACE = _Anonymous_27.GIT_DIFF_FIND_IGNORE_LEADING_WHITESPACE;
    enum GIT_DIFF_FIND_IGNORE_WHITESPACE = _Anonymous_27.GIT_DIFF_FIND_IGNORE_WHITESPACE;
    enum GIT_DIFF_FIND_DONT_IGNORE_WHITESPACE = _Anonymous_27.GIT_DIFF_FIND_DONT_IGNORE_WHITESPACE;
    enum GIT_DIFF_FIND_EXACT_MATCH_ONLY = _Anonymous_27.GIT_DIFF_FIND_EXACT_MATCH_ONLY;
    enum GIT_DIFF_BREAK_REWRITES_FOR_RENAMES_ONLY = _Anonymous_27.GIT_DIFF_BREAK_REWRITES_FOR_RENAMES_ONLY;
    enum GIT_DIFF_FIND_REMOVE_UNMODIFIED = _Anonymous_27.GIT_DIFF_FIND_REMOVE_UNMODIFIED;
    struct git_diff_similarity_metric
    {
        int function(void**, const(git_diff_file)*, const(char)*, void*) file_signature;
        int function(void**, const(git_diff_file)*, const(char)*, c_ulong, void*) buffer_signature;
        void function(void*, void*) free_signature;
        int function(int*, void*, void*, void*) similarity;
        void* payload;
    }
    struct git_diff_find_options
    {
        uint version_;
        uint flags;
        ushort rename_threshold;
        ushort rename_from_rewrite_threshold;
        ushort copy_threshold;
        ushort break_rewrite_threshold;
        c_ulong rename_limit;
        git_diff_similarity_metric* metric;
    }
    int git_worktree_list(git_strarray*, git_repository*) @nogc nothrow;
    int git_diff_find_options_init(git_diff_find_options*, uint) @nogc nothrow;
    void git_diff_free(git_diff*) @nogc nothrow;
    int git_diff_tree_to_tree(git_diff**, git_repository*, git_tree*, git_tree*, const(git_diff_options)*) @nogc nothrow;
    int git_diff_tree_to_index(git_diff**, git_repository*, git_tree*, git_index*, const(git_diff_options)*) @nogc nothrow;
    int git_diff_index_to_workdir(git_diff**, git_repository*, git_index*, const(git_diff_options)*) @nogc nothrow;
    int git_diff_tree_to_workdir(git_diff**, git_repository*, git_tree*, const(git_diff_options)*) @nogc nothrow;
    int git_diff_tree_to_workdir_with_index(git_diff**, git_repository*, git_tree*, const(git_diff_options)*) @nogc nothrow;
    int git_diff_index_to_index(git_diff**, git_repository*, git_index*, git_index*, const(git_diff_options)*) @nogc nothrow;
    int git_diff_merge(git_diff*, const(git_diff)*) @nogc nothrow;
    int git_diff_find_similar(git_diff*, const(git_diff_find_options)*) @nogc nothrow;
    c_ulong git_diff_num_deltas(const(git_diff)*) @nogc nothrow;
    c_ulong git_diff_num_deltas_of_type(const(git_diff)*, git_delta_t) @nogc nothrow;
    const(git_diff_delta)* git_diff_get_delta(const(git_diff)*, c_ulong) @nogc nothrow;
    int git_diff_is_sorted_icase(const(git_diff)*) @nogc nothrow;
    int git_diff_foreach(git_diff*, int function(const(git_diff_delta)*, float, void*), int function(const(git_diff_delta)*, const(git_diff_binary)*, void*), int function(const(git_diff_delta)*, const(git_diff_hunk)*, void*), int function(const(git_diff_delta)*, const(git_diff_hunk)*, const(git_diff_line)*, void*), void*) @nogc nothrow;
    char git_diff_status_char(git_delta_t) @nogc nothrow;
    alias git_diff_format_t = _Anonymous_28;
    enum _Anonymous_28
    {
        GIT_DIFF_FORMAT_PATCH = 1,
        GIT_DIFF_FORMAT_PATCH_HEADER = 2,
        GIT_DIFF_FORMAT_RAW = 3,
        GIT_DIFF_FORMAT_NAME_ONLY = 4,
        GIT_DIFF_FORMAT_NAME_STATUS = 5,
        GIT_DIFF_FORMAT_PATCH_ID = 6,
    }
    enum GIT_DIFF_FORMAT_PATCH = _Anonymous_28.GIT_DIFF_FORMAT_PATCH;
    enum GIT_DIFF_FORMAT_PATCH_HEADER = _Anonymous_28.GIT_DIFF_FORMAT_PATCH_HEADER;
    enum GIT_DIFF_FORMAT_RAW = _Anonymous_28.GIT_DIFF_FORMAT_RAW;
    enum GIT_DIFF_FORMAT_NAME_ONLY = _Anonymous_28.GIT_DIFF_FORMAT_NAME_ONLY;
    enum GIT_DIFF_FORMAT_NAME_STATUS = _Anonymous_28.GIT_DIFF_FORMAT_NAME_STATUS;
    enum GIT_DIFF_FORMAT_PATCH_ID = _Anonymous_28.GIT_DIFF_FORMAT_PATCH_ID;
    int git_diff_print(git_diff*, git_diff_format_t, int function(const(git_diff_delta)*, const(git_diff_hunk)*, const(git_diff_line)*, void*), void*) @nogc nothrow;
    int git_diff_to_buf(git_buf*, git_diff*, git_diff_format_t) @nogc nothrow;
    int git_diff_blobs(const(git_blob)*, const(char)*, const(git_blob)*, const(char)*, const(git_diff_options)*, int function(const(git_diff_delta)*, float, void*), int function(const(git_diff_delta)*, const(git_diff_binary)*, void*), int function(const(git_diff_delta)*, const(git_diff_hunk)*, void*), int function(const(git_diff_delta)*, const(git_diff_hunk)*, const(git_diff_line)*, void*), void*) @nogc nothrow;
    int git_diff_blob_to_buffer(const(git_blob)*, const(char)*, const(char)*, c_ulong, const(char)*, const(git_diff_options)*, int function(const(git_diff_delta)*, float, void*), int function(const(git_diff_delta)*, const(git_diff_binary)*, void*), int function(const(git_diff_delta)*, const(git_diff_hunk)*, void*), int function(const(git_diff_delta)*, const(git_diff_hunk)*, const(git_diff_line)*, void*), void*) @nogc nothrow;
    int git_diff_buffers(const(void)*, c_ulong, const(char)*, const(void)*, c_ulong, const(char)*, const(git_diff_options)*, int function(const(git_diff_delta)*, float, void*), int function(const(git_diff_delta)*, const(git_diff_binary)*, void*), int function(const(git_diff_delta)*, const(git_diff_hunk)*, void*), int function(const(git_diff_delta)*, const(git_diff_hunk)*, const(git_diff_line)*, void*), void*) @nogc nothrow;
    int git_diff_from_buffer(git_diff**, const(char)*, c_ulong) @nogc nothrow;
    struct git_diff_stats;
    alias git_diff_stats_format_t = _Anonymous_29;
    enum _Anonymous_29
    {
        GIT_DIFF_STATS_NONE = 0,
        GIT_DIFF_STATS_FULL = 1,
        GIT_DIFF_STATS_SHORT = 2,
        GIT_DIFF_STATS_NUMBER = 4,
        GIT_DIFF_STATS_INCLUDE_SUMMARY = 8,
    }
    enum GIT_DIFF_STATS_NONE = _Anonymous_29.GIT_DIFF_STATS_NONE;
    enum GIT_DIFF_STATS_FULL = _Anonymous_29.GIT_DIFF_STATS_FULL;
    enum GIT_DIFF_STATS_SHORT = _Anonymous_29.GIT_DIFF_STATS_SHORT;
    enum GIT_DIFF_STATS_NUMBER = _Anonymous_29.GIT_DIFF_STATS_NUMBER;
    enum GIT_DIFF_STATS_INCLUDE_SUMMARY = _Anonymous_29.GIT_DIFF_STATS_INCLUDE_SUMMARY;
    int git_diff_get_stats(git_diff_stats**, git_diff*) @nogc nothrow;
    c_ulong git_diff_stats_files_changed(const(git_diff_stats)*) @nogc nothrow;
    c_ulong git_diff_stats_insertions(const(git_diff_stats)*) @nogc nothrow;
    c_ulong git_diff_stats_deletions(const(git_diff_stats)*) @nogc nothrow;
    int git_diff_stats_to_buf(git_buf*, const(git_diff_stats)*, git_diff_stats_format_t, c_ulong) @nogc nothrow;
    void git_diff_stats_free(git_diff_stats*) @nogc nothrow;
    alias git_diff_format_email_flags_t = _Anonymous_30;
    enum _Anonymous_30
    {
        GIT_DIFF_FORMAT_EMAIL_NONE = 0,
        GIT_DIFF_FORMAT_EMAIL_EXCLUDE_SUBJECT_PATCH_MARKER = 1,
    }
    enum GIT_DIFF_FORMAT_EMAIL_NONE = _Anonymous_30.GIT_DIFF_FORMAT_EMAIL_NONE;
    enum GIT_DIFF_FORMAT_EMAIL_EXCLUDE_SUBJECT_PATCH_MARKER = _Anonymous_30.GIT_DIFF_FORMAT_EMAIL_EXCLUDE_SUBJECT_PATCH_MARKER;
    struct git_diff_format_email_options
    {
        uint version_;
        uint flags;
        c_ulong patch_no;
        c_ulong total_patches;
        const(git_oid)* id;
        const(char)* summary;
        const(char)* body_;
        const(git_signature)* author;
    }
    int git_diff_format_email(git_buf*, git_diff*, const(git_diff_format_email_options)*) @nogc nothrow;
    int git_diff_commit_as_email(git_buf*, git_repository*, git_commit*, c_ulong, c_ulong, uint, const(git_diff_options)*) @nogc nothrow;
    int git_diff_format_email_options_init(git_diff_format_email_options*, uint) @nogc nothrow;
    struct git_diff_patchid_options
    {
        uint version_;
    }
    int git_diff_patchid_options_init(git_diff_patchid_options*, uint) @nogc nothrow;
    int git_diff_patchid(git_oid*, git_diff*, git_diff_patchid_options*) @nogc nothrow;
    alias git_error_code = _Anonymous_31;
    enum _Anonymous_31
    {
        GIT_OK = 0,
        GIT_ERROR = -1,
        GIT_ENOTFOUND = -3,
        GIT_EEXISTS = -4,
        GIT_EAMBIGUOUS = -5,
        GIT_EBUFS = -6,
        GIT_EUSER = -7,
        GIT_EBAREREPO = -8,
        GIT_EUNBORNBRANCH = -9,
        GIT_EUNMERGED = -10,
        GIT_ENONFASTFORWARD = -11,
        GIT_EINVALIDSPEC = -12,
        GIT_ECONFLICT = -13,
        GIT_ELOCKED = -14,
        GIT_EMODIFIED = -15,
        GIT_EAUTH = -16,
        GIT_ECERTIFICATE = -17,
        GIT_EAPPLIED = -18,
        GIT_EPEEL = -19,
        GIT_EEOF = -20,
        GIT_EINVALID = -21,
        GIT_EUNCOMMITTED = -22,
        GIT_EDIRECTORY = -23,
        GIT_EMERGECONFLICT = -24,
        GIT_PASSTHROUGH = -30,
        GIT_ITEROVER = -31,
        GIT_RETRY = -32,
        GIT_EMISMATCH = -33,
        GIT_EINDEXDIRTY = -34,
        GIT_EAPPLYFAIL = -35,
    }
    enum GIT_OK = _Anonymous_31.GIT_OK;
    enum GIT_ERROR = _Anonymous_31.GIT_ERROR;
    enum GIT_ENOTFOUND = _Anonymous_31.GIT_ENOTFOUND;
    enum GIT_EEXISTS = _Anonymous_31.GIT_EEXISTS;
    enum GIT_EAMBIGUOUS = _Anonymous_31.GIT_EAMBIGUOUS;
    enum GIT_EBUFS = _Anonymous_31.GIT_EBUFS;
    enum GIT_EUSER = _Anonymous_31.GIT_EUSER;
    enum GIT_EBAREREPO = _Anonymous_31.GIT_EBAREREPO;
    enum GIT_EUNBORNBRANCH = _Anonymous_31.GIT_EUNBORNBRANCH;
    enum GIT_EUNMERGED = _Anonymous_31.GIT_EUNMERGED;
    enum GIT_ENONFASTFORWARD = _Anonymous_31.GIT_ENONFASTFORWARD;
    enum GIT_EINVALIDSPEC = _Anonymous_31.GIT_EINVALIDSPEC;
    enum GIT_ECONFLICT = _Anonymous_31.GIT_ECONFLICT;
    enum GIT_ELOCKED = _Anonymous_31.GIT_ELOCKED;
    enum GIT_EMODIFIED = _Anonymous_31.GIT_EMODIFIED;
    enum GIT_EAUTH = _Anonymous_31.GIT_EAUTH;
    enum GIT_ECERTIFICATE = _Anonymous_31.GIT_ECERTIFICATE;
    enum GIT_EAPPLIED = _Anonymous_31.GIT_EAPPLIED;
    enum GIT_EPEEL = _Anonymous_31.GIT_EPEEL;
    enum GIT_EEOF = _Anonymous_31.GIT_EEOF;
    enum GIT_EINVALID = _Anonymous_31.GIT_EINVALID;
    enum GIT_EUNCOMMITTED = _Anonymous_31.GIT_EUNCOMMITTED;
    enum GIT_EDIRECTORY = _Anonymous_31.GIT_EDIRECTORY;
    enum GIT_EMERGECONFLICT = _Anonymous_31.GIT_EMERGECONFLICT;
    enum GIT_PASSTHROUGH = _Anonymous_31.GIT_PASSTHROUGH;
    enum GIT_ITEROVER = _Anonymous_31.GIT_ITEROVER;
    enum GIT_RETRY = _Anonymous_31.GIT_RETRY;
    enum GIT_EMISMATCH = _Anonymous_31.GIT_EMISMATCH;
    enum GIT_EINDEXDIRTY = _Anonymous_31.GIT_EINDEXDIRTY;
    enum GIT_EAPPLYFAIL = _Anonymous_31.GIT_EAPPLYFAIL;
    struct git_error
    {
        char* message;
        int klass;
    }
    alias git_error_t = _Anonymous_32;
    enum _Anonymous_32
    {
        GIT_ERROR_NONE = 0,
        GIT_ERROR_NOMEMORY = 1,
        GIT_ERROR_OS = 2,
        GIT_ERROR_INVALID = 3,
        GIT_ERROR_REFERENCE = 4,
        GIT_ERROR_ZLIB = 5,
        GIT_ERROR_REPOSITORY = 6,
        GIT_ERROR_CONFIG = 7,
        GIT_ERROR_REGEX = 8,
        GIT_ERROR_ODB = 9,
        GIT_ERROR_INDEX = 10,
        GIT_ERROR_OBJECT = 11,
        GIT_ERROR_NET = 12,
        GIT_ERROR_TAG = 13,
        GIT_ERROR_TREE = 14,
        GIT_ERROR_INDEXER = 15,
        GIT_ERROR_SSL = 16,
        GIT_ERROR_SUBMODULE = 17,
        GIT_ERROR_THREAD = 18,
        GIT_ERROR_STASH = 19,
        GIT_ERROR_CHECKOUT = 20,
        GIT_ERROR_FETCHHEAD = 21,
        GIT_ERROR_MERGE = 22,
        GIT_ERROR_SSH = 23,
        GIT_ERROR_FILTER = 24,
        GIT_ERROR_REVERT = 25,
        GIT_ERROR_CALLBACK = 26,
        GIT_ERROR_CHERRYPICK = 27,
        GIT_ERROR_DESCRIBE = 28,
        GIT_ERROR_REBASE = 29,
        GIT_ERROR_FILESYSTEM = 30,
        GIT_ERROR_PATCH = 31,
        GIT_ERROR_WORKTREE = 32,
        GIT_ERROR_SHA1 = 33,
        GIT_ERROR_HTTP = 34,
    }
    enum GIT_ERROR_NONE = _Anonymous_32.GIT_ERROR_NONE;
    enum GIT_ERROR_NOMEMORY = _Anonymous_32.GIT_ERROR_NOMEMORY;
    enum GIT_ERROR_OS = _Anonymous_32.GIT_ERROR_OS;
    enum GIT_ERROR_INVALID = _Anonymous_32.GIT_ERROR_INVALID;
    enum GIT_ERROR_REFERENCE = _Anonymous_32.GIT_ERROR_REFERENCE;
    enum GIT_ERROR_ZLIB = _Anonymous_32.GIT_ERROR_ZLIB;
    enum GIT_ERROR_REPOSITORY = _Anonymous_32.GIT_ERROR_REPOSITORY;
    enum GIT_ERROR_CONFIG = _Anonymous_32.GIT_ERROR_CONFIG;
    enum GIT_ERROR_REGEX = _Anonymous_32.GIT_ERROR_REGEX;
    enum GIT_ERROR_ODB = _Anonymous_32.GIT_ERROR_ODB;
    enum GIT_ERROR_INDEX = _Anonymous_32.GIT_ERROR_INDEX;
    enum GIT_ERROR_OBJECT = _Anonymous_32.GIT_ERROR_OBJECT;
    enum GIT_ERROR_NET = _Anonymous_32.GIT_ERROR_NET;
    enum GIT_ERROR_TAG = _Anonymous_32.GIT_ERROR_TAG;
    enum GIT_ERROR_TREE = _Anonymous_32.GIT_ERROR_TREE;
    enum GIT_ERROR_INDEXER = _Anonymous_32.GIT_ERROR_INDEXER;
    enum GIT_ERROR_SSL = _Anonymous_32.GIT_ERROR_SSL;
    enum GIT_ERROR_SUBMODULE = _Anonymous_32.GIT_ERROR_SUBMODULE;
    enum GIT_ERROR_THREAD = _Anonymous_32.GIT_ERROR_THREAD;
    enum GIT_ERROR_STASH = _Anonymous_32.GIT_ERROR_STASH;
    enum GIT_ERROR_CHECKOUT = _Anonymous_32.GIT_ERROR_CHECKOUT;
    enum GIT_ERROR_FETCHHEAD = _Anonymous_32.GIT_ERROR_FETCHHEAD;
    enum GIT_ERROR_MERGE = _Anonymous_32.GIT_ERROR_MERGE;
    enum GIT_ERROR_SSH = _Anonymous_32.GIT_ERROR_SSH;
    enum GIT_ERROR_FILTER = _Anonymous_32.GIT_ERROR_FILTER;
    enum GIT_ERROR_REVERT = _Anonymous_32.GIT_ERROR_REVERT;
    enum GIT_ERROR_CALLBACK = _Anonymous_32.GIT_ERROR_CALLBACK;
    enum GIT_ERROR_CHERRYPICK = _Anonymous_32.GIT_ERROR_CHERRYPICK;
    enum GIT_ERROR_DESCRIBE = _Anonymous_32.GIT_ERROR_DESCRIBE;
    enum GIT_ERROR_REBASE = _Anonymous_32.GIT_ERROR_REBASE;
    enum GIT_ERROR_FILESYSTEM = _Anonymous_32.GIT_ERROR_FILESYSTEM;
    enum GIT_ERROR_PATCH = _Anonymous_32.GIT_ERROR_PATCH;
    enum GIT_ERROR_WORKTREE = _Anonymous_32.GIT_ERROR_WORKTREE;
    enum GIT_ERROR_SHA1 = _Anonymous_32.GIT_ERROR_SHA1;
    enum GIT_ERROR_HTTP = _Anonymous_32.GIT_ERROR_HTTP;
    const(git_error)* git_error_last() @nogc nothrow;
    void git_error_clear() @nogc nothrow;
    int git_error_set_str(int, const(char)*) @nogc nothrow;
    void git_error_set_oom() @nogc nothrow;
    alias git_filter_mode_t = _Anonymous_33;
    enum _Anonymous_33
    {
        GIT_FILTER_TO_WORKTREE = 0,
        GIT_FILTER_SMUDGE = 0,
        GIT_FILTER_TO_ODB = 1,
        GIT_FILTER_CLEAN = 1,
    }
    enum GIT_FILTER_TO_WORKTREE = _Anonymous_33.GIT_FILTER_TO_WORKTREE;
    enum GIT_FILTER_SMUDGE = _Anonymous_33.GIT_FILTER_SMUDGE;
    enum GIT_FILTER_TO_ODB = _Anonymous_33.GIT_FILTER_TO_ODB;
    enum GIT_FILTER_CLEAN = _Anonymous_33.GIT_FILTER_CLEAN;
    alias git_filter_flag_t = _Anonymous_34;
    enum _Anonymous_34
    {
        GIT_FILTER_DEFAULT = 0,
        GIT_FILTER_ALLOW_UNSAFE = 1,
        GIT_FILTER_NO_SYSTEM_ATTRIBUTES = 2,
        GIT_FILTER_ATTRIBUTES_FROM_HEAD = 4,
    }
    enum GIT_FILTER_DEFAULT = _Anonymous_34.GIT_FILTER_DEFAULT;
    enum GIT_FILTER_ALLOW_UNSAFE = _Anonymous_34.GIT_FILTER_ALLOW_UNSAFE;
    enum GIT_FILTER_NO_SYSTEM_ATTRIBUTES = _Anonymous_34.GIT_FILTER_NO_SYSTEM_ATTRIBUTES;
    enum GIT_FILTER_ATTRIBUTES_FROM_HEAD = _Anonymous_34.GIT_FILTER_ATTRIBUTES_FROM_HEAD;
    struct git_filter;
    struct git_filter_list;
    int git_filter_list_load(git_filter_list**, git_repository*, git_blob*, const(char)*, git_filter_mode_t, uint) @nogc nothrow;
    int git_filter_list_contains(git_filter_list*, const(char)*) @nogc nothrow;
    int git_filter_list_apply_to_data(git_buf*, git_filter_list*, git_buf*) @nogc nothrow;
    int git_filter_list_apply_to_file(git_buf*, git_filter_list*, git_repository*, const(char)*) @nogc nothrow;
    int git_filter_list_apply_to_blob(git_buf*, git_filter_list*, git_blob*) @nogc nothrow;
    int git_filter_list_stream_data(git_filter_list*, git_buf*, git_writestream*) @nogc nothrow;
    int git_filter_list_stream_file(git_filter_list*, git_repository*, const(char)*, git_writestream*) @nogc nothrow;
    int git_filter_list_stream_blob(git_filter_list*, git_blob*, git_writestream*) @nogc nothrow;
    void git_filter_list_free(git_filter_list*) @nogc nothrow;
    struct git_mailmap;
    int git_libgit2_init() @nogc nothrow;
    int git_libgit2_shutdown() @nogc nothrow;
    int git_graph_ahead_behind(c_ulong*, c_ulong*, git_repository*, const(git_oid)*, const(git_oid)*) @nogc nothrow;
    int git_graph_descendant_of(git_repository*, const(git_oid)*, const(git_oid)*) @nogc nothrow;
    int git_ignore_add_rule(git_repository*, const(char)*) @nogc nothrow;
    int git_ignore_clear_internal_rules(git_repository*) @nogc nothrow;
    int git_ignore_path_is_ignored(int*, git_repository*, const(char)*) @nogc nothrow;
    struct git_index_time
    {
        int seconds;
        uint nanoseconds;
    }
    struct git_index_entry
    {
        git_index_time ctime;
        git_index_time mtime;
        uint dev;
        uint ino;
        uint mode;
        uint uid;
        uint gid;
        uint file_size;
        git_oid id;
        ushort flags;
        ushort flags_extended;
        const(char)* path;
    }
    struct git_writestream
    {
        int function(git_writestream*, const(char)*, c_ulong) write;
        int function(git_writestream*) close;
        void function(git_writestream*) free;
    }
    alias git_index_entry_flag_t = _Anonymous_35;
    enum _Anonymous_35
    {
        GIT_INDEX_ENTRY_EXTENDED = 16384,
        GIT_INDEX_ENTRY_VALID = 32768,
    }
    enum GIT_INDEX_ENTRY_EXTENDED = _Anonymous_35.GIT_INDEX_ENTRY_EXTENDED;
    enum GIT_INDEX_ENTRY_VALID = _Anonymous_35.GIT_INDEX_ENTRY_VALID;
    enum _Anonymous_36
    {
        GIT_SUBMODULE_RECURSE_NO = 0,
        GIT_SUBMODULE_RECURSE_YES = 1,
        GIT_SUBMODULE_RECURSE_ONDEMAND = 2,
    }
    enum GIT_SUBMODULE_RECURSE_NO = _Anonymous_36.GIT_SUBMODULE_RECURSE_NO;
    enum GIT_SUBMODULE_RECURSE_YES = _Anonymous_36.GIT_SUBMODULE_RECURSE_YES;
    enum GIT_SUBMODULE_RECURSE_ONDEMAND = _Anonymous_36.GIT_SUBMODULE_RECURSE_ONDEMAND;
    alias git_submodule_recurse_t = _Anonymous_36;
    alias git_index_entry_extended_flag_t = _Anonymous_37;
    enum _Anonymous_37
    {
        GIT_INDEX_ENTRY_INTENT_TO_ADD = 8192,
        GIT_INDEX_ENTRY_SKIP_WORKTREE = 16384,
        GIT_INDEX_ENTRY_EXTENDED_FLAGS = 24576,
        GIT_INDEX_ENTRY_UPTODATE = 4,
    }
    enum GIT_INDEX_ENTRY_INTENT_TO_ADD = _Anonymous_37.GIT_INDEX_ENTRY_INTENT_TO_ADD;
    enum GIT_INDEX_ENTRY_SKIP_WORKTREE = _Anonymous_37.GIT_INDEX_ENTRY_SKIP_WORKTREE;
    enum GIT_INDEX_ENTRY_EXTENDED_FLAGS = _Anonymous_37.GIT_INDEX_ENTRY_EXTENDED_FLAGS;
    enum GIT_INDEX_ENTRY_UPTODATE = _Anonymous_37.GIT_INDEX_ENTRY_UPTODATE;
    alias git_index_capability_t = _Anonymous_38;
    enum _Anonymous_38
    {
        GIT_INDEX_CAPABILITY_IGNORE_CASE = 1,
        GIT_INDEX_CAPABILITY_NO_FILEMODE = 2,
        GIT_INDEX_CAPABILITY_NO_SYMLINKS = 4,
        GIT_INDEX_CAPABILITY_FROM_OWNER = -1,
    }
    enum GIT_INDEX_CAPABILITY_IGNORE_CASE = _Anonymous_38.GIT_INDEX_CAPABILITY_IGNORE_CASE;
    enum GIT_INDEX_CAPABILITY_NO_FILEMODE = _Anonymous_38.GIT_INDEX_CAPABILITY_NO_FILEMODE;
    enum GIT_INDEX_CAPABILITY_NO_SYMLINKS = _Anonymous_38.GIT_INDEX_CAPABILITY_NO_SYMLINKS;
    enum GIT_INDEX_CAPABILITY_FROM_OWNER = _Anonymous_38.GIT_INDEX_CAPABILITY_FROM_OWNER;
    alias git_index_matched_path_cb = int function(const(char)*, const(char)*, void*);
    alias git_index_add_option_t = _Anonymous_39;
    enum _Anonymous_39
    {
        GIT_INDEX_ADD_DEFAULT = 0,
        GIT_INDEX_ADD_FORCE = 1,
        GIT_INDEX_ADD_DISABLE_PATHSPEC_MATCH = 2,
        GIT_INDEX_ADD_CHECK_PATHSPEC = 4,
    }
    enum GIT_INDEX_ADD_DEFAULT = _Anonymous_39.GIT_INDEX_ADD_DEFAULT;
    enum GIT_INDEX_ADD_FORCE = _Anonymous_39.GIT_INDEX_ADD_FORCE;
    enum GIT_INDEX_ADD_DISABLE_PATHSPEC_MATCH = _Anonymous_39.GIT_INDEX_ADD_DISABLE_PATHSPEC_MATCH;
    enum GIT_INDEX_ADD_CHECK_PATHSPEC = _Anonymous_39.GIT_INDEX_ADD_CHECK_PATHSPEC;
    alias git_index_stage_t = _Anonymous_40;
    enum _Anonymous_40
    {
        GIT_INDEX_STAGE_ANY = -1,
        GIT_INDEX_STAGE_NORMAL = 0,
        GIT_INDEX_STAGE_ANCESTOR = 1,
        GIT_INDEX_STAGE_OURS = 2,
        GIT_INDEX_STAGE_THEIRS = 3,
    }
    enum GIT_INDEX_STAGE_ANY = _Anonymous_40.GIT_INDEX_STAGE_ANY;
    enum GIT_INDEX_STAGE_NORMAL = _Anonymous_40.GIT_INDEX_STAGE_NORMAL;
    enum GIT_INDEX_STAGE_ANCESTOR = _Anonymous_40.GIT_INDEX_STAGE_ANCESTOR;
    enum GIT_INDEX_STAGE_OURS = _Anonymous_40.GIT_INDEX_STAGE_OURS;
    enum GIT_INDEX_STAGE_THEIRS = _Anonymous_40.GIT_INDEX_STAGE_THEIRS;
    int git_index_open(git_index**, const(char)*) @nogc nothrow;
    int git_index_new(git_index**) @nogc nothrow;
    void git_index_free(git_index*) @nogc nothrow;
    git_repository* git_index_owner(const(git_index)*) @nogc nothrow;
    int git_index_caps(const(git_index)*) @nogc nothrow;
    int git_index_set_caps(git_index*, int) @nogc nothrow;
    uint git_index_version(git_index*) @nogc nothrow;
    int git_index_set_version(git_index*, uint) @nogc nothrow;
    int git_index_read(git_index*, int) @nogc nothrow;
    int git_index_write(git_index*) @nogc nothrow;
    const(char)* git_index_path(const(git_index)*) @nogc nothrow;
    const(git_oid)* git_index_checksum(git_index*) @nogc nothrow;
    int git_index_read_tree(git_index*, const(git_tree)*) @nogc nothrow;
    int git_index_write_tree(git_oid*, git_index*) @nogc nothrow;
    int git_index_write_tree_to(git_oid*, git_index*, git_repository*) @nogc nothrow;
    c_ulong git_index_entrycount(const(git_index)*) @nogc nothrow;
    int git_index_clear(git_index*) @nogc nothrow;
    const(git_index_entry)* git_index_get_byindex(git_index*, c_ulong) @nogc nothrow;
    const(git_index_entry)* git_index_get_bypath(git_index*, const(char)*, int) @nogc nothrow;
    int git_index_remove(git_index*, const(char)*, int) @nogc nothrow;
    int git_index_remove_directory(git_index*, const(char)*, int) @nogc nothrow;
    int git_index_add(git_index*, const(git_index_entry)*) @nogc nothrow;
    int git_index_entry_stage(const(git_index_entry)*) @nogc nothrow;
    int git_index_entry_is_conflict(const(git_index_entry)*) @nogc nothrow;
    int git_index_iterator_new(git_index_iterator**, git_index*) @nogc nothrow;
    int git_index_iterator_next(const(git_index_entry)**, git_index_iterator*) @nogc nothrow;
    void git_index_iterator_free(git_index_iterator*) @nogc nothrow;
    int git_index_add_bypath(git_index*, const(char)*) @nogc nothrow;
    int git_index_add_from_buffer(git_index*, const(git_index_entry)*, const(void)*, c_ulong) @nogc nothrow;
    int git_index_remove_bypath(git_index*, const(char)*) @nogc nothrow;
    int git_index_add_all(git_index*, const(git_strarray)*, uint, int function(const(char)*, const(char)*, void*), void*) @nogc nothrow;
    int git_index_remove_all(git_index*, const(git_strarray)*, int function(const(char)*, const(char)*, void*), void*) @nogc nothrow;
    int git_index_update_all(git_index*, const(git_strarray)*, int function(const(char)*, const(char)*, void*), void*) @nogc nothrow;
    int git_index_find(c_ulong*, git_index*, const(char)*) @nogc nothrow;
    int git_index_find_prefix(c_ulong*, git_index*, const(char)*) @nogc nothrow;
    int git_index_conflict_add(git_index*, const(git_index_entry)*, const(git_index_entry)*, const(git_index_entry)*) @nogc nothrow;
    int git_index_conflict_get(const(git_index_entry)**, const(git_index_entry)**, const(git_index_entry)**, git_index*, const(char)*) @nogc nothrow;
    int git_index_conflict_remove(git_index*, const(char)*) @nogc nothrow;
    int git_index_conflict_cleanup(git_index*) @nogc nothrow;
    int git_index_has_conflicts(const(git_index)*) @nogc nothrow;
    int git_index_conflict_iterator_new(git_index_conflict_iterator**, git_index*) @nogc nothrow;
    int git_index_conflict_next(const(git_index_entry)**, const(git_index_entry)**, const(git_index_entry)**, git_index_conflict_iterator*) @nogc nothrow;
    void git_index_conflict_iterator_free(git_index_conflict_iterator*) @nogc nothrow;
    enum _Anonymous_41
    {
        GIT_SUBMODULE_IGNORE_UNSPECIFIED = -1,
        GIT_SUBMODULE_IGNORE_NONE = 1,
        GIT_SUBMODULE_IGNORE_UNTRACKED = 2,
        GIT_SUBMODULE_IGNORE_DIRTY = 3,
        GIT_SUBMODULE_IGNORE_ALL = 4,
    }
    enum GIT_SUBMODULE_IGNORE_UNSPECIFIED = _Anonymous_41.GIT_SUBMODULE_IGNORE_UNSPECIFIED;
    enum GIT_SUBMODULE_IGNORE_NONE = _Anonymous_41.GIT_SUBMODULE_IGNORE_NONE;
    enum GIT_SUBMODULE_IGNORE_UNTRACKED = _Anonymous_41.GIT_SUBMODULE_IGNORE_UNTRACKED;
    enum GIT_SUBMODULE_IGNORE_DIRTY = _Anonymous_41.GIT_SUBMODULE_IGNORE_DIRTY;
    enum GIT_SUBMODULE_IGNORE_ALL = _Anonymous_41.GIT_SUBMODULE_IGNORE_ALL;
    struct git_indexer;
    struct git_indexer_progress
    {
        uint total_objects;
        uint indexed_objects;
        uint received_objects;
        uint local_objects;
        uint total_deltas;
        uint indexed_deltas;
        c_ulong received_bytes;
    }
    alias git_indexer_progress_cb = int function(const(git_indexer_progress)*, void*);
    struct git_indexer_options
    {
        uint version_;
        int function(const(git_indexer_progress)*, void*) progress_cb;
        void* progress_cb_payload;
        ubyte verify;
    }
    alias git_submodule_ignore_t = _Anonymous_41;
    enum _Anonymous_42
    {
        GIT_SUBMODULE_UPDATE_CHECKOUT = 1,
        GIT_SUBMODULE_UPDATE_REBASE = 2,
        GIT_SUBMODULE_UPDATE_MERGE = 3,
        GIT_SUBMODULE_UPDATE_NONE = 4,
        GIT_SUBMODULE_UPDATE_DEFAULT = 0,
    }
    enum GIT_SUBMODULE_UPDATE_CHECKOUT = _Anonymous_42.GIT_SUBMODULE_UPDATE_CHECKOUT;
    enum GIT_SUBMODULE_UPDATE_REBASE = _Anonymous_42.GIT_SUBMODULE_UPDATE_REBASE;
    enum GIT_SUBMODULE_UPDATE_MERGE = _Anonymous_42.GIT_SUBMODULE_UPDATE_MERGE;
    enum GIT_SUBMODULE_UPDATE_NONE = _Anonymous_42.GIT_SUBMODULE_UPDATE_NONE;
    enum GIT_SUBMODULE_UPDATE_DEFAULT = _Anonymous_42.GIT_SUBMODULE_UPDATE_DEFAULT;
    int git_indexer_options_init(git_indexer_options*, uint) @nogc nothrow;
    int git_indexer_new(git_indexer**, const(char)*, uint, git_odb*, git_indexer_options*) @nogc nothrow;
    int git_indexer_append(git_indexer*, const(void)*, c_ulong, git_indexer_progress*) @nogc nothrow;
    int git_indexer_commit(git_indexer*, git_indexer_progress*) @nogc nothrow;
    const(git_oid)* git_indexer_hash(const(git_indexer)*) @nogc nothrow;
    void git_indexer_free(git_indexer*) @nogc nothrow;
    alias git_submodule_update_t = _Anonymous_42;
    int git_mailmap_new(git_mailmap**) @nogc nothrow;
    void git_mailmap_free(git_mailmap*) @nogc nothrow;
    int git_mailmap_add_entry(git_mailmap*, const(char)*, const(char)*, const(char)*, const(char)*) @nogc nothrow;
    int git_mailmap_from_buffer(git_mailmap**, const(char)*, c_ulong) @nogc nothrow;
    int git_mailmap_from_repository(git_mailmap**, git_repository*) @nogc nothrow;
    int git_mailmap_resolve(const(char)**, const(char)**, const(git_mailmap)*, const(char)*, const(char)*) @nogc nothrow;
    int git_mailmap_resolve_signature(git_signature**, const(git_mailmap)*, const(git_signature)*) @nogc nothrow;
    struct git_submodule;
    struct git_merge_file_input
    {
        uint version_;
        const(char)* ptr;
        c_ulong size;
        const(char)* path;
        uint mode;
    }
    struct git_cert
    {
        git_cert_t cert_type;
    }
    int git_merge_file_input_init(git_merge_file_input*, uint) @nogc nothrow;
    alias git_merge_flag_t = _Anonymous_43;
    enum _Anonymous_43
    {
        GIT_MERGE_FIND_RENAMES = 1,
        GIT_MERGE_FAIL_ON_CONFLICT = 2,
        GIT_MERGE_SKIP_REUC = 4,
        GIT_MERGE_NO_RECURSIVE = 8,
    }
    enum GIT_MERGE_FIND_RENAMES = _Anonymous_43.GIT_MERGE_FIND_RENAMES;
    enum GIT_MERGE_FAIL_ON_CONFLICT = _Anonymous_43.GIT_MERGE_FAIL_ON_CONFLICT;
    enum GIT_MERGE_SKIP_REUC = _Anonymous_43.GIT_MERGE_SKIP_REUC;
    enum GIT_MERGE_NO_RECURSIVE = _Anonymous_43.GIT_MERGE_NO_RECURSIVE;
    alias git_merge_file_favor_t = _Anonymous_44;
    enum _Anonymous_44
    {
        GIT_MERGE_FILE_FAVOR_NORMAL = 0,
        GIT_MERGE_FILE_FAVOR_OURS = 1,
        GIT_MERGE_FILE_FAVOR_THEIRS = 2,
        GIT_MERGE_FILE_FAVOR_UNION = 3,
    }
    enum GIT_MERGE_FILE_FAVOR_NORMAL = _Anonymous_44.GIT_MERGE_FILE_FAVOR_NORMAL;
    enum GIT_MERGE_FILE_FAVOR_OURS = _Anonymous_44.GIT_MERGE_FILE_FAVOR_OURS;
    enum GIT_MERGE_FILE_FAVOR_THEIRS = _Anonymous_44.GIT_MERGE_FILE_FAVOR_THEIRS;
    enum GIT_MERGE_FILE_FAVOR_UNION = _Anonymous_44.GIT_MERGE_FILE_FAVOR_UNION;
    alias git_merge_file_flag_t = _Anonymous_45;
    enum _Anonymous_45
    {
        GIT_MERGE_FILE_DEFAULT = 0,
        GIT_MERGE_FILE_STYLE_MERGE = 1,
        GIT_MERGE_FILE_STYLE_DIFF3 = 2,
        GIT_MERGE_FILE_SIMPLIFY_ALNUM = 4,
        GIT_MERGE_FILE_IGNORE_WHITESPACE = 8,
        GIT_MERGE_FILE_IGNORE_WHITESPACE_CHANGE = 16,
        GIT_MERGE_FILE_IGNORE_WHITESPACE_EOL = 32,
        GIT_MERGE_FILE_DIFF_PATIENCE = 64,
        GIT_MERGE_FILE_DIFF_MINIMAL = 128,
    }
    enum GIT_MERGE_FILE_DEFAULT = _Anonymous_45.GIT_MERGE_FILE_DEFAULT;
    enum GIT_MERGE_FILE_STYLE_MERGE = _Anonymous_45.GIT_MERGE_FILE_STYLE_MERGE;
    enum GIT_MERGE_FILE_STYLE_DIFF3 = _Anonymous_45.GIT_MERGE_FILE_STYLE_DIFF3;
    enum GIT_MERGE_FILE_SIMPLIFY_ALNUM = _Anonymous_45.GIT_MERGE_FILE_SIMPLIFY_ALNUM;
    enum GIT_MERGE_FILE_IGNORE_WHITESPACE = _Anonymous_45.GIT_MERGE_FILE_IGNORE_WHITESPACE;
    enum GIT_MERGE_FILE_IGNORE_WHITESPACE_CHANGE = _Anonymous_45.GIT_MERGE_FILE_IGNORE_WHITESPACE_CHANGE;
    enum GIT_MERGE_FILE_IGNORE_WHITESPACE_EOL = _Anonymous_45.GIT_MERGE_FILE_IGNORE_WHITESPACE_EOL;
    enum GIT_MERGE_FILE_DIFF_PATIENCE = _Anonymous_45.GIT_MERGE_FILE_DIFF_PATIENCE;
    enum GIT_MERGE_FILE_DIFF_MINIMAL = _Anonymous_45.GIT_MERGE_FILE_DIFF_MINIMAL;
    struct git_merge_file_options
    {
        uint version_;
        const(char)* ancestor_label;
        const(char)* our_label;
        const(char)* their_label;
        git_merge_file_favor_t favor;
        uint flags;
        ushort marker_size;
    }
    struct git_remote_callbacks
    {
        uint version_;
        int function(const(char)*, int, void*) sideband_progress;
        int function(git_remote_completion_t, void*) completion;
        int function(git_credential**, const(char)*, const(char)*, uint, void*) credentials;
        int function(git_cert*, int, const(char)*, void*) certificate_check;
        int function(const(git_indexer_progress)*, void*) transfer_progress;
        int function(const(char)*, const(git_oid)*, const(git_oid)*, void*) update_tips;
        int function(int, uint, uint, void*) pack_progress;
        int function(uint, uint, c_ulong, void*) push_transfer_progress;
        int function(const(char)*, const(char)*, void*) push_update_reference;
        int function(const(git_push_update)**, c_ulong, void*) push_negotiation;
        int function(git_transport**, git_remote*, void*) transport;
        void* payload;
        int function(git_buf*, const(char)*, int, void*) resolve_url;
    }
    int git_merge_file_options_init(git_merge_file_options*, uint) @nogc nothrow;
    struct git_merge_file_result
    {
        uint automergeable;
        const(char)* path;
        uint mode;
        const(char)* ptr;
        c_ulong len;
    }
    struct git_merge_options
    {
        uint version_;
        uint flags;
        uint rename_threshold;
        uint target_limit;
        git_diff_similarity_metric* metric;
        uint recursion_limit;
        const(char)* default_driver;
        git_merge_file_favor_t file_favor;
        uint file_flags;
    }
    struct git_remote_head
    {
        int local;
        git_oid oid;
        git_oid loid;
        char* name;
        char* symref_target;
    }
    int git_merge_options_init(git_merge_options*, uint) @nogc nothrow;
    alias git_merge_analysis_t = _Anonymous_46;
    enum _Anonymous_46
    {
        GIT_MERGE_ANALYSIS_NONE = 0,
        GIT_MERGE_ANALYSIS_NORMAL = 1,
        GIT_MERGE_ANALYSIS_UP_TO_DATE = 2,
        GIT_MERGE_ANALYSIS_FASTFORWARD = 4,
        GIT_MERGE_ANALYSIS_UNBORN = 8,
    }
    enum GIT_MERGE_ANALYSIS_NONE = _Anonymous_46.GIT_MERGE_ANALYSIS_NONE;
    enum GIT_MERGE_ANALYSIS_NORMAL = _Anonymous_46.GIT_MERGE_ANALYSIS_NORMAL;
    enum GIT_MERGE_ANALYSIS_UP_TO_DATE = _Anonymous_46.GIT_MERGE_ANALYSIS_UP_TO_DATE;
    enum GIT_MERGE_ANALYSIS_FASTFORWARD = _Anonymous_46.GIT_MERGE_ANALYSIS_FASTFORWARD;
    enum GIT_MERGE_ANALYSIS_UNBORN = _Anonymous_46.GIT_MERGE_ANALYSIS_UNBORN;
    alias git_merge_preference_t = _Anonymous_47;
    enum _Anonymous_47
    {
        GIT_MERGE_PREFERENCE_NONE = 0,
        GIT_MERGE_PREFERENCE_NO_FASTFORWARD = 1,
        GIT_MERGE_PREFERENCE_FASTFORWARD_ONLY = 2,
    }
    enum GIT_MERGE_PREFERENCE_NONE = _Anonymous_47.GIT_MERGE_PREFERENCE_NONE;
    enum GIT_MERGE_PREFERENCE_NO_FASTFORWARD = _Anonymous_47.GIT_MERGE_PREFERENCE_NO_FASTFORWARD;
    enum GIT_MERGE_PREFERENCE_FASTFORWARD_ONLY = _Anonymous_47.GIT_MERGE_PREFERENCE_FASTFORWARD_ONLY;
    int git_merge_analysis(git_merge_analysis_t*, git_merge_preference_t*, git_repository*, const(git_annotated_commit)**, c_ulong) @nogc nothrow;
    int git_merge_analysis_for_ref(git_merge_analysis_t*, git_merge_preference_t*, git_repository*, git_reference*, const(git_annotated_commit)**, c_ulong) @nogc nothrow;
    int git_merge_base(git_oid*, git_repository*, const(git_oid)*, const(git_oid)*) @nogc nothrow;
    int git_merge_bases(git_oidarray*, git_repository*, const(git_oid)*, const(git_oid)*) @nogc nothrow;
    int git_merge_base_many(git_oid*, git_repository*, c_ulong, const(git_oid)*) @nogc nothrow;
    int git_merge_bases_many(git_oidarray*, git_repository*, c_ulong, const(git_oid)*) @nogc nothrow;
    int git_merge_base_octopus(git_oid*, git_repository*, c_ulong, const(git_oid)*) @nogc nothrow;
    int git_merge_file(git_merge_file_result*, const(git_merge_file_input)*, const(git_merge_file_input)*, const(git_merge_file_input)*, const(git_merge_file_options)*) @nogc nothrow;
    int git_merge_file_from_index(git_merge_file_result*, git_repository*, const(git_index_entry)*, const(git_index_entry)*, const(git_index_entry)*, const(git_merge_file_options)*) @nogc nothrow;
    void git_merge_file_result_free(git_merge_file_result*) @nogc nothrow;
    int git_merge_trees(git_index**, git_repository*, const(git_tree)*, const(git_tree)*, const(git_tree)*, const(git_merge_options)*) @nogc nothrow;
    int git_merge_commits(git_index**, git_repository*, const(git_commit)*, const(git_commit)*, const(git_merge_options)*) @nogc nothrow;
    int git_merge(git_repository*, const(git_annotated_commit)**, c_ulong, const(git_merge_options)*, const(git_checkout_options)*) @nogc nothrow;
    struct git_push;
    int git_message_prettify(git_buf*, const(char)*, int, char) @nogc nothrow;
    struct git_message_trailer
    {
        const(char)* key;
        const(char)* value;
    }
    struct git_message_trailer_array
    {
        git_message_trailer* trailers;
        c_ulong count;
        char* _trailer_block;
    }
    int git_message_trailers(git_message_trailer_array*, const(char)*) @nogc nothrow;
    void git_message_trailer_array_free(git_message_trailer_array*) @nogc nothrow;
    struct git_transport;
    alias git_direction = _Anonymous_48;
    enum _Anonymous_48
    {
        GIT_DIRECTION_FETCH = 0,
        GIT_DIRECTION_PUSH = 1,
    }
    enum GIT_DIRECTION_FETCH = _Anonymous_48.GIT_DIRECTION_FETCH;
    enum GIT_DIRECTION_PUSH = _Anonymous_48.GIT_DIRECTION_PUSH;
    alias git_note_foreach_cb = int function(const(git_oid)*, const(git_oid)*, void*);
    alias git_note_iterator = git_iterator;
    struct git_iterator;
    int git_note_iterator_new(git_iterator**, git_repository*, const(char)*) @nogc nothrow;
    int git_note_commit_iterator_new(git_iterator**, git_commit*) @nogc nothrow;
    void git_note_iterator_free(git_iterator*) @nogc nothrow;
    int git_note_next(git_oid*, git_oid*, git_iterator*) @nogc nothrow;
    int git_note_read(git_note**, git_repository*, const(char)*, const(git_oid)*) @nogc nothrow;
    int git_note_commit_read(git_note**, git_repository*, git_commit*, const(git_oid)*) @nogc nothrow;
    const(git_signature)* git_note_author(const(git_note)*) @nogc nothrow;
    const(git_signature)* git_note_committer(const(git_note)*) @nogc nothrow;
    const(char)* git_note_message(const(git_note)*) @nogc nothrow;
    const(git_oid)* git_note_id(const(git_note)*) @nogc nothrow;
    int git_note_create(git_oid*, git_repository*, const(char)*, const(git_signature)*, const(git_signature)*, const(git_oid)*, const(char)*, int) @nogc nothrow;
    int git_note_commit_create(git_oid*, git_oid*, git_repository*, git_commit*, const(git_signature)*, const(git_signature)*, const(git_oid)*, const(char)*, int) @nogc nothrow;
    int git_note_remove(git_repository*, const(char)*, const(git_signature)*, const(git_signature)*, const(git_oid)*) @nogc nothrow;
    int git_note_commit_remove(git_oid*, git_repository*, git_commit*, const(git_signature)*, const(git_signature)*, const(git_oid)*) @nogc nothrow;
    void git_note_free(git_note*) @nogc nothrow;
    int git_note_default_ref(git_buf*, git_repository*) @nogc nothrow;
    int git_note_foreach(git_repository*, const(char)*, int function(const(git_oid)*, const(git_oid)*, void*), void*) @nogc nothrow;
    struct git_remote;
    int git_object_lookup(git_object**, git_repository*, const(git_oid)*, git_object_t) @nogc nothrow;
    int git_object_lookup_prefix(git_object**, git_repository*, const(git_oid)*, c_ulong, git_object_t) @nogc nothrow;
    int git_object_lookup_bypath(git_object**, const(git_object)*, const(char)*, git_object_t) @nogc nothrow;
    const(git_oid)* git_object_id(const(git_object)*) @nogc nothrow;
    int git_object_short_id(git_buf*, const(git_object)*) @nogc nothrow;
    git_object_t git_object_type(const(git_object)*) @nogc nothrow;
    git_repository* git_object_owner(const(git_object)*) @nogc nothrow;
    void git_object_free(git_object*) @nogc nothrow;
    const(char)* git_object_type2string(git_object_t) @nogc nothrow;
    git_object_t git_object_string2type(const(char)*) @nogc nothrow;
    int git_object_typeisloose(git_object_t) @nogc nothrow;
    int git_object_peel(git_object**, const(git_object)*, git_object_t) @nogc nothrow;
    int git_object_dup(git_object**, git_object*) @nogc nothrow;
    struct git_refspec;
    alias git_odb_foreach_cb = int function(const(git_oid)*, void*);
    int git_odb_new(git_odb**) @nogc nothrow;
    int git_odb_open(git_odb**, const(char)*) @nogc nothrow;
    int git_odb_add_disk_alternate(git_odb*, const(char)*) @nogc nothrow;
    void git_odb_free(git_odb*) @nogc nothrow;
    int git_odb_read(git_odb_object**, git_odb*, const(git_oid)*) @nogc nothrow;
    int git_odb_read_prefix(git_odb_object**, git_odb*, const(git_oid)*, c_ulong) @nogc nothrow;
    int git_odb_read_header(c_ulong*, git_object_t*, git_odb*, const(git_oid)*) @nogc nothrow;
    int git_odb_exists(git_odb*, const(git_oid)*) @nogc nothrow;
    int git_odb_exists_prefix(git_oid*, git_odb*, const(git_oid)*, c_ulong) @nogc nothrow;
    struct git_odb_expand_id
    {
        git_oid id;
        ushort length;
        git_object_t type;
    }
    int git_odb_expand_ids(git_odb*, git_odb_expand_id*, c_ulong) @nogc nothrow;
    int git_odb_refresh(git_odb*) @nogc nothrow;
    int git_odb_foreach(git_odb*, int function(const(git_oid)*, void*), void*) @nogc nothrow;
    int git_odb_write(git_oid*, git_odb*, const(void)*, c_ulong, git_object_t) @nogc nothrow;
    int git_odb_open_wstream(git_odb_stream**, git_odb*, c_ulong, git_object_t) @nogc nothrow;
    int git_odb_stream_write(git_odb_stream*, const(char)*, c_ulong) @nogc nothrow;
    int git_odb_stream_finalize_write(git_oid*, git_odb_stream*) @nogc nothrow;
    int git_odb_stream_read(git_odb_stream*, char*, c_ulong) @nogc nothrow;
    void git_odb_stream_free(git_odb_stream*) @nogc nothrow;
    int git_odb_open_rstream(git_odb_stream**, c_ulong*, git_object_t*, git_odb*, const(git_oid)*) @nogc nothrow;
    int git_odb_write_pack(git_odb_writepack**, git_odb*, int function(const(git_indexer_progress)*, void*), void*) @nogc nothrow;
    int git_odb_hash(git_oid*, const(void)*, c_ulong, git_object_t) @nogc nothrow;
    int git_odb_hashfile(git_oid*, const(char)*, git_object_t) @nogc nothrow;
    int git_odb_object_dup(git_odb_object**, git_odb_object*) @nogc nothrow;
    void git_odb_object_free(git_odb_object*) @nogc nothrow;
    const(git_oid)* git_odb_object_id(git_odb_object*) @nogc nothrow;
    const(void)* git_odb_object_data(git_odb_object*) @nogc nothrow;
    c_ulong git_odb_object_size(git_odb_object*) @nogc nothrow;
    git_object_t git_odb_object_type(git_odb_object*) @nogc nothrow;
    int git_odb_add_backend(git_odb*, git_odb_backend*, int) @nogc nothrow;
    int git_odb_add_alternate(git_odb*, git_odb_backend*, int) @nogc nothrow;
    c_ulong git_odb_num_backends(git_odb*) @nogc nothrow;
    int git_odb_get_backend(git_odb_backend**, git_odb*, c_ulong) @nogc nothrow;
    int git_odb_backend_pack(git_odb_backend**, const(char)*) @nogc nothrow;
    int git_odb_backend_loose(git_odb_backend**, const(char)*, int, int, uint, uint) @nogc nothrow;
    int git_odb_backend_one_pack(git_odb_backend**, const(char)*) @nogc nothrow;
    alias git_odb_stream_t = _Anonymous_49;
    enum _Anonymous_49
    {
        GIT_STREAM_RDONLY = 2,
        GIT_STREAM_WRONLY = 4,
        GIT_STREAM_RW = 6,
    }
    enum GIT_STREAM_RDONLY = _Anonymous_49.GIT_STREAM_RDONLY;
    enum GIT_STREAM_WRONLY = _Anonymous_49.GIT_STREAM_WRONLY;
    enum GIT_STREAM_RW = _Anonymous_49.GIT_STREAM_RW;
    enum _Anonymous_50
    {
        GIT_FILEMODE_UNREADABLE = 0,
        GIT_FILEMODE_TREE = 16384,
        GIT_FILEMODE_BLOB = 33188,
        GIT_FILEMODE_BLOB_EXECUTABLE = 33261,
        GIT_FILEMODE_LINK = 40960,
        GIT_FILEMODE_COMMIT = 57344,
    }
    enum GIT_FILEMODE_UNREADABLE = _Anonymous_50.GIT_FILEMODE_UNREADABLE;
    enum GIT_FILEMODE_TREE = _Anonymous_50.GIT_FILEMODE_TREE;
    enum GIT_FILEMODE_BLOB = _Anonymous_50.GIT_FILEMODE_BLOB;
    enum GIT_FILEMODE_BLOB_EXECUTABLE = _Anonymous_50.GIT_FILEMODE_BLOB_EXECUTABLE;
    enum GIT_FILEMODE_LINK = _Anonymous_50.GIT_FILEMODE_LINK;
    enum GIT_FILEMODE_COMMIT = _Anonymous_50.GIT_FILEMODE_COMMIT;
    alias git_filemode_t = _Anonymous_50;
    enum _Anonymous_51
    {
        GIT_BRANCH_LOCAL = 1,
        GIT_BRANCH_REMOTE = 2,
        GIT_BRANCH_ALL = 3,
    }
    enum GIT_BRANCH_LOCAL = _Anonymous_51.GIT_BRANCH_LOCAL;
    enum GIT_BRANCH_REMOTE = _Anonymous_51.GIT_BRANCH_REMOTE;
    enum GIT_BRANCH_ALL = _Anonymous_51.GIT_BRANCH_ALL;
    alias git_branch_t = _Anonymous_51;
    struct git_oid
    {
        ubyte[20] id;
    }
    int git_oid_fromstr(git_oid*, const(char)*) @nogc nothrow;
    int git_oid_fromstrp(git_oid*, const(char)*) @nogc nothrow;
    int git_oid_fromstrn(git_oid*, const(char)*, c_ulong) @nogc nothrow;
    int git_oid_fromraw(git_oid*, const(ubyte)*) @nogc nothrow;
    int git_oid_fmt(char*, const(git_oid)*) @nogc nothrow;
    int git_oid_nfmt(char*, c_ulong, const(git_oid)*) @nogc nothrow;
    int git_oid_pathfmt(char*, const(git_oid)*) @nogc nothrow;
    char* git_oid_tostr_s(const(git_oid)*) @nogc nothrow;
    char* git_oid_tostr(char*, c_ulong, const(git_oid)*) @nogc nothrow;
    int git_oid_cpy(git_oid*, const(git_oid)*) @nogc nothrow;
    int git_oid_cmp(const(git_oid)*, const(git_oid)*) @nogc nothrow;
    int git_oid_equal(const(git_oid)*, const(git_oid)*) @nogc nothrow;
    int git_oid_ncmp(const(git_oid)*, const(git_oid)*, c_ulong) @nogc nothrow;
    int git_oid_streq(const(git_oid)*, const(char)*) @nogc nothrow;
    int git_oid_strcmp(const(git_oid)*, const(char)*) @nogc nothrow;
    int git_oid_is_zero(const(git_oid)*) @nogc nothrow;
    struct git_oid_shorten;
    git_oid_shorten* git_oid_shorten_new(c_ulong) @nogc nothrow;
    int git_oid_shorten_add(git_oid_shorten*, const(char)*) @nogc nothrow;
    void git_oid_shorten_free(git_oid_shorten*) @nogc nothrow;
    enum _Anonymous_52
    {
        GIT_REFERENCE_INVALID = 0,
        GIT_REFERENCE_DIRECT = 1,
        GIT_REFERENCE_SYMBOLIC = 2,
        GIT_REFERENCE_ALL = 3,
    }
    enum GIT_REFERENCE_INVALID = _Anonymous_52.GIT_REFERENCE_INVALID;
    enum GIT_REFERENCE_DIRECT = _Anonymous_52.GIT_REFERENCE_DIRECT;
    enum GIT_REFERENCE_SYMBOLIC = _Anonymous_52.GIT_REFERENCE_SYMBOLIC;
    enum GIT_REFERENCE_ALL = _Anonymous_52.GIT_REFERENCE_ALL;
    struct git_oidarray
    {
        git_oid* ids;
        c_ulong count;
    }
    void git_oidarray_free(git_oidarray*) @nogc nothrow;
    alias git_reference_t = _Anonymous_52;
    alias git_packbuilder_stage_t = _Anonymous_53;
    enum _Anonymous_53
    {
        GIT_PACKBUILDER_ADDING_OBJECTS = 0,
        GIT_PACKBUILDER_DELTAFICATION = 1,
    }
    enum GIT_PACKBUILDER_ADDING_OBJECTS = _Anonymous_53.GIT_PACKBUILDER_ADDING_OBJECTS;
    enum GIT_PACKBUILDER_DELTAFICATION = _Anonymous_53.GIT_PACKBUILDER_DELTAFICATION;
    int git_packbuilder_new(git_packbuilder**, git_repository*) @nogc nothrow;
    uint git_packbuilder_set_threads(git_packbuilder*, uint) @nogc nothrow;
    int git_packbuilder_insert(git_packbuilder*, const(git_oid)*, const(char)*) @nogc nothrow;
    int git_packbuilder_insert_tree(git_packbuilder*, const(git_oid)*) @nogc nothrow;
    int git_packbuilder_insert_commit(git_packbuilder*, const(git_oid)*) @nogc nothrow;
    int git_packbuilder_insert_walk(git_packbuilder*, git_revwalk*) @nogc nothrow;
    int git_packbuilder_insert_recur(git_packbuilder*, const(git_oid)*, const(char)*) @nogc nothrow;
    int git_packbuilder_write_buf(git_buf*, git_packbuilder*) @nogc nothrow;
    int git_packbuilder_write(git_packbuilder*, const(char)*, uint, int function(const(git_indexer_progress)*, void*), void*) @nogc nothrow;
    const(git_oid)* git_packbuilder_hash(git_packbuilder*) @nogc nothrow;
    alias git_packbuilder_foreach_cb = int function(void*, c_ulong, void*);
    int git_packbuilder_foreach(git_packbuilder*, int function(void*, c_ulong, void*), void*) @nogc nothrow;
    c_ulong git_packbuilder_object_count(git_packbuilder*) @nogc nothrow;
    c_ulong git_packbuilder_written(git_packbuilder*) @nogc nothrow;
    alias git_packbuilder_progress = int function(int, uint, uint, void*);
    int git_packbuilder_set_callbacks(git_packbuilder*, int function(int, uint, uint, void*), void*) @nogc nothrow;
    void git_packbuilder_free(git_packbuilder*) @nogc nothrow;
    struct git_rebase;
    struct git_patch;
    int git_patch_from_diff(git_patch**, git_diff*, c_ulong) @nogc nothrow;
    int git_patch_from_blobs(git_patch**, const(git_blob)*, const(char)*, const(git_blob)*, const(char)*, const(git_diff_options)*) @nogc nothrow;
    int git_patch_from_blob_and_buffer(git_patch**, const(git_blob)*, const(char)*, const(void)*, c_ulong, const(char)*, const(git_diff_options)*) @nogc nothrow;
    int git_patch_from_buffers(git_patch**, const(void)*, c_ulong, const(char)*, const(void)*, c_ulong, const(char)*, const(git_diff_options)*) @nogc nothrow;
    void git_patch_free(git_patch*) @nogc nothrow;
    const(git_diff_delta)* git_patch_get_delta(const(git_patch)*) @nogc nothrow;
    c_ulong git_patch_num_hunks(const(git_patch)*) @nogc nothrow;
    int git_patch_line_stats(c_ulong*, c_ulong*, c_ulong*, const(git_patch)*) @nogc nothrow;
    int git_patch_get_hunk(const(git_diff_hunk)**, c_ulong*, git_patch*, c_ulong) @nogc nothrow;
    int git_patch_num_lines_in_hunk(const(git_patch)*, c_ulong) @nogc nothrow;
    int git_patch_get_line_in_hunk(const(git_diff_line)**, git_patch*, c_ulong, c_ulong) @nogc nothrow;
    c_ulong git_patch_size(git_patch*, int, int, int) @nogc nothrow;
    int git_patch_print(git_patch*, int function(const(git_diff_delta)*, const(git_diff_hunk)*, const(git_diff_line)*, void*), void*) @nogc nothrow;
    int git_patch_to_buf(git_buf*, git_patch*) @nogc nothrow;
    struct git_pathspec;
    struct git_pathspec_match_list;
    alias git_pathspec_flag_t = _Anonymous_54;
    enum _Anonymous_54
    {
        GIT_PATHSPEC_DEFAULT = 0,
        GIT_PATHSPEC_IGNORE_CASE = 1,
        GIT_PATHSPEC_USE_CASE = 2,
        GIT_PATHSPEC_NO_GLOB = 4,
        GIT_PATHSPEC_NO_MATCH_ERROR = 8,
        GIT_PATHSPEC_FIND_FAILURES = 16,
        GIT_PATHSPEC_FAILURES_ONLY = 32,
    }
    enum GIT_PATHSPEC_DEFAULT = _Anonymous_54.GIT_PATHSPEC_DEFAULT;
    enum GIT_PATHSPEC_IGNORE_CASE = _Anonymous_54.GIT_PATHSPEC_IGNORE_CASE;
    enum GIT_PATHSPEC_USE_CASE = _Anonymous_54.GIT_PATHSPEC_USE_CASE;
    enum GIT_PATHSPEC_NO_GLOB = _Anonymous_54.GIT_PATHSPEC_NO_GLOB;
    enum GIT_PATHSPEC_NO_MATCH_ERROR = _Anonymous_54.GIT_PATHSPEC_NO_MATCH_ERROR;
    enum GIT_PATHSPEC_FIND_FAILURES = _Anonymous_54.GIT_PATHSPEC_FIND_FAILURES;
    enum GIT_PATHSPEC_FAILURES_ONLY = _Anonymous_54.GIT_PATHSPEC_FAILURES_ONLY;
    int git_pathspec_new(git_pathspec**, const(git_strarray)*) @nogc nothrow;
    void git_pathspec_free(git_pathspec*) @nogc nothrow;
    int git_pathspec_matches_path(const(git_pathspec)*, uint, const(char)*) @nogc nothrow;
    int git_pathspec_match_workdir(git_pathspec_match_list**, git_repository*, uint, git_pathspec*) @nogc nothrow;
    int git_pathspec_match_index(git_pathspec_match_list**, git_index*, uint, git_pathspec*) @nogc nothrow;
    int git_pathspec_match_tree(git_pathspec_match_list**, git_tree*, uint, git_pathspec*) @nogc nothrow;
    int git_pathspec_match_diff(git_pathspec_match_list**, git_diff*, uint, git_pathspec*) @nogc nothrow;
    void git_pathspec_match_list_free(git_pathspec_match_list*) @nogc nothrow;
    c_ulong git_pathspec_match_list_entrycount(const(git_pathspec_match_list)*) @nogc nothrow;
    const(char)* git_pathspec_match_list_entry(const(git_pathspec_match_list)*, c_ulong) @nogc nothrow;
    const(git_diff_delta)* git_pathspec_match_list_diff_entry(const(git_pathspec_match_list)*, c_ulong) @nogc nothrow;
    c_ulong git_pathspec_match_list_failed_entrycount(const(git_pathspec_match_list)*) @nogc nothrow;
    const(char)* git_pathspec_match_list_failed_entry(const(git_pathspec_match_list)*, c_ulong) @nogc nothrow;
    struct git_status_list;
    alias git_proxy_t = _Anonymous_55;
    enum _Anonymous_55
    {
        GIT_PROXY_NONE = 0,
        GIT_PROXY_AUTO = 1,
        GIT_PROXY_SPECIFIED = 2,
    }
    enum GIT_PROXY_NONE = _Anonymous_55.GIT_PROXY_NONE;
    enum GIT_PROXY_AUTO = _Anonymous_55.GIT_PROXY_AUTO;
    enum GIT_PROXY_SPECIFIED = _Anonymous_55.GIT_PROXY_SPECIFIED;
    struct git_proxy_options
    {
        uint version_;
        git_proxy_t type;
        const(char)* url;
        int function(git_credential**, const(char)*, const(char)*, uint, void*) credentials;
        int function(git_cert*, int, const(char)*, void*) certificate_check;
        void* payload;
    }
    struct git_annotated_commit;
    int git_proxy_options_init(git_proxy_options*, uint) @nogc nothrow;
    struct git_rebase_options
    {
        uint version_;
        int quiet;
        int inmemory;
        const(char)* rewrite_notes_ref;
        git_merge_options merge_options;
        git_checkout_options checkout_options;
        int function(git_buf*, git_buf*, const(char)*, void*) signing_cb;
        void* payload;
    }
    alias git_rebase_operation_t = _Anonymous_56;
    enum _Anonymous_56
    {
        GIT_REBASE_OPERATION_PICK = 0,
        GIT_REBASE_OPERATION_REWORD = 1,
        GIT_REBASE_OPERATION_EDIT = 2,
        GIT_REBASE_OPERATION_SQUASH = 3,
        GIT_REBASE_OPERATION_FIXUP = 4,
        GIT_REBASE_OPERATION_EXEC = 5,
    }
    enum GIT_REBASE_OPERATION_PICK = _Anonymous_56.GIT_REBASE_OPERATION_PICK;
    enum GIT_REBASE_OPERATION_REWORD = _Anonymous_56.GIT_REBASE_OPERATION_REWORD;
    enum GIT_REBASE_OPERATION_EDIT = _Anonymous_56.GIT_REBASE_OPERATION_EDIT;
    enum GIT_REBASE_OPERATION_SQUASH = _Anonymous_56.GIT_REBASE_OPERATION_SQUASH;
    enum GIT_REBASE_OPERATION_FIXUP = _Anonymous_56.GIT_REBASE_OPERATION_FIXUP;
    enum GIT_REBASE_OPERATION_EXEC = _Anonymous_56.GIT_REBASE_OPERATION_EXEC;
    struct git_transaction;
    struct git_reference_iterator;
    struct git_rebase_operation
    {
        git_rebase_operation_t type;
        const(git_oid) id;
        const(char)* exec;
    }
    int git_rebase_options_init(git_rebase_options*, uint) @nogc nothrow;
    int git_rebase_init(git_rebase**, git_repository*, const(git_annotated_commit)*, const(git_annotated_commit)*, const(git_annotated_commit)*, const(git_rebase_options)*) @nogc nothrow;
    int git_rebase_open(git_rebase**, git_repository*, const(git_rebase_options)*) @nogc nothrow;
    const(char)* git_rebase_orig_head_name(git_rebase*) @nogc nothrow;
    const(git_oid)* git_rebase_orig_head_id(git_rebase*) @nogc nothrow;
    const(char)* git_rebase_onto_name(git_rebase*) @nogc nothrow;
    const(git_oid)* git_rebase_onto_id(git_rebase*) @nogc nothrow;
    c_ulong git_rebase_operation_entrycount(git_rebase*) @nogc nothrow;
    c_ulong git_rebase_operation_current(git_rebase*) @nogc nothrow;
    git_rebase_operation* git_rebase_operation_byindex(git_rebase*, c_ulong) @nogc nothrow;
    int git_rebase_next(git_rebase_operation**, git_rebase*) @nogc nothrow;
    int git_rebase_inmemory_index(git_index**, git_rebase*) @nogc nothrow;
    int git_rebase_commit(git_oid*, git_rebase*, const(git_signature)*, const(git_signature)*, const(char)*, const(char)*) @nogc nothrow;
    int git_rebase_abort(git_rebase*) @nogc nothrow;
    int git_rebase_finish(git_rebase*, const(git_signature)*) @nogc nothrow;
    void git_rebase_free(git_rebase*) @nogc nothrow;
    int git_refdb_new(git_refdb**, git_repository*) @nogc nothrow;
    int git_refdb_open(git_refdb**, git_repository*) @nogc nothrow;
    int git_refdb_compress(git_refdb*) @nogc nothrow;
    void git_refdb_free(git_refdb*) @nogc nothrow;
    struct git_reference;
    int git_reflog_read(git_reflog**, git_repository*, const(char)*) @nogc nothrow;
    int git_reflog_write(git_reflog*) @nogc nothrow;
    int git_reflog_append(git_reflog*, const(git_oid)*, const(git_signature)*, const(char)*) @nogc nothrow;
    int git_reflog_rename(git_repository*, const(char)*, const(char)*) @nogc nothrow;
    int git_reflog_delete(git_repository*, const(char)*) @nogc nothrow;
    c_ulong git_reflog_entrycount(git_reflog*) @nogc nothrow;
    const(git_reflog_entry)* git_reflog_entry_byindex(const(git_reflog)*, c_ulong) @nogc nothrow;
    int git_reflog_drop(git_reflog*, c_ulong, int) @nogc nothrow;
    const(git_oid)* git_reflog_entry_id_old(const(git_reflog_entry)*) @nogc nothrow;
    const(git_oid)* git_reflog_entry_id_new(const(git_reflog_entry)*) @nogc nothrow;
    const(git_signature)* git_reflog_entry_committer(const(git_reflog_entry)*) @nogc nothrow;
    const(char)* git_reflog_entry_message(const(git_reflog_entry)*) @nogc nothrow;
    void git_reflog_free(git_reflog*) @nogc nothrow;
    int git_reference_lookup(git_reference**, git_repository*, const(char)*) @nogc nothrow;
    int git_reference_name_to_id(git_oid*, git_repository*, const(char)*) @nogc nothrow;
    int git_reference_dwim(git_reference**, git_repository*, const(char)*) @nogc nothrow;
    int git_reference_symbolic_create_matching(git_reference**, git_repository*, const(char)*, const(char)*, int, const(char)*, const(char)*) @nogc nothrow;
    int git_reference_symbolic_create(git_reference**, git_repository*, const(char)*, const(char)*, int, const(char)*) @nogc nothrow;
    int git_reference_create(git_reference**, git_repository*, const(char)*, const(git_oid)*, int, const(char)*) @nogc nothrow;
    int git_reference_create_matching(git_reference**, git_repository*, const(char)*, const(git_oid)*, int, const(git_oid)*, const(char)*) @nogc nothrow;
    const(git_oid)* git_reference_target(const(git_reference)*) @nogc nothrow;
    const(git_oid)* git_reference_target_peel(const(git_reference)*) @nogc nothrow;
    const(char)* git_reference_symbolic_target(const(git_reference)*) @nogc nothrow;
    git_reference_t git_reference_type(const(git_reference)*) @nogc nothrow;
    const(char)* git_reference_name(const(git_reference)*) @nogc nothrow;
    int git_reference_resolve(git_reference**, const(git_reference)*) @nogc nothrow;
    git_repository* git_reference_owner(const(git_reference)*) @nogc nothrow;
    int git_reference_symbolic_set_target(git_reference**, git_reference*, const(char)*, const(char)*) @nogc nothrow;
    int git_reference_set_target(git_reference**, git_reference*, const(git_oid)*, const(char)*) @nogc nothrow;
    int git_reference_rename(git_reference**, git_reference*, const(char)*, int, const(char)*) @nogc nothrow;
    int git_reference_delete(git_reference*) @nogc nothrow;
    int git_reference_remove(git_repository*, const(char)*) @nogc nothrow;
    int git_reference_list(git_strarray*, git_repository*) @nogc nothrow;
    alias git_reference_foreach_cb = int function(git_reference*, void*);
    alias git_reference_foreach_name_cb = int function(const(char)*, void*);
    int git_reference_foreach(git_repository*, int function(git_reference*, void*), void*) @nogc nothrow;
    int git_reference_foreach_name(git_repository*, int function(const(char)*, void*), void*) @nogc nothrow;
    int git_reference_dup(git_reference**, git_reference*) @nogc nothrow;
    void git_reference_free(git_reference*) @nogc nothrow;
    int git_reference_cmp(const(git_reference)*, const(git_reference)*) @nogc nothrow;
    int git_reference_iterator_new(git_reference_iterator**, git_repository*) @nogc nothrow;
    int git_reference_iterator_glob_new(git_reference_iterator**, git_repository*, const(char)*) @nogc nothrow;
    int git_reference_next(git_reference**, git_reference_iterator*) @nogc nothrow;
    int git_reference_next_name(const(char)**, git_reference_iterator*) @nogc nothrow;
    void git_reference_iterator_free(git_reference_iterator*) @nogc nothrow;
    int git_reference_foreach_glob(git_repository*, const(char)*, int function(const(char)*, void*), void*) @nogc nothrow;
    int git_reference_has_log(git_repository*, const(char)*) @nogc nothrow;
    int git_reference_ensure_log(git_repository*, const(char)*) @nogc nothrow;
    int git_reference_is_branch(const(git_reference)*) @nogc nothrow;
    int git_reference_is_remote(const(git_reference)*) @nogc nothrow;
    int git_reference_is_tag(const(git_reference)*) @nogc nothrow;
    int git_reference_is_note(const(git_reference)*) @nogc nothrow;
    alias git_reference_format_t = _Anonymous_57;
    enum _Anonymous_57
    {
        GIT_REFERENCE_FORMAT_NORMAL = 0,
        GIT_REFERENCE_FORMAT_ALLOW_ONELEVEL = 1,
        GIT_REFERENCE_FORMAT_REFSPEC_PATTERN = 2,
        GIT_REFERENCE_FORMAT_REFSPEC_SHORTHAND = 4,
    }
    enum GIT_REFERENCE_FORMAT_NORMAL = _Anonymous_57.GIT_REFERENCE_FORMAT_NORMAL;
    enum GIT_REFERENCE_FORMAT_ALLOW_ONELEVEL = _Anonymous_57.GIT_REFERENCE_FORMAT_ALLOW_ONELEVEL;
    enum GIT_REFERENCE_FORMAT_REFSPEC_PATTERN = _Anonymous_57.GIT_REFERENCE_FORMAT_REFSPEC_PATTERN;
    enum GIT_REFERENCE_FORMAT_REFSPEC_SHORTHAND = _Anonymous_57.GIT_REFERENCE_FORMAT_REFSPEC_SHORTHAND;
    int git_reference_normalize_name(char*, c_ulong, const(char)*, uint) @nogc nothrow;
    int git_reference_peel(git_object**, const(git_reference)*, git_object_t) @nogc nothrow;
    int git_reference_is_valid_name(const(char)*) @nogc nothrow;
    const(char)* git_reference_shorthand(const(git_reference)*) @nogc nothrow;
    struct git_signature
    {
        char* name;
        char* email;
        git_time when;
    }
    int git_refspec_parse(git_refspec**, const(char)*, int) @nogc nothrow;
    void git_refspec_free(git_refspec*) @nogc nothrow;
    const(char)* git_refspec_src(const(git_refspec)*) @nogc nothrow;
    const(char)* git_refspec_dst(const(git_refspec)*) @nogc nothrow;
    const(char)* git_refspec_string(const(git_refspec)*) @nogc nothrow;
    int git_refspec_force(const(git_refspec)*) @nogc nothrow;
    git_direction git_refspec_direction(const(git_refspec)*) @nogc nothrow;
    int git_refspec_src_matches(const(git_refspec)*, const(char)*) @nogc nothrow;
    int git_refspec_dst_matches(const(git_refspec)*, const(char)*) @nogc nothrow;
    int git_refspec_transform(git_buf*, const(git_refspec)*, const(char)*) @nogc nothrow;
    int git_refspec_rtransform(git_buf*, const(git_refspec)*, const(char)*) @nogc nothrow;
    int git_remote_create(git_remote**, git_repository*, const(char)*, const(char)*) @nogc nothrow;
    alias git_remote_create_flags = _Anonymous_58;
    enum _Anonymous_58
    {
        GIT_REMOTE_CREATE_SKIP_INSTEADOF = 1,
        GIT_REMOTE_CREATE_SKIP_DEFAULT_FETCHSPEC = 2,
    }
    enum GIT_REMOTE_CREATE_SKIP_INSTEADOF = _Anonymous_58.GIT_REMOTE_CREATE_SKIP_INSTEADOF;
    enum GIT_REMOTE_CREATE_SKIP_DEFAULT_FETCHSPEC = _Anonymous_58.GIT_REMOTE_CREATE_SKIP_DEFAULT_FETCHSPEC;
    struct git_remote_create_options
    {
        uint version_;
        git_repository* repository;
        const(char)* name;
        const(char)* fetchspec;
        uint flags;
    }
    struct git_time
    {
        c_long time;
        int offset;
        char sign;
    }
    int git_remote_create_options_init(git_remote_create_options*, uint) @nogc nothrow;
    int git_remote_create_with_opts(git_remote**, const(char)*, const(git_remote_create_options)*) @nogc nothrow;
    int git_remote_create_with_fetchspec(git_remote**, git_repository*, const(char)*, const(char)*, const(char)*) @nogc nothrow;
    int git_remote_create_anonymous(git_remote**, git_repository*, const(char)*) @nogc nothrow;
    int git_remote_create_detached(git_remote**, const(char)*) @nogc nothrow;
    int git_remote_lookup(git_remote**, git_repository*, const(char)*) @nogc nothrow;
    int git_remote_dup(git_remote**, git_remote*) @nogc nothrow;
    git_repository* git_remote_owner(const(git_remote)*) @nogc nothrow;
    const(char)* git_remote_name(const(git_remote)*) @nogc nothrow;
    const(char)* git_remote_url(const(git_remote)*) @nogc nothrow;
    const(char)* git_remote_pushurl(const(git_remote)*) @nogc nothrow;
    int git_remote_set_url(git_repository*, const(char)*, const(char)*) @nogc nothrow;
    int git_remote_set_pushurl(git_repository*, const(char)*, const(char)*) @nogc nothrow;
    int git_remote_add_fetch(git_repository*, const(char)*, const(char)*) @nogc nothrow;
    int git_remote_get_fetch_refspecs(git_strarray*, const(git_remote)*) @nogc nothrow;
    int git_remote_add_push(git_repository*, const(char)*, const(char)*) @nogc nothrow;
    int git_remote_get_push_refspecs(git_strarray*, const(git_remote)*) @nogc nothrow;
    c_ulong git_remote_refspec_count(const(git_remote)*) @nogc nothrow;
    const(git_refspec)* git_remote_get_refspec(const(git_remote)*, c_ulong) @nogc nothrow;
    int git_remote_connect(git_remote*, git_direction, const(git_remote_callbacks)*, const(git_proxy_options)*, const(git_strarray)*) @nogc nothrow;
    int git_remote_ls(const(git_remote_head)***, c_ulong*, git_remote*) @nogc nothrow;
    int git_remote_connected(const(git_remote)*) @nogc nothrow;
    int git_remote_stop(git_remote*) @nogc nothrow;
    int git_remote_disconnect(git_remote*) @nogc nothrow;
    void git_remote_free(git_remote*) @nogc nothrow;
    int git_remote_list(git_strarray*, git_repository*) @nogc nothrow;
    enum git_remote_completion_t
    {
        GIT_REMOTE_COMPLETION_DOWNLOAD = 0,
        GIT_REMOTE_COMPLETION_INDEXING = 1,
        GIT_REMOTE_COMPLETION_ERROR = 2,
    }
    enum GIT_REMOTE_COMPLETION_DOWNLOAD = git_remote_completion_t.GIT_REMOTE_COMPLETION_DOWNLOAD;
    enum GIT_REMOTE_COMPLETION_INDEXING = git_remote_completion_t.GIT_REMOTE_COMPLETION_INDEXING;
    enum GIT_REMOTE_COMPLETION_ERROR = git_remote_completion_t.GIT_REMOTE_COMPLETION_ERROR;
    alias git_push_transfer_progress_cb = int function(uint, uint, c_ulong, void*);
    struct git_push_update
    {
        char* src_refname;
        char* dst_refname;
        git_oid src;
        git_oid dst;
    }
    alias git_push_negotiation = int function(const(git_push_update)**, c_ulong, void*);
    alias git_push_update_reference_cb = int function(const(char)*, const(char)*, void*);
    alias git_url_resolve_cb = int function(git_buf*, const(char)*, int, void*);
    struct git_packbuilder;
    int git_remote_init_callbacks(git_remote_callbacks*, uint) @nogc nothrow;
    alias git_fetch_prune_t = _Anonymous_59;
    enum _Anonymous_59
    {
        GIT_FETCH_PRUNE_UNSPECIFIED = 0,
        GIT_FETCH_PRUNE = 1,
        GIT_FETCH_NO_PRUNE = 2,
    }
    enum GIT_FETCH_PRUNE_UNSPECIFIED = _Anonymous_59.GIT_FETCH_PRUNE_UNSPECIFIED;
    enum GIT_FETCH_PRUNE = _Anonymous_59.GIT_FETCH_PRUNE;
    enum GIT_FETCH_NO_PRUNE = _Anonymous_59.GIT_FETCH_NO_PRUNE;
    alias git_remote_autotag_option_t = _Anonymous_60;
    enum _Anonymous_60
    {
        GIT_REMOTE_DOWNLOAD_TAGS_UNSPECIFIED = 0,
        GIT_REMOTE_DOWNLOAD_TAGS_AUTO = 1,
        GIT_REMOTE_DOWNLOAD_TAGS_NONE = 2,
        GIT_REMOTE_DOWNLOAD_TAGS_ALL = 3,
    }
    enum GIT_REMOTE_DOWNLOAD_TAGS_UNSPECIFIED = _Anonymous_60.GIT_REMOTE_DOWNLOAD_TAGS_UNSPECIFIED;
    enum GIT_REMOTE_DOWNLOAD_TAGS_AUTO = _Anonymous_60.GIT_REMOTE_DOWNLOAD_TAGS_AUTO;
    enum GIT_REMOTE_DOWNLOAD_TAGS_NONE = _Anonymous_60.GIT_REMOTE_DOWNLOAD_TAGS_NONE;
    enum GIT_REMOTE_DOWNLOAD_TAGS_ALL = _Anonymous_60.GIT_REMOTE_DOWNLOAD_TAGS_ALL;
    struct git_fetch_options
    {
        int version_;
        git_remote_callbacks callbacks;
        git_fetch_prune_t prune;
        int update_fetchhead;
        git_remote_autotag_option_t download_tags;
        git_proxy_options proxy_opts;
        git_strarray custom_headers;
    }
    struct git_note;
    int git_fetch_options_init(git_fetch_options*, uint) @nogc nothrow;
    struct git_push_options
    {
        uint version_;
        uint pb_parallelism;
        git_remote_callbacks callbacks;
        git_proxy_options proxy_opts;
        git_strarray custom_headers;
    }
    struct git_reflog;
    int git_push_options_init(git_push_options*, uint) @nogc nothrow;
    int git_remote_download(git_remote*, const(git_strarray)*, const(git_fetch_options)*) @nogc nothrow;
    int git_remote_upload(git_remote*, const(git_strarray)*, const(git_push_options)*) @nogc nothrow;
    int git_remote_update_tips(git_remote*, const(git_remote_callbacks)*, int, git_remote_autotag_option_t, const(char)*) @nogc nothrow;
    int git_remote_fetch(git_remote*, const(git_strarray)*, const(git_fetch_options)*, const(char)*) @nogc nothrow;
    int git_remote_prune(git_remote*, const(git_remote_callbacks)*) @nogc nothrow;
    int git_remote_push(git_remote*, const(git_strarray)*, const(git_push_options)*) @nogc nothrow;
    const(git_indexer_progress)* git_remote_stats(git_remote*) @nogc nothrow;
    git_remote_autotag_option_t git_remote_autotag(const(git_remote)*) @nogc nothrow;
    int git_remote_set_autotag(git_repository*, const(char)*, git_remote_autotag_option_t) @nogc nothrow;
    int git_remote_prune_refs(const(git_remote)*) @nogc nothrow;
    int git_remote_rename(git_strarray*, git_repository*, const(char)*, const(char)*) @nogc nothrow;
    int git_remote_is_valid_name(const(char)*) @nogc nothrow;
    int git_remote_delete(git_repository*, const(char)*) @nogc nothrow;
    int git_remote_default_branch(git_buf*, git_remote*) @nogc nothrow;
    struct git_reflog_entry;
    int git_repository_open(git_repository**, const(char)*) @nogc nothrow;
    int git_repository_open_from_worktree(git_repository**, git_worktree*) @nogc nothrow;
    int git_repository_wrap_odb(git_repository**, git_odb*) @nogc nothrow;
    int git_repository_discover(git_buf*, const(char)*, int, const(char)*) @nogc nothrow;
    alias git_repository_open_flag_t = _Anonymous_61;
    enum _Anonymous_61
    {
        GIT_REPOSITORY_OPEN_NO_SEARCH = 1,
        GIT_REPOSITORY_OPEN_CROSS_FS = 2,
        GIT_REPOSITORY_OPEN_BARE = 4,
        GIT_REPOSITORY_OPEN_NO_DOTGIT = 8,
        GIT_REPOSITORY_OPEN_FROM_ENV = 16,
    }
    enum GIT_REPOSITORY_OPEN_NO_SEARCH = _Anonymous_61.GIT_REPOSITORY_OPEN_NO_SEARCH;
    enum GIT_REPOSITORY_OPEN_CROSS_FS = _Anonymous_61.GIT_REPOSITORY_OPEN_CROSS_FS;
    enum GIT_REPOSITORY_OPEN_BARE = _Anonymous_61.GIT_REPOSITORY_OPEN_BARE;
    enum GIT_REPOSITORY_OPEN_NO_DOTGIT = _Anonymous_61.GIT_REPOSITORY_OPEN_NO_DOTGIT;
    enum GIT_REPOSITORY_OPEN_FROM_ENV = _Anonymous_61.GIT_REPOSITORY_OPEN_FROM_ENV;
    int git_repository_open_ext(git_repository**, const(char)*, uint, const(char)*) @nogc nothrow;
    int git_repository_open_bare(git_repository**, const(char)*) @nogc nothrow;
    void git_repository_free(git_repository*) @nogc nothrow;
    int git_repository_init(git_repository**, const(char)*, uint) @nogc nothrow;
    alias git_repository_init_flag_t = _Anonymous_62;
    enum _Anonymous_62
    {
        GIT_REPOSITORY_INIT_BARE = 1,
        GIT_REPOSITORY_INIT_NO_REINIT = 2,
        GIT_REPOSITORY_INIT_NO_DOTGIT_DIR = 4,
        GIT_REPOSITORY_INIT_MKDIR = 8,
        GIT_REPOSITORY_INIT_MKPATH = 16,
        GIT_REPOSITORY_INIT_EXTERNAL_TEMPLATE = 32,
        GIT_REPOSITORY_INIT_RELATIVE_GITLINK = 64,
    }
    enum GIT_REPOSITORY_INIT_BARE = _Anonymous_62.GIT_REPOSITORY_INIT_BARE;
    enum GIT_REPOSITORY_INIT_NO_REINIT = _Anonymous_62.GIT_REPOSITORY_INIT_NO_REINIT;
    enum GIT_REPOSITORY_INIT_NO_DOTGIT_DIR = _Anonymous_62.GIT_REPOSITORY_INIT_NO_DOTGIT_DIR;
    enum GIT_REPOSITORY_INIT_MKDIR = _Anonymous_62.GIT_REPOSITORY_INIT_MKDIR;
    enum GIT_REPOSITORY_INIT_MKPATH = _Anonymous_62.GIT_REPOSITORY_INIT_MKPATH;
    enum GIT_REPOSITORY_INIT_EXTERNAL_TEMPLATE = _Anonymous_62.GIT_REPOSITORY_INIT_EXTERNAL_TEMPLATE;
    enum GIT_REPOSITORY_INIT_RELATIVE_GITLINK = _Anonymous_62.GIT_REPOSITORY_INIT_RELATIVE_GITLINK;
    alias git_repository_init_mode_t = _Anonymous_63;
    enum _Anonymous_63
    {
        GIT_REPOSITORY_INIT_SHARED_UMASK = 0,
        GIT_REPOSITORY_INIT_SHARED_GROUP = 1533,
        GIT_REPOSITORY_INIT_SHARED_ALL = 1535,
    }
    enum GIT_REPOSITORY_INIT_SHARED_UMASK = _Anonymous_63.GIT_REPOSITORY_INIT_SHARED_UMASK;
    enum GIT_REPOSITORY_INIT_SHARED_GROUP = _Anonymous_63.GIT_REPOSITORY_INIT_SHARED_GROUP;
    enum GIT_REPOSITORY_INIT_SHARED_ALL = _Anonymous_63.GIT_REPOSITORY_INIT_SHARED_ALL;
    struct git_repository_init_options
    {
        uint version_;
        uint flags;
        uint mode;
        const(char)* workdir_path;
        const(char)* description;
        const(char)* template_path;
        const(char)* initial_head;
        const(char)* origin_url;
    }
    struct git_config_backend;
    int git_repository_init_options_init(git_repository_init_options*, uint) @nogc nothrow;
    int git_repository_init_ext(git_repository**, const(char)*, git_repository_init_options*) @nogc nothrow;
    int git_repository_head(git_reference**, git_repository*) @nogc nothrow;
    int git_repository_head_for_worktree(git_reference**, git_repository*, const(char)*) @nogc nothrow;
    int git_repository_head_detached(git_repository*) @nogc nothrow;
    int git_repository_head_detached_for_worktree(git_repository*, const(char)*) @nogc nothrow;
    int git_repository_head_unborn(git_repository*) @nogc nothrow;
    int git_repository_is_empty(git_repository*) @nogc nothrow;
    alias git_repository_item_t = _Anonymous_64;
    enum _Anonymous_64
    {
        GIT_REPOSITORY_ITEM_GITDIR = 0,
        GIT_REPOSITORY_ITEM_WORKDIR = 1,
        GIT_REPOSITORY_ITEM_COMMONDIR = 2,
        GIT_REPOSITORY_ITEM_INDEX = 3,
        GIT_REPOSITORY_ITEM_OBJECTS = 4,
        GIT_REPOSITORY_ITEM_REFS = 5,
        GIT_REPOSITORY_ITEM_PACKED_REFS = 6,
        GIT_REPOSITORY_ITEM_REMOTES = 7,
        GIT_REPOSITORY_ITEM_CONFIG = 8,
        GIT_REPOSITORY_ITEM_INFO = 9,
        GIT_REPOSITORY_ITEM_HOOKS = 10,
        GIT_REPOSITORY_ITEM_LOGS = 11,
        GIT_REPOSITORY_ITEM_MODULES = 12,
        GIT_REPOSITORY_ITEM_WORKTREES = 13,
        GIT_REPOSITORY_ITEM__LAST = 14,
    }
    enum GIT_REPOSITORY_ITEM_GITDIR = _Anonymous_64.GIT_REPOSITORY_ITEM_GITDIR;
    enum GIT_REPOSITORY_ITEM_WORKDIR = _Anonymous_64.GIT_REPOSITORY_ITEM_WORKDIR;
    enum GIT_REPOSITORY_ITEM_COMMONDIR = _Anonymous_64.GIT_REPOSITORY_ITEM_COMMONDIR;
    enum GIT_REPOSITORY_ITEM_INDEX = _Anonymous_64.GIT_REPOSITORY_ITEM_INDEX;
    enum GIT_REPOSITORY_ITEM_OBJECTS = _Anonymous_64.GIT_REPOSITORY_ITEM_OBJECTS;
    enum GIT_REPOSITORY_ITEM_REFS = _Anonymous_64.GIT_REPOSITORY_ITEM_REFS;
    enum GIT_REPOSITORY_ITEM_PACKED_REFS = _Anonymous_64.GIT_REPOSITORY_ITEM_PACKED_REFS;
    enum GIT_REPOSITORY_ITEM_REMOTES = _Anonymous_64.GIT_REPOSITORY_ITEM_REMOTES;
    enum GIT_REPOSITORY_ITEM_CONFIG = _Anonymous_64.GIT_REPOSITORY_ITEM_CONFIG;
    enum GIT_REPOSITORY_ITEM_INFO = _Anonymous_64.GIT_REPOSITORY_ITEM_INFO;
    enum GIT_REPOSITORY_ITEM_HOOKS = _Anonymous_64.GIT_REPOSITORY_ITEM_HOOKS;
    enum GIT_REPOSITORY_ITEM_LOGS = _Anonymous_64.GIT_REPOSITORY_ITEM_LOGS;
    enum GIT_REPOSITORY_ITEM_MODULES = _Anonymous_64.GIT_REPOSITORY_ITEM_MODULES;
    enum GIT_REPOSITORY_ITEM_WORKTREES = _Anonymous_64.GIT_REPOSITORY_ITEM_WORKTREES;
    enum GIT_REPOSITORY_ITEM__LAST = _Anonymous_64.GIT_REPOSITORY_ITEM__LAST;
    int git_repository_item_path(git_buf*, const(git_repository)*, git_repository_item_t) @nogc nothrow;
    const(char)* git_repository_path(const(git_repository)*) @nogc nothrow;
    const(char)* git_repository_workdir(const(git_repository)*) @nogc nothrow;
    const(char)* git_repository_commondir(const(git_repository)*) @nogc nothrow;
    int git_repository_set_workdir(git_repository*, const(char)*, int) @nogc nothrow;
    int git_repository_is_bare(const(git_repository)*) @nogc nothrow;
    int git_repository_is_worktree(const(git_repository)*) @nogc nothrow;
    int git_repository_config(git_config**, git_repository*) @nogc nothrow;
    int git_repository_config_snapshot(git_config**, git_repository*) @nogc nothrow;
    int git_repository_odb(git_odb**, git_repository*) @nogc nothrow;
    int git_repository_refdb(git_refdb**, git_repository*) @nogc nothrow;
    int git_repository_index(git_index**, git_repository*) @nogc nothrow;
    int git_repository_message(git_buf*, git_repository*) @nogc nothrow;
    int git_repository_message_remove(git_repository*) @nogc nothrow;
    int git_repository_state_cleanup(git_repository*) @nogc nothrow;
    alias git_repository_fetchhead_foreach_cb = int function(const(char)*, const(char)*, const(git_oid)*, uint, void*);
    int git_repository_fetchhead_foreach(git_repository*, int function(const(char)*, const(char)*, const(git_oid)*, uint, void*), void*) @nogc nothrow;
    alias git_repository_mergehead_foreach_cb = int function(const(git_oid)*, void*);
    int git_repository_mergehead_foreach(git_repository*, int function(const(git_oid)*, void*), void*) @nogc nothrow;
    int git_repository_hashfile(git_oid*, git_repository*, const(char)*, git_object_t, const(char)*) @nogc nothrow;
    int git_repository_set_head(git_repository*, const(char)*) @nogc nothrow;
    int git_repository_set_head_detached(git_repository*, const(git_oid)*) @nogc nothrow;
    int git_repository_set_head_detached_from_annotated(git_repository*, const(git_annotated_commit)*) @nogc nothrow;
    int git_repository_detach_head(git_repository*) @nogc nothrow;
    alias git_repository_state_t = _Anonymous_65;
    enum _Anonymous_65
    {
        GIT_REPOSITORY_STATE_NONE = 0,
        GIT_REPOSITORY_STATE_MERGE = 1,
        GIT_REPOSITORY_STATE_REVERT = 2,
        GIT_REPOSITORY_STATE_REVERT_SEQUENCE = 3,
        GIT_REPOSITORY_STATE_CHERRYPICK = 4,
        GIT_REPOSITORY_STATE_CHERRYPICK_SEQUENCE = 5,
        GIT_REPOSITORY_STATE_BISECT = 6,
        GIT_REPOSITORY_STATE_REBASE = 7,
        GIT_REPOSITORY_STATE_REBASE_INTERACTIVE = 8,
        GIT_REPOSITORY_STATE_REBASE_MERGE = 9,
        GIT_REPOSITORY_STATE_APPLY_MAILBOX = 10,
        GIT_REPOSITORY_STATE_APPLY_MAILBOX_OR_REBASE = 11,
    }
    enum GIT_REPOSITORY_STATE_NONE = _Anonymous_65.GIT_REPOSITORY_STATE_NONE;
    enum GIT_REPOSITORY_STATE_MERGE = _Anonymous_65.GIT_REPOSITORY_STATE_MERGE;
    enum GIT_REPOSITORY_STATE_REVERT = _Anonymous_65.GIT_REPOSITORY_STATE_REVERT;
    enum GIT_REPOSITORY_STATE_REVERT_SEQUENCE = _Anonymous_65.GIT_REPOSITORY_STATE_REVERT_SEQUENCE;
    enum GIT_REPOSITORY_STATE_CHERRYPICK = _Anonymous_65.GIT_REPOSITORY_STATE_CHERRYPICK;
    enum GIT_REPOSITORY_STATE_CHERRYPICK_SEQUENCE = _Anonymous_65.GIT_REPOSITORY_STATE_CHERRYPICK_SEQUENCE;
    enum GIT_REPOSITORY_STATE_BISECT = _Anonymous_65.GIT_REPOSITORY_STATE_BISECT;
    enum GIT_REPOSITORY_STATE_REBASE = _Anonymous_65.GIT_REPOSITORY_STATE_REBASE;
    enum GIT_REPOSITORY_STATE_REBASE_INTERACTIVE = _Anonymous_65.GIT_REPOSITORY_STATE_REBASE_INTERACTIVE;
    enum GIT_REPOSITORY_STATE_REBASE_MERGE = _Anonymous_65.GIT_REPOSITORY_STATE_REBASE_MERGE;
    enum GIT_REPOSITORY_STATE_APPLY_MAILBOX = _Anonymous_65.GIT_REPOSITORY_STATE_APPLY_MAILBOX;
    enum GIT_REPOSITORY_STATE_APPLY_MAILBOX_OR_REBASE = _Anonymous_65.GIT_REPOSITORY_STATE_APPLY_MAILBOX_OR_REBASE;
    int git_repository_state(git_repository*) @nogc nothrow;
    int git_repository_set_namespace(git_repository*, const(char)*) @nogc nothrow;
    const(char)* git_repository_get_namespace(git_repository*) @nogc nothrow;
    int git_repository_is_shallow(git_repository*) @nogc nothrow;
    int git_repository_ident(const(char)**, const(char)**, const(git_repository)*) @nogc nothrow;
    int git_repository_set_ident(git_repository*, const(char)*, const(char)*) @nogc nothrow;
    alias git_reset_t = _Anonymous_66;
    enum _Anonymous_66
    {
        GIT_RESET_SOFT = 1,
        GIT_RESET_MIXED = 2,
        GIT_RESET_HARD = 3,
    }
    enum GIT_RESET_SOFT = _Anonymous_66.GIT_RESET_SOFT;
    enum GIT_RESET_MIXED = _Anonymous_66.GIT_RESET_MIXED;
    enum GIT_RESET_HARD = _Anonymous_66.GIT_RESET_HARD;
    int git_reset(git_repository*, const(git_object)*, git_reset_t, const(git_checkout_options)*) @nogc nothrow;
    int git_reset_from_annotated(git_repository*, const(git_annotated_commit)*, git_reset_t, const(git_checkout_options)*) @nogc nothrow;
    int git_reset_default(git_repository*, const(git_object)*, const(git_strarray)*) @nogc nothrow;
    struct git_config;
    struct git_revert_options
    {
        uint version_;
        uint mainline;
        git_merge_options merge_opts;
        git_checkout_options checkout_opts;
    }
    struct git_index_conflict_iterator;
    int git_revert_options_init(git_revert_options*, uint) @nogc nothrow;
    int git_revert_commit(git_index**, git_repository*, git_commit*, git_commit*, uint, const(git_merge_options)*) @nogc nothrow;
    int git_revert(git_repository*, git_commit*, const(git_revert_options)*) @nogc nothrow;
    int git_revparse_single(git_object**, git_repository*, const(char)*) @nogc nothrow;
    int git_revparse_ext(git_object**, git_reference**, git_repository*, const(char)*) @nogc nothrow;
    alias git_revparse_mode_t = _Anonymous_67;
    enum _Anonymous_67
    {
        GIT_REVPARSE_SINGLE = 1,
        GIT_REVPARSE_RANGE = 2,
        GIT_REVPARSE_MERGE_BASE = 4,
    }
    enum GIT_REVPARSE_SINGLE = _Anonymous_67.GIT_REVPARSE_SINGLE;
    enum GIT_REVPARSE_RANGE = _Anonymous_67.GIT_REVPARSE_RANGE;
    enum GIT_REVPARSE_MERGE_BASE = _Anonymous_67.GIT_REVPARSE_MERGE_BASE;
    struct git_revspec
    {
        git_object* from;
        git_object* to;
        uint flags;
    }
    int git_revparse(git_revspec*, git_repository*, const(char)*) @nogc nothrow;
    struct git_index_iterator;
    alias git_sort_t = _Anonymous_68;
    enum _Anonymous_68
    {
        GIT_SORT_NONE = 0,
        GIT_SORT_TOPOLOGICAL = 1,
        GIT_SORT_TIME = 2,
        GIT_SORT_REVERSE = 4,
    }
    enum GIT_SORT_NONE = _Anonymous_68.GIT_SORT_NONE;
    enum GIT_SORT_TOPOLOGICAL = _Anonymous_68.GIT_SORT_TOPOLOGICAL;
    enum GIT_SORT_TIME = _Anonymous_68.GIT_SORT_TIME;
    enum GIT_SORT_REVERSE = _Anonymous_68.GIT_SORT_REVERSE;
    int git_revwalk_new(git_revwalk**, git_repository*) @nogc nothrow;
    int git_revwalk_reset(git_revwalk*) @nogc nothrow;
    int git_revwalk_push(git_revwalk*, const(git_oid)*) @nogc nothrow;
    int git_revwalk_push_glob(git_revwalk*, const(char)*) @nogc nothrow;
    int git_revwalk_push_head(git_revwalk*) @nogc nothrow;
    int git_revwalk_hide(git_revwalk*, const(git_oid)*) @nogc nothrow;
    int git_revwalk_hide_glob(git_revwalk*, const(char)*) @nogc nothrow;
    int git_revwalk_hide_head(git_revwalk*) @nogc nothrow;
    int git_revwalk_push_ref(git_revwalk*, const(char)*) @nogc nothrow;
    int git_revwalk_hide_ref(git_revwalk*, const(char)*) @nogc nothrow;
    int git_revwalk_next(git_oid*, git_revwalk*) @nogc nothrow;
    int git_revwalk_sorting(git_revwalk*, uint) @nogc nothrow;
    int git_revwalk_push_range(git_revwalk*, const(char)*) @nogc nothrow;
    int git_revwalk_simplify_first_parent(git_revwalk*) @nogc nothrow;
    void git_revwalk_free(git_revwalk*) @nogc nothrow;
    git_repository* git_revwalk_repository(git_revwalk*) @nogc nothrow;
    alias git_revwalk_hide_cb = int function(const(git_oid)*, void*);
    int git_revwalk_add_hide_cb(git_revwalk*, int function(const(git_oid)*, void*), void*) @nogc nothrow;
    int git_signature_new(git_signature**, const(char)*, const(char)*, c_long, int) @nogc nothrow;
    int git_signature_now(git_signature**, const(char)*, const(char)*) @nogc nothrow;
    int git_signature_default(git_signature**, git_repository*) @nogc nothrow;
    int git_signature_from_buffer(git_signature**, const(char)*) @nogc nothrow;
    int git_signature_dup(git_signature**, const(git_signature)*) @nogc nothrow;
    void git_signature_free(git_signature*) @nogc nothrow;
    struct git_index;
    alias git_stash_flags = _Anonymous_69;
    enum _Anonymous_69
    {
        GIT_STASH_DEFAULT = 0,
        GIT_STASH_KEEP_INDEX = 1,
        GIT_STASH_INCLUDE_UNTRACKED = 2,
        GIT_STASH_INCLUDE_IGNORED = 4,
    }
    enum GIT_STASH_DEFAULT = _Anonymous_69.GIT_STASH_DEFAULT;
    enum GIT_STASH_KEEP_INDEX = _Anonymous_69.GIT_STASH_KEEP_INDEX;
    enum GIT_STASH_INCLUDE_UNTRACKED = _Anonymous_69.GIT_STASH_INCLUDE_UNTRACKED;
    enum GIT_STASH_INCLUDE_IGNORED = _Anonymous_69.GIT_STASH_INCLUDE_IGNORED;
    int git_stash_save(git_oid*, git_repository*, const(git_signature)*, const(char)*, uint) @nogc nothrow;
    alias git_stash_apply_flags = _Anonymous_70;
    enum _Anonymous_70
    {
        GIT_STASH_APPLY_DEFAULT = 0,
        GIT_STASH_APPLY_REINSTATE_INDEX = 1,
    }
    enum GIT_STASH_APPLY_DEFAULT = _Anonymous_70.GIT_STASH_APPLY_DEFAULT;
    enum GIT_STASH_APPLY_REINSTATE_INDEX = _Anonymous_70.GIT_STASH_APPLY_REINSTATE_INDEX;
    alias git_stash_apply_progress_t = _Anonymous_71;
    enum _Anonymous_71
    {
        GIT_STASH_APPLY_PROGRESS_NONE = 0,
        GIT_STASH_APPLY_PROGRESS_LOADING_STASH = 1,
        GIT_STASH_APPLY_PROGRESS_ANALYZE_INDEX = 2,
        GIT_STASH_APPLY_PROGRESS_ANALYZE_MODIFIED = 3,
        GIT_STASH_APPLY_PROGRESS_ANALYZE_UNTRACKED = 4,
        GIT_STASH_APPLY_PROGRESS_CHECKOUT_UNTRACKED = 5,
        GIT_STASH_APPLY_PROGRESS_CHECKOUT_MODIFIED = 6,
        GIT_STASH_APPLY_PROGRESS_DONE = 7,
    }
    enum GIT_STASH_APPLY_PROGRESS_NONE = _Anonymous_71.GIT_STASH_APPLY_PROGRESS_NONE;
    enum GIT_STASH_APPLY_PROGRESS_LOADING_STASH = _Anonymous_71.GIT_STASH_APPLY_PROGRESS_LOADING_STASH;
    enum GIT_STASH_APPLY_PROGRESS_ANALYZE_INDEX = _Anonymous_71.GIT_STASH_APPLY_PROGRESS_ANALYZE_INDEX;
    enum GIT_STASH_APPLY_PROGRESS_ANALYZE_MODIFIED = _Anonymous_71.GIT_STASH_APPLY_PROGRESS_ANALYZE_MODIFIED;
    enum GIT_STASH_APPLY_PROGRESS_ANALYZE_UNTRACKED = _Anonymous_71.GIT_STASH_APPLY_PROGRESS_ANALYZE_UNTRACKED;
    enum GIT_STASH_APPLY_PROGRESS_CHECKOUT_UNTRACKED = _Anonymous_71.GIT_STASH_APPLY_PROGRESS_CHECKOUT_UNTRACKED;
    enum GIT_STASH_APPLY_PROGRESS_CHECKOUT_MODIFIED = _Anonymous_71.GIT_STASH_APPLY_PROGRESS_CHECKOUT_MODIFIED;
    enum GIT_STASH_APPLY_PROGRESS_DONE = _Anonymous_71.GIT_STASH_APPLY_PROGRESS_DONE;
    alias git_stash_apply_progress_cb = int function(git_stash_apply_progress_t, void*);
    struct git_stash_apply_options
    {
        uint version_;
        uint flags;
        git_checkout_options checkout_options;
        int function(git_stash_apply_progress_t, void*) progress_cb;
        void* progress_payload;
    }
    struct git_treebuilder;
    int git_stash_apply_options_init(git_stash_apply_options*, uint) @nogc nothrow;
    int git_stash_apply(git_repository*, c_ulong, const(git_stash_apply_options)*) @nogc nothrow;
    alias git_stash_cb = int function(c_ulong, const(char)*, const(git_oid)*, void*);
    int git_stash_foreach(git_repository*, int function(c_ulong, const(char)*, const(git_oid)*, void*), void*) @nogc nothrow;
    int git_stash_drop(git_repository*, c_ulong) @nogc nothrow;
    int git_stash_pop(git_repository*, c_ulong, const(git_stash_apply_options)*) @nogc nothrow;
    alias git_status_t = _Anonymous_72;
    enum _Anonymous_72
    {
        GIT_STATUS_CURRENT = 0,
        GIT_STATUS_INDEX_NEW = 1,
        GIT_STATUS_INDEX_MODIFIED = 2,
        GIT_STATUS_INDEX_DELETED = 4,
        GIT_STATUS_INDEX_RENAMED = 8,
        GIT_STATUS_INDEX_TYPECHANGE = 16,
        GIT_STATUS_WT_NEW = 128,
        GIT_STATUS_WT_MODIFIED = 256,
        GIT_STATUS_WT_DELETED = 512,
        GIT_STATUS_WT_TYPECHANGE = 1024,
        GIT_STATUS_WT_RENAMED = 2048,
        GIT_STATUS_WT_UNREADABLE = 4096,
        GIT_STATUS_IGNORED = 16384,
        GIT_STATUS_CONFLICTED = 32768,
    }
    enum GIT_STATUS_CURRENT = _Anonymous_72.GIT_STATUS_CURRENT;
    enum GIT_STATUS_INDEX_NEW = _Anonymous_72.GIT_STATUS_INDEX_NEW;
    enum GIT_STATUS_INDEX_MODIFIED = _Anonymous_72.GIT_STATUS_INDEX_MODIFIED;
    enum GIT_STATUS_INDEX_DELETED = _Anonymous_72.GIT_STATUS_INDEX_DELETED;
    enum GIT_STATUS_INDEX_RENAMED = _Anonymous_72.GIT_STATUS_INDEX_RENAMED;
    enum GIT_STATUS_INDEX_TYPECHANGE = _Anonymous_72.GIT_STATUS_INDEX_TYPECHANGE;
    enum GIT_STATUS_WT_NEW = _Anonymous_72.GIT_STATUS_WT_NEW;
    enum GIT_STATUS_WT_MODIFIED = _Anonymous_72.GIT_STATUS_WT_MODIFIED;
    enum GIT_STATUS_WT_DELETED = _Anonymous_72.GIT_STATUS_WT_DELETED;
    enum GIT_STATUS_WT_TYPECHANGE = _Anonymous_72.GIT_STATUS_WT_TYPECHANGE;
    enum GIT_STATUS_WT_RENAMED = _Anonymous_72.GIT_STATUS_WT_RENAMED;
    enum GIT_STATUS_WT_UNREADABLE = _Anonymous_72.GIT_STATUS_WT_UNREADABLE;
    enum GIT_STATUS_IGNORED = _Anonymous_72.GIT_STATUS_IGNORED;
    enum GIT_STATUS_CONFLICTED = _Anonymous_72.GIT_STATUS_CONFLICTED;
    alias git_status_cb = int function(const(char)*, uint, void*);
    alias git_status_show_t = _Anonymous_73;
    enum _Anonymous_73
    {
        GIT_STATUS_SHOW_INDEX_AND_WORKDIR = 0,
        GIT_STATUS_SHOW_INDEX_ONLY = 1,
        GIT_STATUS_SHOW_WORKDIR_ONLY = 2,
    }
    enum GIT_STATUS_SHOW_INDEX_AND_WORKDIR = _Anonymous_73.GIT_STATUS_SHOW_INDEX_AND_WORKDIR;
    enum GIT_STATUS_SHOW_INDEX_ONLY = _Anonymous_73.GIT_STATUS_SHOW_INDEX_ONLY;
    enum GIT_STATUS_SHOW_WORKDIR_ONLY = _Anonymous_73.GIT_STATUS_SHOW_WORKDIR_ONLY;
    alias git_status_opt_t = _Anonymous_74;
    enum _Anonymous_74
    {
        GIT_STATUS_OPT_INCLUDE_UNTRACKED = 1,
        GIT_STATUS_OPT_INCLUDE_IGNORED = 2,
        GIT_STATUS_OPT_INCLUDE_UNMODIFIED = 4,
        GIT_STATUS_OPT_EXCLUDE_SUBMODULES = 8,
        GIT_STATUS_OPT_RECURSE_UNTRACKED_DIRS = 16,
        GIT_STATUS_OPT_DISABLE_PATHSPEC_MATCH = 32,
        GIT_STATUS_OPT_RECURSE_IGNORED_DIRS = 64,
        GIT_STATUS_OPT_RENAMES_HEAD_TO_INDEX = 128,
        GIT_STATUS_OPT_RENAMES_INDEX_TO_WORKDIR = 256,
        GIT_STATUS_OPT_SORT_CASE_SENSITIVELY = 512,
        GIT_STATUS_OPT_SORT_CASE_INSENSITIVELY = 1024,
        GIT_STATUS_OPT_RENAMES_FROM_REWRITES = 2048,
        GIT_STATUS_OPT_NO_REFRESH = 4096,
        GIT_STATUS_OPT_UPDATE_INDEX = 8192,
        GIT_STATUS_OPT_INCLUDE_UNREADABLE = 16384,
        GIT_STATUS_OPT_INCLUDE_UNREADABLE_AS_UNTRACKED = 32768,
    }
    enum GIT_STATUS_OPT_INCLUDE_UNTRACKED = _Anonymous_74.GIT_STATUS_OPT_INCLUDE_UNTRACKED;
    enum GIT_STATUS_OPT_INCLUDE_IGNORED = _Anonymous_74.GIT_STATUS_OPT_INCLUDE_IGNORED;
    enum GIT_STATUS_OPT_INCLUDE_UNMODIFIED = _Anonymous_74.GIT_STATUS_OPT_INCLUDE_UNMODIFIED;
    enum GIT_STATUS_OPT_EXCLUDE_SUBMODULES = _Anonymous_74.GIT_STATUS_OPT_EXCLUDE_SUBMODULES;
    enum GIT_STATUS_OPT_RECURSE_UNTRACKED_DIRS = _Anonymous_74.GIT_STATUS_OPT_RECURSE_UNTRACKED_DIRS;
    enum GIT_STATUS_OPT_DISABLE_PATHSPEC_MATCH = _Anonymous_74.GIT_STATUS_OPT_DISABLE_PATHSPEC_MATCH;
    enum GIT_STATUS_OPT_RECURSE_IGNORED_DIRS = _Anonymous_74.GIT_STATUS_OPT_RECURSE_IGNORED_DIRS;
    enum GIT_STATUS_OPT_RENAMES_HEAD_TO_INDEX = _Anonymous_74.GIT_STATUS_OPT_RENAMES_HEAD_TO_INDEX;
    enum GIT_STATUS_OPT_RENAMES_INDEX_TO_WORKDIR = _Anonymous_74.GIT_STATUS_OPT_RENAMES_INDEX_TO_WORKDIR;
    enum GIT_STATUS_OPT_SORT_CASE_SENSITIVELY = _Anonymous_74.GIT_STATUS_OPT_SORT_CASE_SENSITIVELY;
    enum GIT_STATUS_OPT_SORT_CASE_INSENSITIVELY = _Anonymous_74.GIT_STATUS_OPT_SORT_CASE_INSENSITIVELY;
    enum GIT_STATUS_OPT_RENAMES_FROM_REWRITES = _Anonymous_74.GIT_STATUS_OPT_RENAMES_FROM_REWRITES;
    enum GIT_STATUS_OPT_NO_REFRESH = _Anonymous_74.GIT_STATUS_OPT_NO_REFRESH;
    enum GIT_STATUS_OPT_UPDATE_INDEX = _Anonymous_74.GIT_STATUS_OPT_UPDATE_INDEX;
    enum GIT_STATUS_OPT_INCLUDE_UNREADABLE = _Anonymous_74.GIT_STATUS_OPT_INCLUDE_UNREADABLE;
    enum GIT_STATUS_OPT_INCLUDE_UNREADABLE_AS_UNTRACKED = _Anonymous_74.GIT_STATUS_OPT_INCLUDE_UNREADABLE_AS_UNTRACKED;
    struct git_tree;
    struct git_status_options
    {
        uint version_;
        git_status_show_t show;
        uint flags;
        git_strarray pathspec;
        git_tree* baseline;
    }
    struct git_tree_entry;
    int git_status_options_init(git_status_options*, uint) @nogc nothrow;
    struct git_status_entry
    {
        git_status_t status;
        git_diff_delta* head_to_index;
        git_diff_delta* index_to_workdir;
    }
    int git_status_foreach(git_repository*, int function(const(char)*, uint, void*), void*) @nogc nothrow;
    int git_status_foreach_ext(git_repository*, const(git_status_options)*, int function(const(char)*, uint, void*), void*) @nogc nothrow;
    int git_status_file(uint*, git_repository*, const(char)*) @nogc nothrow;
    int git_status_list_new(git_status_list**, git_repository*, const(git_status_options)*) @nogc nothrow;
    c_ulong git_status_list_entrycount(git_status_list*) @nogc nothrow;
    const(git_status_entry)* git_status_byindex(git_status_list*, c_ulong) @nogc nothrow;
    void git_status_list_free(git_status_list*) @nogc nothrow;
    int git_status_should_ignore(int*, git_repository*, const(char)*) @nogc nothrow;
    struct git_strarray
    {
        char** strings;
        c_ulong count;
    }
    void git_strarray_free(git_strarray*) @nogc nothrow;
    int git_strarray_copy(git_strarray*, const(git_strarray)*) @nogc nothrow;
    struct git_commit;
    alias git_submodule_status_t = _Anonymous_75;
    enum _Anonymous_75
    {
        GIT_SUBMODULE_STATUS_IN_HEAD = 1,
        GIT_SUBMODULE_STATUS_IN_INDEX = 2,
        GIT_SUBMODULE_STATUS_IN_CONFIG = 4,
        GIT_SUBMODULE_STATUS_IN_WD = 8,
        GIT_SUBMODULE_STATUS_INDEX_ADDED = 16,
        GIT_SUBMODULE_STATUS_INDEX_DELETED = 32,
        GIT_SUBMODULE_STATUS_INDEX_MODIFIED = 64,
        GIT_SUBMODULE_STATUS_WD_UNINITIALIZED = 128,
        GIT_SUBMODULE_STATUS_WD_ADDED = 256,
        GIT_SUBMODULE_STATUS_WD_DELETED = 512,
        GIT_SUBMODULE_STATUS_WD_MODIFIED = 1024,
        GIT_SUBMODULE_STATUS_WD_INDEX_MODIFIED = 2048,
        GIT_SUBMODULE_STATUS_WD_WD_MODIFIED = 4096,
        GIT_SUBMODULE_STATUS_WD_UNTRACKED = 8192,
    }
    enum GIT_SUBMODULE_STATUS_IN_HEAD = _Anonymous_75.GIT_SUBMODULE_STATUS_IN_HEAD;
    enum GIT_SUBMODULE_STATUS_IN_INDEX = _Anonymous_75.GIT_SUBMODULE_STATUS_IN_INDEX;
    enum GIT_SUBMODULE_STATUS_IN_CONFIG = _Anonymous_75.GIT_SUBMODULE_STATUS_IN_CONFIG;
    enum GIT_SUBMODULE_STATUS_IN_WD = _Anonymous_75.GIT_SUBMODULE_STATUS_IN_WD;
    enum GIT_SUBMODULE_STATUS_INDEX_ADDED = _Anonymous_75.GIT_SUBMODULE_STATUS_INDEX_ADDED;
    enum GIT_SUBMODULE_STATUS_INDEX_DELETED = _Anonymous_75.GIT_SUBMODULE_STATUS_INDEX_DELETED;
    enum GIT_SUBMODULE_STATUS_INDEX_MODIFIED = _Anonymous_75.GIT_SUBMODULE_STATUS_INDEX_MODIFIED;
    enum GIT_SUBMODULE_STATUS_WD_UNINITIALIZED = _Anonymous_75.GIT_SUBMODULE_STATUS_WD_UNINITIALIZED;
    enum GIT_SUBMODULE_STATUS_WD_ADDED = _Anonymous_75.GIT_SUBMODULE_STATUS_WD_ADDED;
    enum GIT_SUBMODULE_STATUS_WD_DELETED = _Anonymous_75.GIT_SUBMODULE_STATUS_WD_DELETED;
    enum GIT_SUBMODULE_STATUS_WD_MODIFIED = _Anonymous_75.GIT_SUBMODULE_STATUS_WD_MODIFIED;
    enum GIT_SUBMODULE_STATUS_WD_INDEX_MODIFIED = _Anonymous_75.GIT_SUBMODULE_STATUS_WD_INDEX_MODIFIED;
    enum GIT_SUBMODULE_STATUS_WD_WD_MODIFIED = _Anonymous_75.GIT_SUBMODULE_STATUS_WD_WD_MODIFIED;
    enum GIT_SUBMODULE_STATUS_WD_UNTRACKED = _Anonymous_75.GIT_SUBMODULE_STATUS_WD_UNTRACKED;
    struct git_blob;
    struct git_tag;
    struct git_revwalk;
    alias git_submodule_cb = int function(git_submodule*, const(char)*, void*);
    struct git_submodule_update_options
    {
        uint version_;
        git_checkout_options checkout_opts;
        git_fetch_options fetch_opts;
        int allow_fetch;
    }
    struct git_object;
    int git_submodule_update_options_init(git_submodule_update_options*, uint) @nogc nothrow;
    int git_submodule_update(git_submodule*, int, git_submodule_update_options*) @nogc nothrow;
    int git_submodule_lookup(git_submodule**, git_repository*, const(char)*) @nogc nothrow;
    void git_submodule_free(git_submodule*) @nogc nothrow;
    int git_submodule_foreach(git_repository*, int function(git_submodule*, const(char)*, void*), void*) @nogc nothrow;
    int git_submodule_add_setup(git_submodule**, git_repository*, const(char)*, const(char)*, int) @nogc nothrow;
    int git_submodule_clone(git_repository**, git_submodule*, const(git_submodule_update_options)*) @nogc nothrow;
    int git_submodule_add_finalize(git_submodule*) @nogc nothrow;
    int git_submodule_add_to_index(git_submodule*, int) @nogc nothrow;
    git_repository* git_submodule_owner(git_submodule*) @nogc nothrow;
    const(char)* git_submodule_name(git_submodule*) @nogc nothrow;
    const(char)* git_submodule_path(git_submodule*) @nogc nothrow;
    const(char)* git_submodule_url(git_submodule*) @nogc nothrow;
    int git_submodule_resolve_url(git_buf*, git_repository*, const(char)*) @nogc nothrow;
    const(char)* git_submodule_branch(git_submodule*) @nogc nothrow;
    int git_submodule_set_branch(git_repository*, const(char)*, const(char)*) @nogc nothrow;
    int git_submodule_set_url(git_repository*, const(char)*, const(char)*) @nogc nothrow;
    const(git_oid)* git_submodule_index_id(git_submodule*) @nogc nothrow;
    const(git_oid)* git_submodule_head_id(git_submodule*) @nogc nothrow;
    const(git_oid)* git_submodule_wd_id(git_submodule*) @nogc nothrow;
    git_submodule_ignore_t git_submodule_ignore(git_submodule*) @nogc nothrow;
    int git_submodule_set_ignore(git_repository*, const(char)*, git_submodule_ignore_t) @nogc nothrow;
    git_submodule_update_t git_submodule_update_strategy(git_submodule*) @nogc nothrow;
    int git_submodule_set_update(git_repository*, const(char)*, git_submodule_update_t) @nogc nothrow;
    git_submodule_recurse_t git_submodule_fetch_recurse_submodules(git_submodule*) @nogc nothrow;
    int git_submodule_set_fetch_recurse_submodules(git_repository*, const(char)*, git_submodule_recurse_t) @nogc nothrow;
    int git_submodule_init(git_submodule*, int) @nogc nothrow;
    int git_submodule_repo_init(git_repository**, const(git_submodule)*, int) @nogc nothrow;
    int git_submodule_sync(git_submodule*) @nogc nothrow;
    int git_submodule_open(git_repository**, git_submodule*) @nogc nothrow;
    int git_submodule_reload(git_submodule*, int) @nogc nothrow;
    int git_submodule_status(uint*, git_repository*, const(char)*, git_submodule_ignore_t) @nogc nothrow;
    int git_submodule_location(uint*, git_submodule*) @nogc nothrow;
    struct git_worktree;
    int git_tag_lookup(git_tag**, git_repository*, const(git_oid)*) @nogc nothrow;
    int git_tag_lookup_prefix(git_tag**, git_repository*, const(git_oid)*, c_ulong) @nogc nothrow;
    void git_tag_free(git_tag*) @nogc nothrow;
    const(git_oid)* git_tag_id(const(git_tag)*) @nogc nothrow;
    git_repository* git_tag_owner(const(git_tag)*) @nogc nothrow;
    int git_tag_target(git_object**, const(git_tag)*) @nogc nothrow;
    const(git_oid)* git_tag_target_id(const(git_tag)*) @nogc nothrow;
    git_object_t git_tag_target_type(const(git_tag)*) @nogc nothrow;
    const(char)* git_tag_name(const(git_tag)*) @nogc nothrow;
    const(git_signature)* git_tag_tagger(const(git_tag)*) @nogc nothrow;
    const(char)* git_tag_message(const(git_tag)*) @nogc nothrow;
    int git_tag_create(git_oid*, git_repository*, const(char)*, const(git_object)*, const(git_signature)*, const(char)*, int) @nogc nothrow;
    int git_tag_annotation_create(git_oid*, git_repository*, const(char)*, const(git_object)*, const(git_signature)*, const(char)*) @nogc nothrow;
    int git_tag_create_from_buffer(git_oid*, git_repository*, const(char)*, int) @nogc nothrow;
    int git_tag_create_lightweight(git_oid*, git_repository*, const(char)*, const(git_object)*, int) @nogc nothrow;
    int git_tag_delete(git_repository*, const(char)*) @nogc nothrow;
    int git_tag_list(git_strarray*, git_repository*) @nogc nothrow;
    int git_tag_list_match(git_strarray*, const(char)*, git_repository*) @nogc nothrow;
    alias git_tag_foreach_cb = int function(const(char)*, git_oid*, void*);
    int git_tag_foreach(git_repository*, int function(const(char)*, git_oid*, void*), void*) @nogc nothrow;
    int git_tag_peel(git_object**, const(git_tag)*) @nogc nothrow;
    int git_tag_dup(git_tag**, git_tag*) @nogc nothrow;
    struct git_repository;
    alias git_trace_level_t = _Anonymous_76;
    enum _Anonymous_76
    {
        GIT_TRACE_NONE = 0,
        GIT_TRACE_FATAL = 1,
        GIT_TRACE_ERROR = 2,
        GIT_TRACE_WARN = 3,
        GIT_TRACE_INFO = 4,
        GIT_TRACE_DEBUG = 5,
        GIT_TRACE_TRACE = 6,
    }
    enum GIT_TRACE_NONE = _Anonymous_76.GIT_TRACE_NONE;
    enum GIT_TRACE_FATAL = _Anonymous_76.GIT_TRACE_FATAL;
    enum GIT_TRACE_ERROR = _Anonymous_76.GIT_TRACE_ERROR;
    enum GIT_TRACE_WARN = _Anonymous_76.GIT_TRACE_WARN;
    enum GIT_TRACE_INFO = _Anonymous_76.GIT_TRACE_INFO;
    enum GIT_TRACE_DEBUG = _Anonymous_76.GIT_TRACE_DEBUG;
    enum GIT_TRACE_TRACE = _Anonymous_76.GIT_TRACE_TRACE;
    alias git_trace_cb = void function(git_trace_level_t, const(char)*);
    int git_trace_set(git_trace_level_t, void function(git_trace_level_t, const(char)*)) @nogc nothrow;
    int git_transaction_new(git_transaction**, git_repository*) @nogc nothrow;
    int git_transaction_lock_ref(git_transaction*, const(char)*) @nogc nothrow;
    int git_transaction_set_target(git_transaction*, const(char)*, const(git_oid)*, const(git_signature)*, const(char)*) @nogc nothrow;
    int git_transaction_set_symbolic_target(git_transaction*, const(char)*, const(char)*, const(git_signature)*, const(char)*) @nogc nothrow;
    int git_transaction_set_reflog(git_transaction*, const(char)*, const(git_reflog)*) @nogc nothrow;
    int git_transaction_remove(git_transaction*, const(char)*) @nogc nothrow;
    int git_transaction_commit(git_transaction*) @nogc nothrow;
    void git_transaction_free(git_transaction*) @nogc nothrow;
    struct git_refdb_backend;
    alias git_transport_message_cb = int function(const(char)*, int, void*);
    alias git_transport_cb = int function(git_transport**, git_remote*, void*);
    int git_tree_lookup(git_tree**, git_repository*, const(git_oid)*) @nogc nothrow;
    int git_tree_lookup_prefix(git_tree**, git_repository*, const(git_oid)*, c_ulong) @nogc nothrow;
    void git_tree_free(git_tree*) @nogc nothrow;
    const(git_oid)* git_tree_id(const(git_tree)*) @nogc nothrow;
    git_repository* git_tree_owner(const(git_tree)*) @nogc nothrow;
    c_ulong git_tree_entrycount(const(git_tree)*) @nogc nothrow;
    const(git_tree_entry)* git_tree_entry_byname(const(git_tree)*, const(char)*) @nogc nothrow;
    const(git_tree_entry)* git_tree_entry_byindex(const(git_tree)*, c_ulong) @nogc nothrow;
    const(git_tree_entry)* git_tree_entry_byid(const(git_tree)*, const(git_oid)*) @nogc nothrow;
    int git_tree_entry_bypath(git_tree_entry**, const(git_tree)*, const(char)*) @nogc nothrow;
    int git_tree_entry_dup(git_tree_entry**, const(git_tree_entry)*) @nogc nothrow;
    void git_tree_entry_free(git_tree_entry*) @nogc nothrow;
    const(char)* git_tree_entry_name(const(git_tree_entry)*) @nogc nothrow;
    const(git_oid)* git_tree_entry_id(const(git_tree_entry)*) @nogc nothrow;
    git_object_t git_tree_entry_type(const(git_tree_entry)*) @nogc nothrow;
    git_filemode_t git_tree_entry_filemode(const(git_tree_entry)*) @nogc nothrow;
    git_filemode_t git_tree_entry_filemode_raw(const(git_tree_entry)*) @nogc nothrow;
    int git_tree_entry_cmp(const(git_tree_entry)*, const(git_tree_entry)*) @nogc nothrow;
    int git_tree_entry_to_object(git_object**, git_repository*, const(git_tree_entry)*) @nogc nothrow;
    int git_treebuilder_new(git_treebuilder**, git_repository*, const(git_tree)*) @nogc nothrow;
    int git_treebuilder_clear(git_treebuilder*) @nogc nothrow;
    c_ulong git_treebuilder_entrycount(git_treebuilder*) @nogc nothrow;
    void git_treebuilder_free(git_treebuilder*) @nogc nothrow;
    const(git_tree_entry)* git_treebuilder_get(git_treebuilder*, const(char)*) @nogc nothrow;
    int git_treebuilder_insert(const(git_tree_entry)**, git_treebuilder*, const(char)*, const(git_oid)*, git_filemode_t) @nogc nothrow;
    int git_treebuilder_remove(git_treebuilder*, const(char)*) @nogc nothrow;
    alias git_treebuilder_filter_cb = int function(const(git_tree_entry)*, void*);
    int git_treebuilder_filter(git_treebuilder*, int function(const(git_tree_entry)*, void*), void*) @nogc nothrow;
    int git_treebuilder_write(git_oid*, git_treebuilder*) @nogc nothrow;
    int git_treebuilder_write_with_buffer(git_oid*, git_treebuilder*, git_buf*) @nogc nothrow;
    alias git_treewalk_cb = int function(const(char)*, const(git_tree_entry)*, void*);
    alias git_treewalk_mode = _Anonymous_77;
    enum _Anonymous_77
    {
        GIT_TREEWALK_PRE = 0,
        GIT_TREEWALK_POST = 1,
    }
    enum GIT_TREEWALK_PRE = _Anonymous_77.GIT_TREEWALK_PRE;
    enum GIT_TREEWALK_POST = _Anonymous_77.GIT_TREEWALK_POST;
    int git_tree_walk(const(git_tree)*, git_treewalk_mode, int function(const(char)*, const(git_tree_entry)*, void*), void*) @nogc nothrow;
    int git_tree_dup(git_tree**, git_tree*) @nogc nothrow;
    alias git_tree_update_t = _Anonymous_78;
    enum _Anonymous_78
    {
        GIT_TREE_UPDATE_UPSERT = 0,
        GIT_TREE_UPDATE_REMOVE = 1,
    }
    enum GIT_TREE_UPDATE_UPSERT = _Anonymous_78.GIT_TREE_UPDATE_UPSERT;
    enum GIT_TREE_UPDATE_REMOVE = _Anonymous_78.GIT_TREE_UPDATE_REMOVE;
    struct git_tree_update
    {
        git_tree_update_t action;
        git_oid id;
        git_filemode_t filemode;
        const(char)* path;
    }
    int git_tree_create_updated(git_oid*, git_repository*, git_tree*, c_ulong, const(git_tree_update)*) @nogc nothrow;
    struct git_refdb;
    alias git_off_t = c_long;
    alias git_time_t = c_long;
    alias git_object_size_t = c_ulong;
    alias git_object_t = _Anonymous_79;
    enum _Anonymous_79
    {
        GIT_OBJECT_ANY = -2,
        GIT_OBJECT_INVALID = -1,
        GIT_OBJECT_COMMIT = 1,
        GIT_OBJECT_TREE = 2,
        GIT_OBJECT_BLOB = 3,
        GIT_OBJECT_TAG = 4,
        GIT_OBJECT_OFS_DELTA = 6,
        GIT_OBJECT_REF_DELTA = 7,
    }
    enum GIT_OBJECT_ANY = _Anonymous_79.GIT_OBJECT_ANY;
    enum GIT_OBJECT_INVALID = _Anonymous_79.GIT_OBJECT_INVALID;
    enum GIT_OBJECT_COMMIT = _Anonymous_79.GIT_OBJECT_COMMIT;
    enum GIT_OBJECT_TREE = _Anonymous_79.GIT_OBJECT_TREE;
    enum GIT_OBJECT_BLOB = _Anonymous_79.GIT_OBJECT_BLOB;
    enum GIT_OBJECT_TAG = _Anonymous_79.GIT_OBJECT_TAG;
    enum GIT_OBJECT_OFS_DELTA = _Anonymous_79.GIT_OBJECT_OFS_DELTA;
    enum GIT_OBJECT_REF_DELTA = _Anonymous_79.GIT_OBJECT_REF_DELTA;
    struct git_odb;
    struct git_odb_backend;
    struct git_odb_object;
    struct git_odb_stream
    {
        git_odb_backend* backend;
        uint mode;
        void* hash_ctx;
        c_ulong declared_size;
        c_ulong received_bytes;
        int function(git_odb_stream*, char*, c_ulong) read;
        int function(git_odb_stream*, const(char)*, c_ulong) write;
        int function(git_odb_stream*, const(git_oid)*) finalize_write;
        void function(git_odb_stream*) free;
    }
    struct git_odb_writepack
    {
        git_odb_backend* backend;
        int function(git_odb_writepack*, const(void)*, c_ulong, git_indexer_progress*) append;
        int function(git_odb_writepack*, git_indexer_progress*) commit;
        void function(git_odb_writepack*) free;
    }
    static if(!is(typeof(GIT_SUBMODULE_UPDATE_OPTIONS_INIT))) {
        private enum enumMixinStr_GIT_SUBMODULE_UPDATE_OPTIONS_INIT = `enum GIT_SUBMODULE_UPDATE_OPTIONS_INIT = { GIT_SUBMODULE_UPDATE_OPTIONS_VERSION , { GIT_CHECKOUT_OPTIONS_VERSION , GIT_CHECKOUT_SAFE } , GIT_FETCH_OPTIONS_INIT , 1 };`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_SUBMODULE_UPDATE_OPTIONS_INIT); }))) {
            mixin(enumMixinStr_GIT_SUBMODULE_UPDATE_OPTIONS_INIT);
        }
    }




    static if(!is(typeof(GIT_SUBMODULE_UPDATE_OPTIONS_VERSION))) {
        private enum enumMixinStr_GIT_SUBMODULE_UPDATE_OPTIONS_VERSION = `enum GIT_SUBMODULE_UPDATE_OPTIONS_VERSION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_SUBMODULE_UPDATE_OPTIONS_VERSION); }))) {
            mixin(enumMixinStr_GIT_SUBMODULE_UPDATE_OPTIONS_VERSION);
        }
    }
    static if(!is(typeof(GIT_SUBMODULE_STATUS__WD_FLAGS))) {
        private enum enumMixinStr_GIT_SUBMODULE_STATUS__WD_FLAGS = `enum GIT_SUBMODULE_STATUS__WD_FLAGS = 0x3F80u;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_SUBMODULE_STATUS__WD_FLAGS); }))) {
            mixin(enumMixinStr_GIT_SUBMODULE_STATUS__WD_FLAGS);
        }
    }




    static if(!is(typeof(GIT_SUBMODULE_STATUS__INDEX_FLAGS))) {
        private enum enumMixinStr_GIT_SUBMODULE_STATUS__INDEX_FLAGS = `enum GIT_SUBMODULE_STATUS__INDEX_FLAGS = 0x0070u;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_SUBMODULE_STATUS__INDEX_FLAGS); }))) {
            mixin(enumMixinStr_GIT_SUBMODULE_STATUS__INDEX_FLAGS);
        }
    }




    static if(!is(typeof(GIT_SUBMODULE_STATUS__IN_FLAGS))) {
        private enum enumMixinStr_GIT_SUBMODULE_STATUS__IN_FLAGS = `enum GIT_SUBMODULE_STATUS__IN_FLAGS = 0x000Fu;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_SUBMODULE_STATUS__IN_FLAGS); }))) {
            mixin(enumMixinStr_GIT_SUBMODULE_STATUS__IN_FLAGS);
        }
    }
    static if(!is(typeof(GIT_STATUS_OPTIONS_INIT))) {
        private enum enumMixinStr_GIT_STATUS_OPTIONS_INIT = `enum GIT_STATUS_OPTIONS_INIT = { GIT_STATUS_OPTIONS_VERSION };`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_STATUS_OPTIONS_INIT); }))) {
            mixin(enumMixinStr_GIT_STATUS_OPTIONS_INIT);
        }
    }




    static if(!is(typeof(GIT_STATUS_OPTIONS_VERSION))) {
        private enum enumMixinStr_GIT_STATUS_OPTIONS_VERSION = `enum GIT_STATUS_OPTIONS_VERSION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_STATUS_OPTIONS_VERSION); }))) {
            mixin(enumMixinStr_GIT_STATUS_OPTIONS_VERSION);
        }
    }




    static if(!is(typeof(GIT_STATUS_OPT_DEFAULTS))) {
        private enum enumMixinStr_GIT_STATUS_OPT_DEFAULTS = `enum GIT_STATUS_OPT_DEFAULTS = ( GIT_STATUS_OPT_INCLUDE_IGNORED | GIT_STATUS_OPT_INCLUDE_UNTRACKED | GIT_STATUS_OPT_RECURSE_UNTRACKED_DIRS );`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_STATUS_OPT_DEFAULTS); }))) {
            mixin(enumMixinStr_GIT_STATUS_OPT_DEFAULTS);
        }
    }






    static if(!is(typeof(GIT_STASH_APPLY_OPTIONS_INIT))) {
        private enum enumMixinStr_GIT_STASH_APPLY_OPTIONS_INIT = `enum GIT_STASH_APPLY_OPTIONS_INIT = { GIT_STASH_APPLY_OPTIONS_VERSION , GIT_STASH_APPLY_DEFAULT , GIT_CHECKOUT_OPTIONS_INIT };`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_STASH_APPLY_OPTIONS_INIT); }))) {
            mixin(enumMixinStr_GIT_STASH_APPLY_OPTIONS_INIT);
        }
    }




    static if(!is(typeof(GIT_STASH_APPLY_OPTIONS_VERSION))) {
        private enum enumMixinStr_GIT_STASH_APPLY_OPTIONS_VERSION = `enum GIT_STASH_APPLY_OPTIONS_VERSION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_STASH_APPLY_OPTIONS_VERSION); }))) {
            mixin(enumMixinStr_GIT_STASH_APPLY_OPTIONS_VERSION);
        }
    }
    static if(!is(typeof(GIT_REVERT_OPTIONS_INIT))) {
        private enum enumMixinStr_GIT_REVERT_OPTIONS_INIT = `enum GIT_REVERT_OPTIONS_INIT = { GIT_REVERT_OPTIONS_VERSION , 0 , GIT_MERGE_OPTIONS_INIT , GIT_CHECKOUT_OPTIONS_INIT };`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_REVERT_OPTIONS_INIT); }))) {
            mixin(enumMixinStr_GIT_REVERT_OPTIONS_INIT);
        }
    }




    static if(!is(typeof(GIT_REVERT_OPTIONS_VERSION))) {
        private enum enumMixinStr_GIT_REVERT_OPTIONS_VERSION = `enum GIT_REVERT_OPTIONS_VERSION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_REVERT_OPTIONS_VERSION); }))) {
            mixin(enumMixinStr_GIT_REVERT_OPTIONS_VERSION);
        }
    }
    static if(!is(typeof(GIT_REPOSITORY_INIT_OPTIONS_INIT))) {
        private enum enumMixinStr_GIT_REPOSITORY_INIT_OPTIONS_INIT = `enum GIT_REPOSITORY_INIT_OPTIONS_INIT = { GIT_REPOSITORY_INIT_OPTIONS_VERSION };`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_REPOSITORY_INIT_OPTIONS_INIT); }))) {
            mixin(enumMixinStr_GIT_REPOSITORY_INIT_OPTIONS_INIT);
        }
    }




    static if(!is(typeof(GIT_REPOSITORY_INIT_OPTIONS_VERSION))) {
        private enum enumMixinStr_GIT_REPOSITORY_INIT_OPTIONS_VERSION = `enum GIT_REPOSITORY_INIT_OPTIONS_VERSION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_REPOSITORY_INIT_OPTIONS_VERSION); }))) {
            mixin(enumMixinStr_GIT_REPOSITORY_INIT_OPTIONS_VERSION);
        }
    }






    static if(!is(typeof(GIT_PUSH_OPTIONS_INIT))) {
        private enum enumMixinStr_GIT_PUSH_OPTIONS_INIT = `enum GIT_PUSH_OPTIONS_INIT = { GIT_PUSH_OPTIONS_VERSION , 1 , GIT_REMOTE_CALLBACKS_INIT , GIT_PROXY_OPTIONS_INIT };`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_PUSH_OPTIONS_INIT); }))) {
            mixin(enumMixinStr_GIT_PUSH_OPTIONS_INIT);
        }
    }




    static if(!is(typeof(GIT_PUSH_OPTIONS_VERSION))) {
        private enum enumMixinStr_GIT_PUSH_OPTIONS_VERSION = `enum GIT_PUSH_OPTIONS_VERSION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_PUSH_OPTIONS_VERSION); }))) {
            mixin(enumMixinStr_GIT_PUSH_OPTIONS_VERSION);
        }
    }




    static if(!is(typeof(GIT_FETCH_OPTIONS_INIT))) {
        private enum enumMixinStr_GIT_FETCH_OPTIONS_INIT = `enum GIT_FETCH_OPTIONS_INIT = { GIT_FETCH_OPTIONS_VERSION , GIT_REMOTE_CALLBACKS_INIT , GIT_FETCH_PRUNE_UNSPECIFIED , 1 , GIT_REMOTE_DOWNLOAD_TAGS_UNSPECIFIED , GIT_PROXY_OPTIONS_INIT };`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_FETCH_OPTIONS_INIT); }))) {
            mixin(enumMixinStr_GIT_FETCH_OPTIONS_INIT);
        }
    }




    static if(!is(typeof(GIT_FETCH_OPTIONS_VERSION))) {
        private enum enumMixinStr_GIT_FETCH_OPTIONS_VERSION = `enum GIT_FETCH_OPTIONS_VERSION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_FETCH_OPTIONS_VERSION); }))) {
            mixin(enumMixinStr_GIT_FETCH_OPTIONS_VERSION);
        }
    }




    static if(!is(typeof(GIT_REMOTE_CALLBACKS_INIT))) {
        private enum enumMixinStr_GIT_REMOTE_CALLBACKS_INIT = `enum GIT_REMOTE_CALLBACKS_INIT = { GIT_REMOTE_CALLBACKS_VERSION };`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_REMOTE_CALLBACKS_INIT); }))) {
            mixin(enumMixinStr_GIT_REMOTE_CALLBACKS_INIT);
        }
    }




    static if(!is(typeof(GIT_REMOTE_CALLBACKS_VERSION))) {
        private enum enumMixinStr_GIT_REMOTE_CALLBACKS_VERSION = `enum GIT_REMOTE_CALLBACKS_VERSION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_REMOTE_CALLBACKS_VERSION); }))) {
            mixin(enumMixinStr_GIT_REMOTE_CALLBACKS_VERSION);
        }
    }




    static if(!is(typeof(GIT_REMOTE_CREATE_OPTIONS_INIT))) {
        private enum enumMixinStr_GIT_REMOTE_CREATE_OPTIONS_INIT = `enum GIT_REMOTE_CREATE_OPTIONS_INIT = { GIT_REMOTE_CREATE_OPTIONS_VERSION };`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_REMOTE_CREATE_OPTIONS_INIT); }))) {
            mixin(enumMixinStr_GIT_REMOTE_CREATE_OPTIONS_INIT);
        }
    }




    static if(!is(typeof(GIT_REMOTE_CREATE_OPTIONS_VERSION))) {
        private enum enumMixinStr_GIT_REMOTE_CREATE_OPTIONS_VERSION = `enum GIT_REMOTE_CREATE_OPTIONS_VERSION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_REMOTE_CREATE_OPTIONS_VERSION); }))) {
            mixin(enumMixinStr_GIT_REMOTE_CREATE_OPTIONS_VERSION);
        }
    }
    static if(!is(typeof(GIT_REBASE_NO_OPERATION))) {
        private enum enumMixinStr_GIT_REBASE_NO_OPERATION = `enum GIT_REBASE_NO_OPERATION = SIZE_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_REBASE_NO_OPERATION); }))) {
            mixin(enumMixinStr_GIT_REBASE_NO_OPERATION);
        }
    }




    static if(!is(typeof(GIT_REBASE_OPTIONS_INIT))) {
        private enum enumMixinStr_GIT_REBASE_OPTIONS_INIT = `enum GIT_REBASE_OPTIONS_INIT = { GIT_REBASE_OPTIONS_VERSION , 0 , 0 , null , GIT_MERGE_OPTIONS_INIT , GIT_CHECKOUT_OPTIONS_INIT , null , null };`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_REBASE_OPTIONS_INIT); }))) {
            mixin(enumMixinStr_GIT_REBASE_OPTIONS_INIT);
        }
    }




    static if(!is(typeof(GIT_REBASE_OPTIONS_VERSION))) {
        private enum enumMixinStr_GIT_REBASE_OPTIONS_VERSION = `enum GIT_REBASE_OPTIONS_VERSION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_REBASE_OPTIONS_VERSION); }))) {
            mixin(enumMixinStr_GIT_REBASE_OPTIONS_VERSION);
        }
    }






    static if(!is(typeof(GIT_PROXY_OPTIONS_INIT))) {
        private enum enumMixinStr_GIT_PROXY_OPTIONS_INIT = `enum GIT_PROXY_OPTIONS_INIT = { GIT_PROXY_OPTIONS_VERSION };`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_PROXY_OPTIONS_INIT); }))) {
            mixin(enumMixinStr_GIT_PROXY_OPTIONS_INIT);
        }
    }




    static if(!is(typeof(GIT_PROXY_OPTIONS_VERSION))) {
        private enum enumMixinStr_GIT_PROXY_OPTIONS_VERSION = `enum GIT_PROXY_OPTIONS_VERSION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_PROXY_OPTIONS_VERSION); }))) {
            mixin(enumMixinStr_GIT_PROXY_OPTIONS_VERSION);
        }
    }
    static if(!is(typeof(GIT_OID_MINPREFIXLEN))) {
        private enum enumMixinStr_GIT_OID_MINPREFIXLEN = `enum GIT_OID_MINPREFIXLEN = 4;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_OID_MINPREFIXLEN); }))) {
            mixin(enumMixinStr_GIT_OID_MINPREFIXLEN);
        }
    }




    static if(!is(typeof(GIT_OID_HEXSZ))) {
        private enum enumMixinStr_GIT_OID_HEXSZ = `enum GIT_OID_HEXSZ = ( GIT_OID_RAWSZ * 2 );`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_OID_HEXSZ); }))) {
            mixin(enumMixinStr_GIT_OID_HEXSZ);
        }
    }




    static if(!is(typeof(GIT_OID_RAWSZ))) {
        private enum enumMixinStr_GIT_OID_RAWSZ = `enum GIT_OID_RAWSZ = 20;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_OID_RAWSZ); }))) {
            mixin(enumMixinStr_GIT_OID_RAWSZ);
        }
    }
    static if(!is(typeof(GIT_OBJECT_SIZE_MAX))) {
        private enum enumMixinStr_GIT_OBJECT_SIZE_MAX = `enum GIT_OBJECT_SIZE_MAX = UINT64_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_OBJECT_SIZE_MAX); }))) {
            mixin(enumMixinStr_GIT_OBJECT_SIZE_MAX);
        }
    }
    static if(!is(typeof(GIT_DEFAULT_PORT))) {
        private enum enumMixinStr_GIT_DEFAULT_PORT = `enum GIT_DEFAULT_PORT = "9418";`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_DEFAULT_PORT); }))) {
            mixin(enumMixinStr_GIT_DEFAULT_PORT);
        }
    }
    static if(!is(typeof(GIT_MERGE_OPTIONS_INIT))) {
        private enum enumMixinStr_GIT_MERGE_OPTIONS_INIT = `enum GIT_MERGE_OPTIONS_INIT = { GIT_MERGE_OPTIONS_VERSION , GIT_MERGE_FIND_RENAMES };`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_MERGE_OPTIONS_INIT); }))) {
            mixin(enumMixinStr_GIT_MERGE_OPTIONS_INIT);
        }
    }




    static if(!is(typeof(GIT_MERGE_OPTIONS_VERSION))) {
        private enum enumMixinStr_GIT_MERGE_OPTIONS_VERSION = `enum GIT_MERGE_OPTIONS_VERSION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_MERGE_OPTIONS_VERSION); }))) {
            mixin(enumMixinStr_GIT_MERGE_OPTIONS_VERSION);
        }
    }




    static if(!is(typeof(GIT_MERGE_FILE_OPTIONS_INIT))) {
        private enum enumMixinStr_GIT_MERGE_FILE_OPTIONS_INIT = `enum GIT_MERGE_FILE_OPTIONS_INIT = { GIT_MERGE_FILE_OPTIONS_VERSION };`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_MERGE_FILE_OPTIONS_INIT); }))) {
            mixin(enumMixinStr_GIT_MERGE_FILE_OPTIONS_INIT);
        }
    }




    static if(!is(typeof(GIT_MERGE_FILE_OPTIONS_VERSION))) {
        private enum enumMixinStr_GIT_MERGE_FILE_OPTIONS_VERSION = `enum GIT_MERGE_FILE_OPTIONS_VERSION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_MERGE_FILE_OPTIONS_VERSION); }))) {
            mixin(enumMixinStr_GIT_MERGE_FILE_OPTIONS_VERSION);
        }
    }




    static if(!is(typeof(GIT_MERGE_CONFLICT_MARKER_SIZE))) {
        private enum enumMixinStr_GIT_MERGE_CONFLICT_MARKER_SIZE = `enum GIT_MERGE_CONFLICT_MARKER_SIZE = 7;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_MERGE_CONFLICT_MARKER_SIZE); }))) {
            mixin(enumMixinStr_GIT_MERGE_CONFLICT_MARKER_SIZE);
        }
    }




    static if(!is(typeof(GIT_MERGE_FILE_INPUT_INIT))) {
        private enum enumMixinStr_GIT_MERGE_FILE_INPUT_INIT = `enum GIT_MERGE_FILE_INPUT_INIT = { GIT_MERGE_FILE_INPUT_VERSION };`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_MERGE_FILE_INPUT_INIT); }))) {
            mixin(enumMixinStr_GIT_MERGE_FILE_INPUT_INIT);
        }
    }




    static if(!is(typeof(GIT_MERGE_FILE_INPUT_VERSION))) {
        private enum enumMixinStr_GIT_MERGE_FILE_INPUT_VERSION = `enum GIT_MERGE_FILE_INPUT_VERSION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_MERGE_FILE_INPUT_VERSION); }))) {
            mixin(enumMixinStr_GIT_MERGE_FILE_INPUT_VERSION);
        }
    }
    static if(!is(typeof(GIT_INDEXER_OPTIONS_INIT))) {
        private enum enumMixinStr_GIT_INDEXER_OPTIONS_INIT = `enum GIT_INDEXER_OPTIONS_INIT = { GIT_INDEXER_OPTIONS_VERSION };`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_INDEXER_OPTIONS_INIT); }))) {
            mixin(enumMixinStr_GIT_INDEXER_OPTIONS_INIT);
        }
    }




    static if(!is(typeof(GIT_INDEXER_OPTIONS_VERSION))) {
        private enum enumMixinStr_GIT_INDEXER_OPTIONS_VERSION = `enum GIT_INDEXER_OPTIONS_VERSION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_INDEXER_OPTIONS_VERSION); }))) {
            mixin(enumMixinStr_GIT_INDEXER_OPTIONS_VERSION);
        }
    }
    static if(!is(typeof(GIT_INDEX_ENTRY_STAGESHIFT))) {
        private enum enumMixinStr_GIT_INDEX_ENTRY_STAGESHIFT = `enum GIT_INDEX_ENTRY_STAGESHIFT = 12;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_INDEX_ENTRY_STAGESHIFT); }))) {
            mixin(enumMixinStr_GIT_INDEX_ENTRY_STAGESHIFT);
        }
    }




    static if(!is(typeof(GIT_INDEX_ENTRY_STAGEMASK))) {
        private enum enumMixinStr_GIT_INDEX_ENTRY_STAGEMASK = `enum GIT_INDEX_ENTRY_STAGEMASK = ( 0x3000 );`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_INDEX_ENTRY_STAGEMASK); }))) {
            mixin(enumMixinStr_GIT_INDEX_ENTRY_STAGEMASK);
        }
    }




    static if(!is(typeof(GIT_INDEX_ENTRY_NAMEMASK))) {
        private enum enumMixinStr_GIT_INDEX_ENTRY_NAMEMASK = `enum GIT_INDEX_ENTRY_NAMEMASK = ( 0x0fff );`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_INDEX_ENTRY_NAMEMASK); }))) {
            mixin(enumMixinStr_GIT_INDEX_ENTRY_NAMEMASK);
        }
    }
    static if(!is(typeof(LIBGIT2_VERSION))) {
        private enum enumMixinStr_LIBGIT2_VERSION = `enum LIBGIT2_VERSION = "1.0.1";`;
        static if(is(typeof({ mixin(enumMixinStr_LIBGIT2_VERSION); }))) {
            mixin(enumMixinStr_LIBGIT2_VERSION);
        }
    }




    static if(!is(typeof(LIBGIT2_VER_MAJOR))) {
        private enum enumMixinStr_LIBGIT2_VER_MAJOR = `enum LIBGIT2_VER_MAJOR = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_LIBGIT2_VER_MAJOR); }))) {
            mixin(enumMixinStr_LIBGIT2_VER_MAJOR);
        }
    }




    static if(!is(typeof(LIBGIT2_VER_MINOR))) {
        private enum enumMixinStr_LIBGIT2_VER_MINOR = `enum LIBGIT2_VER_MINOR = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_LIBGIT2_VER_MINOR); }))) {
            mixin(enumMixinStr_LIBGIT2_VER_MINOR);
        }
    }




    static if(!is(typeof(LIBGIT2_VER_REVISION))) {
        private enum enumMixinStr_LIBGIT2_VER_REVISION = `enum LIBGIT2_VER_REVISION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_LIBGIT2_VER_REVISION); }))) {
            mixin(enumMixinStr_LIBGIT2_VER_REVISION);
        }
    }




    static if(!is(typeof(LIBGIT2_VER_PATCH))) {
        private enum enumMixinStr_LIBGIT2_VER_PATCH = `enum LIBGIT2_VER_PATCH = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_LIBGIT2_VER_PATCH); }))) {
            mixin(enumMixinStr_LIBGIT2_VER_PATCH);
        }
    }




    static if(!is(typeof(LIBGIT2_SOVERSION))) {
        private enum enumMixinStr_LIBGIT2_SOVERSION = `enum LIBGIT2_SOVERSION = "1.0";`;
        static if(is(typeof({ mixin(enumMixinStr_LIBGIT2_SOVERSION); }))) {
            mixin(enumMixinStr_LIBGIT2_SOVERSION);
        }
    }
    static if(!is(typeof(GIT_DIFF_PATCHID_OPTIONS_INIT))) {
        private enum enumMixinStr_GIT_DIFF_PATCHID_OPTIONS_INIT = `enum GIT_DIFF_PATCHID_OPTIONS_INIT = { GIT_DIFF_PATCHID_OPTIONS_VERSION };`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_DIFF_PATCHID_OPTIONS_INIT); }))) {
            mixin(enumMixinStr_GIT_DIFF_PATCHID_OPTIONS_INIT);
        }
    }




    static if(!is(typeof(GIT_DIFF_PATCHID_OPTIONS_VERSION))) {
        private enum enumMixinStr_GIT_DIFF_PATCHID_OPTIONS_VERSION = `enum GIT_DIFF_PATCHID_OPTIONS_VERSION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_DIFF_PATCHID_OPTIONS_VERSION); }))) {
            mixin(enumMixinStr_GIT_DIFF_PATCHID_OPTIONS_VERSION);
        }
    }




    static if(!is(typeof(GIT_DIFF_FORMAT_EMAIL_OPTIONS_INIT))) {
        private enum enumMixinStr_GIT_DIFF_FORMAT_EMAIL_OPTIONS_INIT = `enum GIT_DIFF_FORMAT_EMAIL_OPTIONS_INIT = { GIT_DIFF_FORMAT_EMAIL_OPTIONS_VERSION , 0 , 1 , 1 , null , null , null , null };`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_DIFF_FORMAT_EMAIL_OPTIONS_INIT); }))) {
            mixin(enumMixinStr_GIT_DIFF_FORMAT_EMAIL_OPTIONS_INIT);
        }
    }




    static if(!is(typeof(GIT_DIFF_FORMAT_EMAIL_OPTIONS_VERSION))) {
        private enum enumMixinStr_GIT_DIFF_FORMAT_EMAIL_OPTIONS_VERSION = `enum GIT_DIFF_FORMAT_EMAIL_OPTIONS_VERSION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_DIFF_FORMAT_EMAIL_OPTIONS_VERSION); }))) {
            mixin(enumMixinStr_GIT_DIFF_FORMAT_EMAIL_OPTIONS_VERSION);
        }
    }




    static if(!is(typeof(GIT_DIFF_FIND_OPTIONS_INIT))) {
        private enum enumMixinStr_GIT_DIFF_FIND_OPTIONS_INIT = `enum GIT_DIFF_FIND_OPTIONS_INIT = { GIT_DIFF_FIND_OPTIONS_VERSION };`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_DIFF_FIND_OPTIONS_INIT); }))) {
            mixin(enumMixinStr_GIT_DIFF_FIND_OPTIONS_INIT);
        }
    }




    static if(!is(typeof(GIT_DIFF_FIND_OPTIONS_VERSION))) {
        private enum enumMixinStr_GIT_DIFF_FIND_OPTIONS_VERSION = `enum GIT_DIFF_FIND_OPTIONS_VERSION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_DIFF_FIND_OPTIONS_VERSION); }))) {
            mixin(enumMixinStr_GIT_DIFF_FIND_OPTIONS_VERSION);
        }
    }




    static if(!is(typeof(GIT_DIFF_HUNK_HEADER_SIZE))) {
        private enum enumMixinStr_GIT_DIFF_HUNK_HEADER_SIZE = `enum GIT_DIFF_HUNK_HEADER_SIZE = 128;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_DIFF_HUNK_HEADER_SIZE); }))) {
            mixin(enumMixinStr_GIT_DIFF_HUNK_HEADER_SIZE);
        }
    }




    static if(!is(typeof(GIT_DIFF_OPTIONS_INIT))) {
        private enum enumMixinStr_GIT_DIFF_OPTIONS_INIT = `enum GIT_DIFF_OPTIONS_INIT = { GIT_DIFF_OPTIONS_VERSION , 0 , GIT_SUBMODULE_IGNORE_UNSPECIFIED , { null , 0 } , null , null , null , 3 };`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_DIFF_OPTIONS_INIT); }))) {
            mixin(enumMixinStr_GIT_DIFF_OPTIONS_INIT);
        }
    }




    static if(!is(typeof(GIT_DIFF_OPTIONS_VERSION))) {
        private enum enumMixinStr_GIT_DIFF_OPTIONS_VERSION = `enum GIT_DIFF_OPTIONS_VERSION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_DIFF_OPTIONS_VERSION); }))) {
            mixin(enumMixinStr_GIT_DIFF_OPTIONS_VERSION);
        }
    }






    static if(!is(typeof(GIT_DESCRIBE_FORMAT_OPTIONS_INIT))) {
        private enum enumMixinStr_GIT_DESCRIBE_FORMAT_OPTIONS_INIT = `enum GIT_DESCRIBE_FORMAT_OPTIONS_INIT = { GIT_DESCRIBE_FORMAT_OPTIONS_VERSION , GIT_DESCRIBE_DEFAULT_ABBREVIATED_SIZE , };`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_DESCRIBE_FORMAT_OPTIONS_INIT); }))) {
            mixin(enumMixinStr_GIT_DESCRIBE_FORMAT_OPTIONS_INIT);
        }
    }




    static if(!is(typeof(GIT_DESCRIBE_FORMAT_OPTIONS_VERSION))) {
        private enum enumMixinStr_GIT_DESCRIBE_FORMAT_OPTIONS_VERSION = `enum GIT_DESCRIBE_FORMAT_OPTIONS_VERSION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_DESCRIBE_FORMAT_OPTIONS_VERSION); }))) {
            mixin(enumMixinStr_GIT_DESCRIBE_FORMAT_OPTIONS_VERSION);
        }
    }




    static if(!is(typeof(GIT_DESCRIBE_OPTIONS_INIT))) {
        private enum enumMixinStr_GIT_DESCRIBE_OPTIONS_INIT = `enum GIT_DESCRIBE_OPTIONS_INIT = { GIT_DESCRIBE_OPTIONS_VERSION , GIT_DESCRIBE_DEFAULT_MAX_CANDIDATES_TAGS ,
 };`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_DESCRIBE_OPTIONS_INIT); }))) {
            mixin(enumMixinStr_GIT_DESCRIBE_OPTIONS_INIT);
        }
    }





    static if(!is(typeof(GIT_DESCRIBE_OPTIONS_VERSION))) {
        private enum enumMixinStr_GIT_DESCRIBE_OPTIONS_VERSION = `enum GIT_DESCRIBE_OPTIONS_VERSION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_DESCRIBE_OPTIONS_VERSION); }))) {
            mixin(enumMixinStr_GIT_DESCRIBE_OPTIONS_VERSION);
        }
    }




    static if(!is(typeof(GIT_DESCRIBE_DEFAULT_ABBREVIATED_SIZE))) {
        private enum enumMixinStr_GIT_DESCRIBE_DEFAULT_ABBREVIATED_SIZE = `enum GIT_DESCRIBE_DEFAULT_ABBREVIATED_SIZE = 7;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_DESCRIBE_DEFAULT_ABBREVIATED_SIZE); }))) {
            mixin(enumMixinStr_GIT_DESCRIBE_DEFAULT_ABBREVIATED_SIZE);
        }
    }




    static if(!is(typeof(GIT_DESCRIBE_DEFAULT_MAX_CANDIDATES_TAGS))) {
        private enum enumMixinStr_GIT_DESCRIBE_DEFAULT_MAX_CANDIDATES_TAGS = `enum GIT_DESCRIBE_DEFAULT_MAX_CANDIDATES_TAGS = 10;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_DESCRIBE_DEFAULT_MAX_CANDIDATES_TAGS); }))) {
            mixin(enumMixinStr_GIT_DESCRIBE_DEFAULT_MAX_CANDIDATES_TAGS);
        }
    }




    static if(!is(typeof(GIT_WORKTREE_ADD_OPTIONS_VERSION))) {
        private enum enumMixinStr_GIT_WORKTREE_ADD_OPTIONS_VERSION = `enum GIT_WORKTREE_ADD_OPTIONS_VERSION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_WORKTREE_ADD_OPTIONS_VERSION); }))) {
            mixin(enumMixinStr_GIT_WORKTREE_ADD_OPTIONS_VERSION);
        }
    }




    static if(!is(typeof(GIT_WORKTREE_ADD_OPTIONS_INIT))) {
        private enum enumMixinStr_GIT_WORKTREE_ADD_OPTIONS_INIT = `enum GIT_WORKTREE_ADD_OPTIONS_INIT = { 1 , 0 , null };`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_WORKTREE_ADD_OPTIONS_INIT); }))) {
            mixin(enumMixinStr_GIT_WORKTREE_ADD_OPTIONS_INIT);
        }
    }






    static if(!is(typeof(git_remote_completion_type))) {
        private enum enumMixinStr_git_remote_completion_type = `enum git_remote_completion_type = git_remote_completion_t;`;
        static if(is(typeof({ mixin(enumMixinStr_git_remote_completion_type); }))) {
            mixin(enumMixinStr_git_remote_completion_type);
        }
    }




    static if(!is(typeof(GIT_CREDTYPE_SSH_MEMORY))) {
        private enum enumMixinStr_GIT_CREDTYPE_SSH_MEMORY = `enum GIT_CREDTYPE_SSH_MEMORY = GIT_CREDENTIAL_SSH_MEMORY;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_CREDTYPE_SSH_MEMORY); }))) {
            mixin(enumMixinStr_GIT_CREDTYPE_SSH_MEMORY);
        }
    }




    static if(!is(typeof(GIT_CREDTYPE_USERNAME))) {
        private enum enumMixinStr_GIT_CREDTYPE_USERNAME = `enum GIT_CREDTYPE_USERNAME = GIT_CREDENTIAL_USERNAME;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_CREDTYPE_USERNAME); }))) {
            mixin(enumMixinStr_GIT_CREDTYPE_USERNAME);
        }
    }




    static if(!is(typeof(GIT_CREDTYPE_SSH_INTERACTIVE))) {
        private enum enumMixinStr_GIT_CREDTYPE_SSH_INTERACTIVE = `enum GIT_CREDTYPE_SSH_INTERACTIVE = GIT_CREDENTIAL_SSH_INTERACTIVE;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_CREDTYPE_SSH_INTERACTIVE); }))) {
            mixin(enumMixinStr_GIT_CREDTYPE_SSH_INTERACTIVE);
        }
    }




    static if(!is(typeof(GIT_CREDTYPE_DEFAULT))) {
        private enum enumMixinStr_GIT_CREDTYPE_DEFAULT = `enum GIT_CREDTYPE_DEFAULT = GIT_CREDENTIAL_DEFAULT;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_CREDTYPE_DEFAULT); }))) {
            mixin(enumMixinStr_GIT_CREDTYPE_DEFAULT);
        }
    }




    static if(!is(typeof(GIT_CREDTYPE_SSH_CUSTOM))) {
        private enum enumMixinStr_GIT_CREDTYPE_SSH_CUSTOM = `enum GIT_CREDTYPE_SSH_CUSTOM = GIT_CREDENTIAL_SSH_CUSTOM;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_CREDTYPE_SSH_CUSTOM); }))) {
            mixin(enumMixinStr_GIT_CREDTYPE_SSH_CUSTOM);
        }
    }




    static if(!is(typeof(GIT_CREDTYPE_SSH_KEY))) {
        private enum enumMixinStr_GIT_CREDTYPE_SSH_KEY = `enum GIT_CREDTYPE_SSH_KEY = GIT_CREDENTIAL_SSH_KEY;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_CREDTYPE_SSH_KEY); }))) {
            mixin(enumMixinStr_GIT_CREDTYPE_SSH_KEY);
        }
    }




    static if(!is(typeof(GIT_CREDTYPE_USERPASS_PLAINTEXT))) {
        private enum enumMixinStr_GIT_CREDTYPE_USERPASS_PLAINTEXT = `enum GIT_CREDTYPE_USERPASS_PLAINTEXT = GIT_CREDENTIAL_USERPASS_PLAINTEXT;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_CREDTYPE_USERPASS_PLAINTEXT); }))) {
            mixin(enumMixinStr_GIT_CREDTYPE_USERPASS_PLAINTEXT);
        }
    }




    static if(!is(typeof(git_credtype_t))) {
        private enum enumMixinStr_git_credtype_t = `enum git_credtype_t = git_credential_t;`;
        static if(is(typeof({ mixin(enumMixinStr_git_credtype_t); }))) {
            mixin(enumMixinStr_git_credtype_t);
        }
    }




    static if(!is(typeof(GIT_REF_FORMAT_REFSPEC_SHORTHAND))) {
        private enum enumMixinStr_GIT_REF_FORMAT_REFSPEC_SHORTHAND = `enum GIT_REF_FORMAT_REFSPEC_SHORTHAND = GIT_REFERENCE_FORMAT_REFSPEC_SHORTHAND;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_REF_FORMAT_REFSPEC_SHORTHAND); }))) {
            mixin(enumMixinStr_GIT_REF_FORMAT_REFSPEC_SHORTHAND);
        }
    }




    static if(!is(typeof(GIT_REF_FORMAT_REFSPEC_PATTERN))) {
        private enum enumMixinStr_GIT_REF_FORMAT_REFSPEC_PATTERN = `enum GIT_REF_FORMAT_REFSPEC_PATTERN = GIT_REFERENCE_FORMAT_REFSPEC_PATTERN;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_REF_FORMAT_REFSPEC_PATTERN); }))) {
            mixin(enumMixinStr_GIT_REF_FORMAT_REFSPEC_PATTERN);
        }
    }




    static if(!is(typeof(GIT_REF_FORMAT_ALLOW_ONELEVEL))) {
        private enum enumMixinStr_GIT_REF_FORMAT_ALLOW_ONELEVEL = `enum GIT_REF_FORMAT_ALLOW_ONELEVEL = GIT_REFERENCE_FORMAT_ALLOW_ONELEVEL;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_REF_FORMAT_ALLOW_ONELEVEL); }))) {
            mixin(enumMixinStr_GIT_REF_FORMAT_ALLOW_ONELEVEL);
        }
    }




    static if(!is(typeof(GIT_REF_FORMAT_NORMAL))) {
        private enum enumMixinStr_GIT_REF_FORMAT_NORMAL = `enum GIT_REF_FORMAT_NORMAL = GIT_REFERENCE_FORMAT_NORMAL;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_REF_FORMAT_NORMAL); }))) {
            mixin(enumMixinStr_GIT_REF_FORMAT_NORMAL);
        }
    }




    static if(!is(typeof(GIT_REF_LISTALL))) {
        private enum enumMixinStr_GIT_REF_LISTALL = `enum GIT_REF_LISTALL = GIT_REFERENCE_ALL;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_REF_LISTALL); }))) {
            mixin(enumMixinStr_GIT_REF_LISTALL);
        }
    }




    static if(!is(typeof(GIT_REF_SYMBOLIC))) {
        private enum enumMixinStr_GIT_REF_SYMBOLIC = `enum GIT_REF_SYMBOLIC = GIT_REFERENCE_SYMBOLIC;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_REF_SYMBOLIC); }))) {
            mixin(enumMixinStr_GIT_REF_SYMBOLIC);
        }
    }




    static if(!is(typeof(GIT_REF_OID))) {
        private enum enumMixinStr_GIT_REF_OID = `enum GIT_REF_OID = GIT_REFERENCE_DIRECT;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_REF_OID); }))) {
            mixin(enumMixinStr_GIT_REF_OID);
        }
    }




    static if(!is(typeof(GIT_REF_INVALID))) {
        private enum enumMixinStr_GIT_REF_INVALID = `enum GIT_REF_INVALID = GIT_REFERENCE_INVALID;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_REF_INVALID); }))) {
            mixin(enumMixinStr_GIT_REF_INVALID);
        }
    }




    static if(!is(typeof(GIT_WORKTREE_PRUNE_OPTIONS_VERSION))) {
        private enum enumMixinStr_GIT_WORKTREE_PRUNE_OPTIONS_VERSION = `enum GIT_WORKTREE_PRUNE_OPTIONS_VERSION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_WORKTREE_PRUNE_OPTIONS_VERSION); }))) {
            mixin(enumMixinStr_GIT_WORKTREE_PRUNE_OPTIONS_VERSION);
        }
    }




    static if(!is(typeof(GIT_WORKTREE_PRUNE_OPTIONS_INIT))) {
        private enum enumMixinStr_GIT_WORKTREE_PRUNE_OPTIONS_INIT = `enum GIT_WORKTREE_PRUNE_OPTIONS_INIT = { 1 , 0 };`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_WORKTREE_PRUNE_OPTIONS_INIT); }))) {
            mixin(enumMixinStr_GIT_WORKTREE_PRUNE_OPTIONS_INIT);
        }
    }




    static if(!is(typeof(git_reference_normalize_t))) {
        private enum enumMixinStr_git_reference_normalize_t = `enum git_reference_normalize_t = git_reference_format_t;`;
        static if(is(typeof({ mixin(enumMixinStr_git_reference_normalize_t); }))) {
            mixin(enumMixinStr_git_reference_normalize_t);
        }
    }




    static if(!is(typeof(git_ref_t))) {
        private enum enumMixinStr_git_ref_t = `enum git_ref_t = git_reference_t;`;
        static if(is(typeof({ mixin(enumMixinStr_git_ref_t); }))) {
            mixin(enumMixinStr_git_ref_t);
        }
    }




    static if(!is(typeof(GIT_OBJ_REF_DELTA))) {
        private enum enumMixinStr_GIT_OBJ_REF_DELTA = `enum GIT_OBJ_REF_DELTA = GIT_OBJECT_REF_DELTA;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_OBJ_REF_DELTA); }))) {
            mixin(enumMixinStr_GIT_OBJ_REF_DELTA);
        }
    }




    static if(!is(typeof(GIT_OBJ_OFS_DELTA))) {
        private enum enumMixinStr_GIT_OBJ_OFS_DELTA = `enum GIT_OBJ_OFS_DELTA = GIT_OBJECT_OFS_DELTA;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_OBJ_OFS_DELTA); }))) {
            mixin(enumMixinStr_GIT_OBJ_OFS_DELTA);
        }
    }




    static if(!is(typeof(GIT_OBJ__EXT2))) {
        private enum enumMixinStr_GIT_OBJ__EXT2 = `enum GIT_OBJ__EXT2 = 5;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_OBJ__EXT2); }))) {
            mixin(enumMixinStr_GIT_OBJ__EXT2);
        }
    }




    static if(!is(typeof(GIT_OBJ_TAG))) {
        private enum enumMixinStr_GIT_OBJ_TAG = `enum GIT_OBJ_TAG = GIT_OBJECT_TAG;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_OBJ_TAG); }))) {
            mixin(enumMixinStr_GIT_OBJ_TAG);
        }
    }




    static if(!is(typeof(GIT_OBJ_BLOB))) {
        private enum enumMixinStr_GIT_OBJ_BLOB = `enum GIT_OBJ_BLOB = GIT_OBJECT_BLOB;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_OBJ_BLOB); }))) {
            mixin(enumMixinStr_GIT_OBJ_BLOB);
        }
    }
    static if(!is(typeof(GIT_OBJ_TREE))) {
        private enum enumMixinStr_GIT_OBJ_TREE = `enum GIT_OBJ_TREE = GIT_OBJECT_TREE;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_OBJ_TREE); }))) {
            mixin(enumMixinStr_GIT_OBJ_TREE);
        }
    }




    static if(!is(typeof(GIT_OBJ_COMMIT))) {
        private enum enumMixinStr_GIT_OBJ_COMMIT = `enum GIT_OBJ_COMMIT = GIT_OBJECT_COMMIT;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_OBJ_COMMIT); }))) {
            mixin(enumMixinStr_GIT_OBJ_COMMIT);
        }
    }




    static if(!is(typeof(GIT_OBJ__EXT1))) {
        private enum enumMixinStr_GIT_OBJ__EXT1 = `enum GIT_OBJ__EXT1 = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_OBJ__EXT1); }))) {
            mixin(enumMixinStr_GIT_OBJ__EXT1);
        }
    }




    static if(!is(typeof(GIT_OBJ_BAD))) {
        private enum enumMixinStr_GIT_OBJ_BAD = `enum GIT_OBJ_BAD = GIT_OBJECT_INVALID;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_OBJ_BAD); }))) {
            mixin(enumMixinStr_GIT_OBJ_BAD);
        }
    }




    static if(!is(typeof(GIT_OBJ_ANY))) {
        private enum enumMixinStr_GIT_OBJ_ANY = `enum GIT_OBJ_ANY = GIT_OBJECT_ANY;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_OBJ_ANY); }))) {
            mixin(enumMixinStr_GIT_OBJ_ANY);
        }
    }




    static if(!is(typeof(_INTTYPES_H))) {
        private enum enumMixinStr__INTTYPES_H = `enum _INTTYPES_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__INTTYPES_H); }))) {
            mixin(enumMixinStr__INTTYPES_H);
        }
    }




    static if(!is(typeof(git_otype))) {
        private enum enumMixinStr_git_otype = `enum git_otype = git_object_t;`;
        static if(is(typeof({ mixin(enumMixinStr_git_otype); }))) {
            mixin(enumMixinStr_git_otype);
        }
    }




    static if(!is(typeof(GIT_INDEXCAP_FROM_OWNER))) {
        private enum enumMixinStr_GIT_INDEXCAP_FROM_OWNER = `enum GIT_INDEXCAP_FROM_OWNER = GIT_INDEX_CAPABILITY_FROM_OWNER;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_INDEXCAP_FROM_OWNER); }))) {
            mixin(enumMixinStr_GIT_INDEXCAP_FROM_OWNER);
        }
    }




    static if(!is(typeof(GIT_INDEXCAP_NO_SYMLINKS))) {
        private enum enumMixinStr_GIT_INDEXCAP_NO_SYMLINKS = `enum GIT_INDEXCAP_NO_SYMLINKS = GIT_INDEX_CAPABILITY_NO_SYMLINKS;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_INDEXCAP_NO_SYMLINKS); }))) {
            mixin(enumMixinStr_GIT_INDEXCAP_NO_SYMLINKS);
        }
    }




    static if(!is(typeof(GIT_INDEXCAP_NO_FILEMODE))) {
        private enum enumMixinStr_GIT_INDEXCAP_NO_FILEMODE = `enum GIT_INDEXCAP_NO_FILEMODE = GIT_INDEX_CAPABILITY_NO_FILEMODE;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_INDEXCAP_NO_FILEMODE); }))) {
            mixin(enumMixinStr_GIT_INDEXCAP_NO_FILEMODE);
        }
    }




    static if(!is(typeof(GIT_INDEXCAP_IGNORE_CASE))) {
        private enum enumMixinStr_GIT_INDEXCAP_IGNORE_CASE = `enum GIT_INDEXCAP_IGNORE_CASE = GIT_INDEX_CAPABILITY_IGNORE_CASE;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_INDEXCAP_IGNORE_CASE); }))) {
            mixin(enumMixinStr_GIT_INDEXCAP_IGNORE_CASE);
        }
    }




    static if(!is(typeof(____gwchar_t_defined))) {
        private enum enumMixinStr_____gwchar_t_defined = `enum ____gwchar_t_defined = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_____gwchar_t_defined); }))) {
            mixin(enumMixinStr_____gwchar_t_defined);
        }
    }




    static if(!is(typeof(GIT_IDXENTRY_NEW_SKIP_WORKTREE))) {
        private enum enumMixinStr_GIT_IDXENTRY_NEW_SKIP_WORKTREE = `enum GIT_IDXENTRY_NEW_SKIP_WORKTREE = ( 1 << 9 );`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_IDXENTRY_NEW_SKIP_WORKTREE); }))) {
            mixin(enumMixinStr_GIT_IDXENTRY_NEW_SKIP_WORKTREE);
        }
    }




    static if(!is(typeof(__PRI64_PREFIX))) {
        private enum enumMixinStr___PRI64_PREFIX = `enum __PRI64_PREFIX = "l";`;
        static if(is(typeof({ mixin(enumMixinStr___PRI64_PREFIX); }))) {
            mixin(enumMixinStr___PRI64_PREFIX);
        }
    }




    static if(!is(typeof(__PRIPTR_PREFIX))) {
        private enum enumMixinStr___PRIPTR_PREFIX = `enum __PRIPTR_PREFIX = "l";`;
        static if(is(typeof({ mixin(enumMixinStr___PRIPTR_PREFIX); }))) {
            mixin(enumMixinStr___PRIPTR_PREFIX);
        }
    }




    static if(!is(typeof(PRId8))) {
        private enum enumMixinStr_PRId8 = `enum PRId8 = "d";`;
        static if(is(typeof({ mixin(enumMixinStr_PRId8); }))) {
            mixin(enumMixinStr_PRId8);
        }
    }




    static if(!is(typeof(PRId16))) {
        private enum enumMixinStr_PRId16 = `enum PRId16 = "d";`;
        static if(is(typeof({ mixin(enumMixinStr_PRId16); }))) {
            mixin(enumMixinStr_PRId16);
        }
    }




    static if(!is(typeof(PRId32))) {
        private enum enumMixinStr_PRId32 = `enum PRId32 = "d";`;
        static if(is(typeof({ mixin(enumMixinStr_PRId32); }))) {
            mixin(enumMixinStr_PRId32);
        }
    }




    static if(!is(typeof(PRId64))) {
        private enum enumMixinStr_PRId64 = `enum PRId64 = "l" "d";`;
        static if(is(typeof({ mixin(enumMixinStr_PRId64); }))) {
            mixin(enumMixinStr_PRId64);
        }
    }




    static if(!is(typeof(PRIdLEAST8))) {
        private enum enumMixinStr_PRIdLEAST8 = `enum PRIdLEAST8 = "d";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIdLEAST8); }))) {
            mixin(enumMixinStr_PRIdLEAST8);
        }
    }




    static if(!is(typeof(PRIdLEAST16))) {
        private enum enumMixinStr_PRIdLEAST16 = `enum PRIdLEAST16 = "d";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIdLEAST16); }))) {
            mixin(enumMixinStr_PRIdLEAST16);
        }
    }




    static if(!is(typeof(PRIdLEAST32))) {
        private enum enumMixinStr_PRIdLEAST32 = `enum PRIdLEAST32 = "d";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIdLEAST32); }))) {
            mixin(enumMixinStr_PRIdLEAST32);
        }
    }




    static if(!is(typeof(PRIdLEAST64))) {
        private enum enumMixinStr_PRIdLEAST64 = `enum PRIdLEAST64 = "l" "d";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIdLEAST64); }))) {
            mixin(enumMixinStr_PRIdLEAST64);
        }
    }




    static if(!is(typeof(PRIdFAST8))) {
        private enum enumMixinStr_PRIdFAST8 = `enum PRIdFAST8 = "d";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIdFAST8); }))) {
            mixin(enumMixinStr_PRIdFAST8);
        }
    }




    static if(!is(typeof(PRIdFAST16))) {
        private enum enumMixinStr_PRIdFAST16 = `enum PRIdFAST16 = "l" "d";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIdFAST16); }))) {
            mixin(enumMixinStr_PRIdFAST16);
        }
    }




    static if(!is(typeof(PRIdFAST32))) {
        private enum enumMixinStr_PRIdFAST32 = `enum PRIdFAST32 = "l" "d";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIdFAST32); }))) {
            mixin(enumMixinStr_PRIdFAST32);
        }
    }




    static if(!is(typeof(PRIdFAST64))) {
        private enum enumMixinStr_PRIdFAST64 = `enum PRIdFAST64 = "l" "d";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIdFAST64); }))) {
            mixin(enumMixinStr_PRIdFAST64);
        }
    }




    static if(!is(typeof(PRIi8))) {
        private enum enumMixinStr_PRIi8 = `enum PRIi8 = "i";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIi8); }))) {
            mixin(enumMixinStr_PRIi8);
        }
    }




    static if(!is(typeof(PRIi16))) {
        private enum enumMixinStr_PRIi16 = `enum PRIi16 = "i";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIi16); }))) {
            mixin(enumMixinStr_PRIi16);
        }
    }




    static if(!is(typeof(PRIi32))) {
        private enum enumMixinStr_PRIi32 = `enum PRIi32 = "i";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIi32); }))) {
            mixin(enumMixinStr_PRIi32);
        }
    }




    static if(!is(typeof(PRIi64))) {
        private enum enumMixinStr_PRIi64 = `enum PRIi64 = "l" "i";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIi64); }))) {
            mixin(enumMixinStr_PRIi64);
        }
    }




    static if(!is(typeof(PRIiLEAST8))) {
        private enum enumMixinStr_PRIiLEAST8 = `enum PRIiLEAST8 = "i";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIiLEAST8); }))) {
            mixin(enumMixinStr_PRIiLEAST8);
        }
    }




    static if(!is(typeof(PRIiLEAST16))) {
        private enum enumMixinStr_PRIiLEAST16 = `enum PRIiLEAST16 = "i";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIiLEAST16); }))) {
            mixin(enumMixinStr_PRIiLEAST16);
        }
    }




    static if(!is(typeof(PRIiLEAST32))) {
        private enum enumMixinStr_PRIiLEAST32 = `enum PRIiLEAST32 = "i";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIiLEAST32); }))) {
            mixin(enumMixinStr_PRIiLEAST32);
        }
    }




    static if(!is(typeof(PRIiLEAST64))) {
        private enum enumMixinStr_PRIiLEAST64 = `enum PRIiLEAST64 = "l" "i";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIiLEAST64); }))) {
            mixin(enumMixinStr_PRIiLEAST64);
        }
    }




    static if(!is(typeof(PRIiFAST8))) {
        private enum enumMixinStr_PRIiFAST8 = `enum PRIiFAST8 = "i";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIiFAST8); }))) {
            mixin(enumMixinStr_PRIiFAST8);
        }
    }




    static if(!is(typeof(PRIiFAST16))) {
        private enum enumMixinStr_PRIiFAST16 = `enum PRIiFAST16 = "l" "i";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIiFAST16); }))) {
            mixin(enumMixinStr_PRIiFAST16);
        }
    }




    static if(!is(typeof(PRIiFAST32))) {
        private enum enumMixinStr_PRIiFAST32 = `enum PRIiFAST32 = "l" "i";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIiFAST32); }))) {
            mixin(enumMixinStr_PRIiFAST32);
        }
    }




    static if(!is(typeof(PRIiFAST64))) {
        private enum enumMixinStr_PRIiFAST64 = `enum PRIiFAST64 = "l" "i";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIiFAST64); }))) {
            mixin(enumMixinStr_PRIiFAST64);
        }
    }




    static if(!is(typeof(PRIo8))) {
        private enum enumMixinStr_PRIo8 = `enum PRIo8 = "o";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIo8); }))) {
            mixin(enumMixinStr_PRIo8);
        }
    }




    static if(!is(typeof(PRIo16))) {
        private enum enumMixinStr_PRIo16 = `enum PRIo16 = "o";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIo16); }))) {
            mixin(enumMixinStr_PRIo16);
        }
    }




    static if(!is(typeof(PRIo32))) {
        private enum enumMixinStr_PRIo32 = `enum PRIo32 = "o";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIo32); }))) {
            mixin(enumMixinStr_PRIo32);
        }
    }




    static if(!is(typeof(PRIo64))) {
        private enum enumMixinStr_PRIo64 = `enum PRIo64 = "l" "o";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIo64); }))) {
            mixin(enumMixinStr_PRIo64);
        }
    }




    static if(!is(typeof(PRIoLEAST8))) {
        private enum enumMixinStr_PRIoLEAST8 = `enum PRIoLEAST8 = "o";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIoLEAST8); }))) {
            mixin(enumMixinStr_PRIoLEAST8);
        }
    }




    static if(!is(typeof(PRIoLEAST16))) {
        private enum enumMixinStr_PRIoLEAST16 = `enum PRIoLEAST16 = "o";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIoLEAST16); }))) {
            mixin(enumMixinStr_PRIoLEAST16);
        }
    }




    static if(!is(typeof(PRIoLEAST32))) {
        private enum enumMixinStr_PRIoLEAST32 = `enum PRIoLEAST32 = "o";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIoLEAST32); }))) {
            mixin(enumMixinStr_PRIoLEAST32);
        }
    }




    static if(!is(typeof(PRIoLEAST64))) {
        private enum enumMixinStr_PRIoLEAST64 = `enum PRIoLEAST64 = "l" "o";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIoLEAST64); }))) {
            mixin(enumMixinStr_PRIoLEAST64);
        }
    }




    static if(!is(typeof(PRIoFAST8))) {
        private enum enumMixinStr_PRIoFAST8 = `enum PRIoFAST8 = "o";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIoFAST8); }))) {
            mixin(enumMixinStr_PRIoFAST8);
        }
    }




    static if(!is(typeof(PRIoFAST16))) {
        private enum enumMixinStr_PRIoFAST16 = `enum PRIoFAST16 = "l" "o";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIoFAST16); }))) {
            mixin(enumMixinStr_PRIoFAST16);
        }
    }




    static if(!is(typeof(PRIoFAST32))) {
        private enum enumMixinStr_PRIoFAST32 = `enum PRIoFAST32 = "l" "o";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIoFAST32); }))) {
            mixin(enumMixinStr_PRIoFAST32);
        }
    }




    static if(!is(typeof(PRIoFAST64))) {
        private enum enumMixinStr_PRIoFAST64 = `enum PRIoFAST64 = "l" "o";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIoFAST64); }))) {
            mixin(enumMixinStr_PRIoFAST64);
        }
    }




    static if(!is(typeof(PRIu8))) {
        private enum enumMixinStr_PRIu8 = `enum PRIu8 = "u";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIu8); }))) {
            mixin(enumMixinStr_PRIu8);
        }
    }




    static if(!is(typeof(PRIu16))) {
        private enum enumMixinStr_PRIu16 = `enum PRIu16 = "u";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIu16); }))) {
            mixin(enumMixinStr_PRIu16);
        }
    }




    static if(!is(typeof(PRIu32))) {
        private enum enumMixinStr_PRIu32 = `enum PRIu32 = "u";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIu32); }))) {
            mixin(enumMixinStr_PRIu32);
        }
    }




    static if(!is(typeof(PRIu64))) {
        private enum enumMixinStr_PRIu64 = `enum PRIu64 = "l" "u";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIu64); }))) {
            mixin(enumMixinStr_PRIu64);
        }
    }




    static if(!is(typeof(PRIuLEAST8))) {
        private enum enumMixinStr_PRIuLEAST8 = `enum PRIuLEAST8 = "u";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIuLEAST8); }))) {
            mixin(enumMixinStr_PRIuLEAST8);
        }
    }




    static if(!is(typeof(PRIuLEAST16))) {
        private enum enumMixinStr_PRIuLEAST16 = `enum PRIuLEAST16 = "u";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIuLEAST16); }))) {
            mixin(enumMixinStr_PRIuLEAST16);
        }
    }




    static if(!is(typeof(PRIuLEAST32))) {
        private enum enumMixinStr_PRIuLEAST32 = `enum PRIuLEAST32 = "u";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIuLEAST32); }))) {
            mixin(enumMixinStr_PRIuLEAST32);
        }
    }




    static if(!is(typeof(PRIuLEAST64))) {
        private enum enumMixinStr_PRIuLEAST64 = `enum PRIuLEAST64 = "l" "u";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIuLEAST64); }))) {
            mixin(enumMixinStr_PRIuLEAST64);
        }
    }




    static if(!is(typeof(PRIuFAST8))) {
        private enum enumMixinStr_PRIuFAST8 = `enum PRIuFAST8 = "u";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIuFAST8); }))) {
            mixin(enumMixinStr_PRIuFAST8);
        }
    }




    static if(!is(typeof(PRIuFAST16))) {
        private enum enumMixinStr_PRIuFAST16 = `enum PRIuFAST16 = "l" "u";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIuFAST16); }))) {
            mixin(enumMixinStr_PRIuFAST16);
        }
    }




    static if(!is(typeof(PRIuFAST32))) {
        private enum enumMixinStr_PRIuFAST32 = `enum PRIuFAST32 = "l" "u";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIuFAST32); }))) {
            mixin(enumMixinStr_PRIuFAST32);
        }
    }




    static if(!is(typeof(PRIuFAST64))) {
        private enum enumMixinStr_PRIuFAST64 = `enum PRIuFAST64 = "l" "u";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIuFAST64); }))) {
            mixin(enumMixinStr_PRIuFAST64);
        }
    }




    static if(!is(typeof(PRIx8))) {
        private enum enumMixinStr_PRIx8 = `enum PRIx8 = "x";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIx8); }))) {
            mixin(enumMixinStr_PRIx8);
        }
    }




    static if(!is(typeof(PRIx16))) {
        private enum enumMixinStr_PRIx16 = `enum PRIx16 = "x";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIx16); }))) {
            mixin(enumMixinStr_PRIx16);
        }
    }




    static if(!is(typeof(PRIx32))) {
        private enum enumMixinStr_PRIx32 = `enum PRIx32 = "x";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIx32); }))) {
            mixin(enumMixinStr_PRIx32);
        }
    }




    static if(!is(typeof(PRIx64))) {
        private enum enumMixinStr_PRIx64 = `enum PRIx64 = "l" "x";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIx64); }))) {
            mixin(enumMixinStr_PRIx64);
        }
    }




    static if(!is(typeof(PRIxLEAST8))) {
        private enum enumMixinStr_PRIxLEAST8 = `enum PRIxLEAST8 = "x";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIxLEAST8); }))) {
            mixin(enumMixinStr_PRIxLEAST8);
        }
    }




    static if(!is(typeof(PRIxLEAST16))) {
        private enum enumMixinStr_PRIxLEAST16 = `enum PRIxLEAST16 = "x";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIxLEAST16); }))) {
            mixin(enumMixinStr_PRIxLEAST16);
        }
    }




    static if(!is(typeof(PRIxLEAST32))) {
        private enum enumMixinStr_PRIxLEAST32 = `enum PRIxLEAST32 = "x";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIxLEAST32); }))) {
            mixin(enumMixinStr_PRIxLEAST32);
        }
    }




    static if(!is(typeof(PRIxLEAST64))) {
        private enum enumMixinStr_PRIxLEAST64 = `enum PRIxLEAST64 = "l" "x";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIxLEAST64); }))) {
            mixin(enumMixinStr_PRIxLEAST64);
        }
    }




    static if(!is(typeof(PRIxFAST8))) {
        private enum enumMixinStr_PRIxFAST8 = `enum PRIxFAST8 = "x";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIxFAST8); }))) {
            mixin(enumMixinStr_PRIxFAST8);
        }
    }




    static if(!is(typeof(PRIxFAST16))) {
        private enum enumMixinStr_PRIxFAST16 = `enum PRIxFAST16 = "l" "x";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIxFAST16); }))) {
            mixin(enumMixinStr_PRIxFAST16);
        }
    }




    static if(!is(typeof(PRIxFAST32))) {
        private enum enumMixinStr_PRIxFAST32 = `enum PRIxFAST32 = "l" "x";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIxFAST32); }))) {
            mixin(enumMixinStr_PRIxFAST32);
        }
    }




    static if(!is(typeof(PRIxFAST64))) {
        private enum enumMixinStr_PRIxFAST64 = `enum PRIxFAST64 = "l" "x";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIxFAST64); }))) {
            mixin(enumMixinStr_PRIxFAST64);
        }
    }




    static if(!is(typeof(PRIX8))) {
        private enum enumMixinStr_PRIX8 = `enum PRIX8 = "X";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIX8); }))) {
            mixin(enumMixinStr_PRIX8);
        }
    }




    static if(!is(typeof(PRIX16))) {
        private enum enumMixinStr_PRIX16 = `enum PRIX16 = "X";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIX16); }))) {
            mixin(enumMixinStr_PRIX16);
        }
    }




    static if(!is(typeof(PRIX32))) {
        private enum enumMixinStr_PRIX32 = `enum PRIX32 = "X";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIX32); }))) {
            mixin(enumMixinStr_PRIX32);
        }
    }




    static if(!is(typeof(PRIX64))) {
        private enum enumMixinStr_PRIX64 = `enum PRIX64 = "l" "X";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIX64); }))) {
            mixin(enumMixinStr_PRIX64);
        }
    }




    static if(!is(typeof(PRIXLEAST8))) {
        private enum enumMixinStr_PRIXLEAST8 = `enum PRIXLEAST8 = "X";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIXLEAST8); }))) {
            mixin(enumMixinStr_PRIXLEAST8);
        }
    }




    static if(!is(typeof(PRIXLEAST16))) {
        private enum enumMixinStr_PRIXLEAST16 = `enum PRIXLEAST16 = "X";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIXLEAST16); }))) {
            mixin(enumMixinStr_PRIXLEAST16);
        }
    }




    static if(!is(typeof(PRIXLEAST32))) {
        private enum enumMixinStr_PRIXLEAST32 = `enum PRIXLEAST32 = "X";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIXLEAST32); }))) {
            mixin(enumMixinStr_PRIXLEAST32);
        }
    }




    static if(!is(typeof(PRIXLEAST64))) {
        private enum enumMixinStr_PRIXLEAST64 = `enum PRIXLEAST64 = "l" "X";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIXLEAST64); }))) {
            mixin(enumMixinStr_PRIXLEAST64);
        }
    }




    static if(!is(typeof(PRIXFAST8))) {
        private enum enumMixinStr_PRIXFAST8 = `enum PRIXFAST8 = "X";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIXFAST8); }))) {
            mixin(enumMixinStr_PRIXFAST8);
        }
    }




    static if(!is(typeof(PRIXFAST16))) {
        private enum enumMixinStr_PRIXFAST16 = `enum PRIXFAST16 = "l" "X";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIXFAST16); }))) {
            mixin(enumMixinStr_PRIXFAST16);
        }
    }




    static if(!is(typeof(PRIXFAST32))) {
        private enum enumMixinStr_PRIXFAST32 = `enum PRIXFAST32 = "l" "X";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIXFAST32); }))) {
            mixin(enumMixinStr_PRIXFAST32);
        }
    }




    static if(!is(typeof(PRIXFAST64))) {
        private enum enumMixinStr_PRIXFAST64 = `enum PRIXFAST64 = "l" "X";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIXFAST64); }))) {
            mixin(enumMixinStr_PRIXFAST64);
        }
    }




    static if(!is(typeof(PRIdMAX))) {
        private enum enumMixinStr_PRIdMAX = `enum PRIdMAX = "l" "d";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIdMAX); }))) {
            mixin(enumMixinStr_PRIdMAX);
        }
    }




    static if(!is(typeof(PRIiMAX))) {
        private enum enumMixinStr_PRIiMAX = `enum PRIiMAX = "l" "i";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIiMAX); }))) {
            mixin(enumMixinStr_PRIiMAX);
        }
    }




    static if(!is(typeof(PRIoMAX))) {
        private enum enumMixinStr_PRIoMAX = `enum PRIoMAX = "l" "o";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIoMAX); }))) {
            mixin(enumMixinStr_PRIoMAX);
        }
    }




    static if(!is(typeof(PRIuMAX))) {
        private enum enumMixinStr_PRIuMAX = `enum PRIuMAX = "l" "u";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIuMAX); }))) {
            mixin(enumMixinStr_PRIuMAX);
        }
    }




    static if(!is(typeof(PRIxMAX))) {
        private enum enumMixinStr_PRIxMAX = `enum PRIxMAX = "l" "x";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIxMAX); }))) {
            mixin(enumMixinStr_PRIxMAX);
        }
    }




    static if(!is(typeof(PRIXMAX))) {
        private enum enumMixinStr_PRIXMAX = `enum PRIXMAX = "l" "X";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIXMAX); }))) {
            mixin(enumMixinStr_PRIXMAX);
        }
    }




    static if(!is(typeof(PRIdPTR))) {
        private enum enumMixinStr_PRIdPTR = `enum PRIdPTR = "l" "d";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIdPTR); }))) {
            mixin(enumMixinStr_PRIdPTR);
        }
    }




    static if(!is(typeof(PRIiPTR))) {
        private enum enumMixinStr_PRIiPTR = `enum PRIiPTR = "l" "i";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIiPTR); }))) {
            mixin(enumMixinStr_PRIiPTR);
        }
    }




    static if(!is(typeof(PRIoPTR))) {
        private enum enumMixinStr_PRIoPTR = `enum PRIoPTR = "l" "o";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIoPTR); }))) {
            mixin(enumMixinStr_PRIoPTR);
        }
    }




    static if(!is(typeof(PRIuPTR))) {
        private enum enumMixinStr_PRIuPTR = `enum PRIuPTR = "l" "u";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIuPTR); }))) {
            mixin(enumMixinStr_PRIuPTR);
        }
    }




    static if(!is(typeof(PRIxPTR))) {
        private enum enumMixinStr_PRIxPTR = `enum PRIxPTR = "l" "x";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIxPTR); }))) {
            mixin(enumMixinStr_PRIxPTR);
        }
    }




    static if(!is(typeof(PRIXPTR))) {
        private enum enumMixinStr_PRIXPTR = `enum PRIXPTR = "l" "X";`;
        static if(is(typeof({ mixin(enumMixinStr_PRIXPTR); }))) {
            mixin(enumMixinStr_PRIXPTR);
        }
    }




    static if(!is(typeof(SCNd8))) {
        private enum enumMixinStr_SCNd8 = `enum SCNd8 = "hhd";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNd8); }))) {
            mixin(enumMixinStr_SCNd8);
        }
    }




    static if(!is(typeof(SCNd16))) {
        private enum enumMixinStr_SCNd16 = `enum SCNd16 = "hd";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNd16); }))) {
            mixin(enumMixinStr_SCNd16);
        }
    }




    static if(!is(typeof(SCNd32))) {
        private enum enumMixinStr_SCNd32 = `enum SCNd32 = "d";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNd32); }))) {
            mixin(enumMixinStr_SCNd32);
        }
    }




    static if(!is(typeof(SCNd64))) {
        private enum enumMixinStr_SCNd64 = `enum SCNd64 = "l" "d";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNd64); }))) {
            mixin(enumMixinStr_SCNd64);
        }
    }




    static if(!is(typeof(SCNdLEAST8))) {
        private enum enumMixinStr_SCNdLEAST8 = `enum SCNdLEAST8 = "hhd";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNdLEAST8); }))) {
            mixin(enumMixinStr_SCNdLEAST8);
        }
    }




    static if(!is(typeof(SCNdLEAST16))) {
        private enum enumMixinStr_SCNdLEAST16 = `enum SCNdLEAST16 = "hd";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNdLEAST16); }))) {
            mixin(enumMixinStr_SCNdLEAST16);
        }
    }




    static if(!is(typeof(SCNdLEAST32))) {
        private enum enumMixinStr_SCNdLEAST32 = `enum SCNdLEAST32 = "d";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNdLEAST32); }))) {
            mixin(enumMixinStr_SCNdLEAST32);
        }
    }




    static if(!is(typeof(SCNdLEAST64))) {
        private enum enumMixinStr_SCNdLEAST64 = `enum SCNdLEAST64 = "l" "d";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNdLEAST64); }))) {
            mixin(enumMixinStr_SCNdLEAST64);
        }
    }




    static if(!is(typeof(SCNdFAST8))) {
        private enum enumMixinStr_SCNdFAST8 = `enum SCNdFAST8 = "hhd";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNdFAST8); }))) {
            mixin(enumMixinStr_SCNdFAST8);
        }
    }




    static if(!is(typeof(SCNdFAST16))) {
        private enum enumMixinStr_SCNdFAST16 = `enum SCNdFAST16 = "l" "d";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNdFAST16); }))) {
            mixin(enumMixinStr_SCNdFAST16);
        }
    }




    static if(!is(typeof(SCNdFAST32))) {
        private enum enumMixinStr_SCNdFAST32 = `enum SCNdFAST32 = "l" "d";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNdFAST32); }))) {
            mixin(enumMixinStr_SCNdFAST32);
        }
    }




    static if(!is(typeof(SCNdFAST64))) {
        private enum enumMixinStr_SCNdFAST64 = `enum SCNdFAST64 = "l" "d";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNdFAST64); }))) {
            mixin(enumMixinStr_SCNdFAST64);
        }
    }




    static if(!is(typeof(SCNi8))) {
        private enum enumMixinStr_SCNi8 = `enum SCNi8 = "hhi";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNi8); }))) {
            mixin(enumMixinStr_SCNi8);
        }
    }




    static if(!is(typeof(SCNi16))) {
        private enum enumMixinStr_SCNi16 = `enum SCNi16 = "hi";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNi16); }))) {
            mixin(enumMixinStr_SCNi16);
        }
    }




    static if(!is(typeof(SCNi32))) {
        private enum enumMixinStr_SCNi32 = `enum SCNi32 = "i";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNi32); }))) {
            mixin(enumMixinStr_SCNi32);
        }
    }




    static if(!is(typeof(SCNi64))) {
        private enum enumMixinStr_SCNi64 = `enum SCNi64 = "l" "i";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNi64); }))) {
            mixin(enumMixinStr_SCNi64);
        }
    }




    static if(!is(typeof(SCNiLEAST8))) {
        private enum enumMixinStr_SCNiLEAST8 = `enum SCNiLEAST8 = "hhi";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNiLEAST8); }))) {
            mixin(enumMixinStr_SCNiLEAST8);
        }
    }




    static if(!is(typeof(SCNiLEAST16))) {
        private enum enumMixinStr_SCNiLEAST16 = `enum SCNiLEAST16 = "hi";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNiLEAST16); }))) {
            mixin(enumMixinStr_SCNiLEAST16);
        }
    }




    static if(!is(typeof(SCNiLEAST32))) {
        private enum enumMixinStr_SCNiLEAST32 = `enum SCNiLEAST32 = "i";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNiLEAST32); }))) {
            mixin(enumMixinStr_SCNiLEAST32);
        }
    }




    static if(!is(typeof(SCNiLEAST64))) {
        private enum enumMixinStr_SCNiLEAST64 = `enum SCNiLEAST64 = "l" "i";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNiLEAST64); }))) {
            mixin(enumMixinStr_SCNiLEAST64);
        }
    }




    static if(!is(typeof(SCNiFAST8))) {
        private enum enumMixinStr_SCNiFAST8 = `enum SCNiFAST8 = "hhi";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNiFAST8); }))) {
            mixin(enumMixinStr_SCNiFAST8);
        }
    }




    static if(!is(typeof(SCNiFAST16))) {
        private enum enumMixinStr_SCNiFAST16 = `enum SCNiFAST16 = "l" "i";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNiFAST16); }))) {
            mixin(enumMixinStr_SCNiFAST16);
        }
    }




    static if(!is(typeof(SCNiFAST32))) {
        private enum enumMixinStr_SCNiFAST32 = `enum SCNiFAST32 = "l" "i";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNiFAST32); }))) {
            mixin(enumMixinStr_SCNiFAST32);
        }
    }




    static if(!is(typeof(SCNiFAST64))) {
        private enum enumMixinStr_SCNiFAST64 = `enum SCNiFAST64 = "l" "i";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNiFAST64); }))) {
            mixin(enumMixinStr_SCNiFAST64);
        }
    }




    static if(!is(typeof(SCNu8))) {
        private enum enumMixinStr_SCNu8 = `enum SCNu8 = "hhu";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNu8); }))) {
            mixin(enumMixinStr_SCNu8);
        }
    }




    static if(!is(typeof(SCNu16))) {
        private enum enumMixinStr_SCNu16 = `enum SCNu16 = "hu";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNu16); }))) {
            mixin(enumMixinStr_SCNu16);
        }
    }




    static if(!is(typeof(SCNu32))) {
        private enum enumMixinStr_SCNu32 = `enum SCNu32 = "u";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNu32); }))) {
            mixin(enumMixinStr_SCNu32);
        }
    }




    static if(!is(typeof(SCNu64))) {
        private enum enumMixinStr_SCNu64 = `enum SCNu64 = "l" "u";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNu64); }))) {
            mixin(enumMixinStr_SCNu64);
        }
    }




    static if(!is(typeof(SCNuLEAST8))) {
        private enum enumMixinStr_SCNuLEAST8 = `enum SCNuLEAST8 = "hhu";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNuLEAST8); }))) {
            mixin(enumMixinStr_SCNuLEAST8);
        }
    }




    static if(!is(typeof(SCNuLEAST16))) {
        private enum enumMixinStr_SCNuLEAST16 = `enum SCNuLEAST16 = "hu";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNuLEAST16); }))) {
            mixin(enumMixinStr_SCNuLEAST16);
        }
    }




    static if(!is(typeof(SCNuLEAST32))) {
        private enum enumMixinStr_SCNuLEAST32 = `enum SCNuLEAST32 = "u";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNuLEAST32); }))) {
            mixin(enumMixinStr_SCNuLEAST32);
        }
    }




    static if(!is(typeof(SCNuLEAST64))) {
        private enum enumMixinStr_SCNuLEAST64 = `enum SCNuLEAST64 = "l" "u";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNuLEAST64); }))) {
            mixin(enumMixinStr_SCNuLEAST64);
        }
    }




    static if(!is(typeof(SCNuFAST8))) {
        private enum enumMixinStr_SCNuFAST8 = `enum SCNuFAST8 = "hhu";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNuFAST8); }))) {
            mixin(enumMixinStr_SCNuFAST8);
        }
    }




    static if(!is(typeof(SCNuFAST16))) {
        private enum enumMixinStr_SCNuFAST16 = `enum SCNuFAST16 = "l" "u";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNuFAST16); }))) {
            mixin(enumMixinStr_SCNuFAST16);
        }
    }




    static if(!is(typeof(SCNuFAST32))) {
        private enum enumMixinStr_SCNuFAST32 = `enum SCNuFAST32 = "l" "u";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNuFAST32); }))) {
            mixin(enumMixinStr_SCNuFAST32);
        }
    }




    static if(!is(typeof(SCNuFAST64))) {
        private enum enumMixinStr_SCNuFAST64 = `enum SCNuFAST64 = "l" "u";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNuFAST64); }))) {
            mixin(enumMixinStr_SCNuFAST64);
        }
    }




    static if(!is(typeof(SCNo8))) {
        private enum enumMixinStr_SCNo8 = `enum SCNo8 = "hho";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNo8); }))) {
            mixin(enumMixinStr_SCNo8);
        }
    }




    static if(!is(typeof(SCNo16))) {
        private enum enumMixinStr_SCNo16 = `enum SCNo16 = "ho";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNo16); }))) {
            mixin(enumMixinStr_SCNo16);
        }
    }




    static if(!is(typeof(SCNo32))) {
        private enum enumMixinStr_SCNo32 = `enum SCNo32 = "o";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNo32); }))) {
            mixin(enumMixinStr_SCNo32);
        }
    }




    static if(!is(typeof(SCNo64))) {
        private enum enumMixinStr_SCNo64 = `enum SCNo64 = "l" "o";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNo64); }))) {
            mixin(enumMixinStr_SCNo64);
        }
    }




    static if(!is(typeof(SCNoLEAST8))) {
        private enum enumMixinStr_SCNoLEAST8 = `enum SCNoLEAST8 = "hho";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNoLEAST8); }))) {
            mixin(enumMixinStr_SCNoLEAST8);
        }
    }




    static if(!is(typeof(SCNoLEAST16))) {
        private enum enumMixinStr_SCNoLEAST16 = `enum SCNoLEAST16 = "ho";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNoLEAST16); }))) {
            mixin(enumMixinStr_SCNoLEAST16);
        }
    }




    static if(!is(typeof(SCNoLEAST32))) {
        private enum enumMixinStr_SCNoLEAST32 = `enum SCNoLEAST32 = "o";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNoLEAST32); }))) {
            mixin(enumMixinStr_SCNoLEAST32);
        }
    }




    static if(!is(typeof(SCNoLEAST64))) {
        private enum enumMixinStr_SCNoLEAST64 = `enum SCNoLEAST64 = "l" "o";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNoLEAST64); }))) {
            mixin(enumMixinStr_SCNoLEAST64);
        }
    }




    static if(!is(typeof(SCNoFAST8))) {
        private enum enumMixinStr_SCNoFAST8 = `enum SCNoFAST8 = "hho";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNoFAST8); }))) {
            mixin(enumMixinStr_SCNoFAST8);
        }
    }




    static if(!is(typeof(SCNoFAST16))) {
        private enum enumMixinStr_SCNoFAST16 = `enum SCNoFAST16 = "l" "o";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNoFAST16); }))) {
            mixin(enumMixinStr_SCNoFAST16);
        }
    }




    static if(!is(typeof(SCNoFAST32))) {
        private enum enumMixinStr_SCNoFAST32 = `enum SCNoFAST32 = "l" "o";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNoFAST32); }))) {
            mixin(enumMixinStr_SCNoFAST32);
        }
    }




    static if(!is(typeof(SCNoFAST64))) {
        private enum enumMixinStr_SCNoFAST64 = `enum SCNoFAST64 = "l" "o";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNoFAST64); }))) {
            mixin(enumMixinStr_SCNoFAST64);
        }
    }




    static if(!is(typeof(SCNx8))) {
        private enum enumMixinStr_SCNx8 = `enum SCNx8 = "hhx";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNx8); }))) {
            mixin(enumMixinStr_SCNx8);
        }
    }




    static if(!is(typeof(SCNx16))) {
        private enum enumMixinStr_SCNx16 = `enum SCNx16 = "hx";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNx16); }))) {
            mixin(enumMixinStr_SCNx16);
        }
    }




    static if(!is(typeof(SCNx32))) {
        private enum enumMixinStr_SCNx32 = `enum SCNx32 = "x";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNx32); }))) {
            mixin(enumMixinStr_SCNx32);
        }
    }




    static if(!is(typeof(SCNx64))) {
        private enum enumMixinStr_SCNx64 = `enum SCNx64 = "l" "x";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNx64); }))) {
            mixin(enumMixinStr_SCNx64);
        }
    }




    static if(!is(typeof(SCNxLEAST8))) {
        private enum enumMixinStr_SCNxLEAST8 = `enum SCNxLEAST8 = "hhx";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNxLEAST8); }))) {
            mixin(enumMixinStr_SCNxLEAST8);
        }
    }




    static if(!is(typeof(SCNxLEAST16))) {
        private enum enumMixinStr_SCNxLEAST16 = `enum SCNxLEAST16 = "hx";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNxLEAST16); }))) {
            mixin(enumMixinStr_SCNxLEAST16);
        }
    }




    static if(!is(typeof(SCNxLEAST32))) {
        private enum enumMixinStr_SCNxLEAST32 = `enum SCNxLEAST32 = "x";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNxLEAST32); }))) {
            mixin(enumMixinStr_SCNxLEAST32);
        }
    }




    static if(!is(typeof(SCNxLEAST64))) {
        private enum enumMixinStr_SCNxLEAST64 = `enum SCNxLEAST64 = "l" "x";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNxLEAST64); }))) {
            mixin(enumMixinStr_SCNxLEAST64);
        }
    }




    static if(!is(typeof(SCNxFAST8))) {
        private enum enumMixinStr_SCNxFAST8 = `enum SCNxFAST8 = "hhx";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNxFAST8); }))) {
            mixin(enumMixinStr_SCNxFAST8);
        }
    }




    static if(!is(typeof(SCNxFAST16))) {
        private enum enumMixinStr_SCNxFAST16 = `enum SCNxFAST16 = "l" "x";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNxFAST16); }))) {
            mixin(enumMixinStr_SCNxFAST16);
        }
    }




    static if(!is(typeof(SCNxFAST32))) {
        private enum enumMixinStr_SCNxFAST32 = `enum SCNxFAST32 = "l" "x";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNxFAST32); }))) {
            mixin(enumMixinStr_SCNxFAST32);
        }
    }




    static if(!is(typeof(SCNxFAST64))) {
        private enum enumMixinStr_SCNxFAST64 = `enum SCNxFAST64 = "l" "x";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNxFAST64); }))) {
            mixin(enumMixinStr_SCNxFAST64);
        }
    }




    static if(!is(typeof(SCNdMAX))) {
        private enum enumMixinStr_SCNdMAX = `enum SCNdMAX = "l" "d";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNdMAX); }))) {
            mixin(enumMixinStr_SCNdMAX);
        }
    }




    static if(!is(typeof(SCNiMAX))) {
        private enum enumMixinStr_SCNiMAX = `enum SCNiMAX = "l" "i";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNiMAX); }))) {
            mixin(enumMixinStr_SCNiMAX);
        }
    }




    static if(!is(typeof(SCNoMAX))) {
        private enum enumMixinStr_SCNoMAX = `enum SCNoMAX = "l" "o";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNoMAX); }))) {
            mixin(enumMixinStr_SCNoMAX);
        }
    }




    static if(!is(typeof(SCNuMAX))) {
        private enum enumMixinStr_SCNuMAX = `enum SCNuMAX = "l" "u";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNuMAX); }))) {
            mixin(enumMixinStr_SCNuMAX);
        }
    }




    static if(!is(typeof(SCNxMAX))) {
        private enum enumMixinStr_SCNxMAX = `enum SCNxMAX = "l" "x";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNxMAX); }))) {
            mixin(enumMixinStr_SCNxMAX);
        }
    }




    static if(!is(typeof(SCNdPTR))) {
        private enum enumMixinStr_SCNdPTR = `enum SCNdPTR = "l" "d";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNdPTR); }))) {
            mixin(enumMixinStr_SCNdPTR);
        }
    }




    static if(!is(typeof(SCNiPTR))) {
        private enum enumMixinStr_SCNiPTR = `enum SCNiPTR = "l" "i";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNiPTR); }))) {
            mixin(enumMixinStr_SCNiPTR);
        }
    }




    static if(!is(typeof(SCNoPTR))) {
        private enum enumMixinStr_SCNoPTR = `enum SCNoPTR = "l" "o";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNoPTR); }))) {
            mixin(enumMixinStr_SCNoPTR);
        }
    }




    static if(!is(typeof(SCNuPTR))) {
        private enum enumMixinStr_SCNuPTR = `enum SCNuPTR = "l" "u";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNuPTR); }))) {
            mixin(enumMixinStr_SCNuPTR);
        }
    }




    static if(!is(typeof(SCNxPTR))) {
        private enum enumMixinStr_SCNxPTR = `enum SCNxPTR = "l" "x";`;
        static if(is(typeof({ mixin(enumMixinStr_SCNxPTR); }))) {
            mixin(enumMixinStr_SCNxPTR);
        }
    }




    static if(!is(typeof(GIT_IDXENTRY_UNPACKED))) {
        private enum enumMixinStr_GIT_IDXENTRY_UNPACKED = `enum GIT_IDXENTRY_UNPACKED = ( 1 << 8 );`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_IDXENTRY_UNPACKED); }))) {
            mixin(enumMixinStr_GIT_IDXENTRY_UNPACKED);
        }
    }




    static if(!is(typeof(GIT_IDXENTRY_CONFLICTED))) {
        private enum enumMixinStr_GIT_IDXENTRY_CONFLICTED = `enum GIT_IDXENTRY_CONFLICTED = ( 1 << 7 );`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_IDXENTRY_CONFLICTED); }))) {
            mixin(enumMixinStr_GIT_IDXENTRY_CONFLICTED);
        }
    }




    static if(!is(typeof(GIT_IDXENTRY_WT_REMOVE))) {
        private enum enumMixinStr_GIT_IDXENTRY_WT_REMOVE = `enum GIT_IDXENTRY_WT_REMOVE = ( 1 << 6 );`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_IDXENTRY_WT_REMOVE); }))) {
            mixin(enumMixinStr_GIT_IDXENTRY_WT_REMOVE);
        }
    }




    static if(!is(typeof(GIT_IDXENTRY_UNHASHED))) {
        private enum enumMixinStr_GIT_IDXENTRY_UNHASHED = `enum GIT_IDXENTRY_UNHASHED = ( 1 << 5 );`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_IDXENTRY_UNHASHED); }))) {
            mixin(enumMixinStr_GIT_IDXENTRY_UNHASHED);
        }
    }




    static if(!is(typeof(GIT_IDXENTRY_HASHED))) {
        private enum enumMixinStr_GIT_IDXENTRY_HASHED = `enum GIT_IDXENTRY_HASHED = ( 1 << 4 );`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_IDXENTRY_HASHED); }))) {
            mixin(enumMixinStr_GIT_IDXENTRY_HASHED);
        }
    }




    static if(!is(typeof(GIT_IDXENTRY_ADDED))) {
        private enum enumMixinStr_GIT_IDXENTRY_ADDED = `enum GIT_IDXENTRY_ADDED = ( 1 << 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_IDXENTRY_ADDED); }))) {
            mixin(enumMixinStr_GIT_IDXENTRY_ADDED);
        }
    }




    static if(!is(typeof(GIT_IDXENTRY_UPTODATE))) {
        private enum enumMixinStr_GIT_IDXENTRY_UPTODATE = `enum GIT_IDXENTRY_UPTODATE = ( 1 << 2 );`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_IDXENTRY_UPTODATE); }))) {
            mixin(enumMixinStr_GIT_IDXENTRY_UPTODATE);
        }
    }




    static if(!is(typeof(GIT_IDXENTRY_REMOVE))) {
        private enum enumMixinStr_GIT_IDXENTRY_REMOVE = `enum GIT_IDXENTRY_REMOVE = ( 1 << 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_IDXENTRY_REMOVE); }))) {
            mixin(enumMixinStr_GIT_IDXENTRY_REMOVE);
        }
    }




    static if(!is(typeof(GIT_IDXENTRY_UPDATE))) {
        private enum enumMixinStr_GIT_IDXENTRY_UPDATE = `enum GIT_IDXENTRY_UPDATE = ( 1 << 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_IDXENTRY_UPDATE); }))) {
            mixin(enumMixinStr_GIT_IDXENTRY_UPDATE);
        }
    }




    static if(!is(typeof(GIT_IDXENTRY_EXTENDED2))) {
        private enum enumMixinStr_GIT_IDXENTRY_EXTENDED2 = `enum GIT_IDXENTRY_EXTENDED2 = ( 1 << 15 );`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_IDXENTRY_EXTENDED2); }))) {
            mixin(enumMixinStr_GIT_IDXENTRY_EXTENDED2);
        }
    }




    static if(!is(typeof(GIT_IDXENTRY_EXTENDED_FLAGS))) {
        private enum enumMixinStr_GIT_IDXENTRY_EXTENDED_FLAGS = `enum GIT_IDXENTRY_EXTENDED_FLAGS = ( GIT_INDEX_ENTRY_INTENT_TO_ADD | GIT_INDEX_ENTRY_SKIP_WORKTREE );`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_IDXENTRY_EXTENDED_FLAGS); }))) {
            mixin(enumMixinStr_GIT_IDXENTRY_EXTENDED_FLAGS);
        }
    }




    static if(!is(typeof(GIT_IDXENTRY_SKIP_WORKTREE))) {
        private enum enumMixinStr_GIT_IDXENTRY_SKIP_WORKTREE = `enum GIT_IDXENTRY_SKIP_WORKTREE = GIT_INDEX_ENTRY_SKIP_WORKTREE;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_IDXENTRY_SKIP_WORKTREE); }))) {
            mixin(enumMixinStr_GIT_IDXENTRY_SKIP_WORKTREE);
        }
    }




    static if(!is(typeof(GIT_IDXENTRY_INTENT_TO_ADD))) {
        private enum enumMixinStr_GIT_IDXENTRY_INTENT_TO_ADD = `enum GIT_IDXENTRY_INTENT_TO_ADD = GIT_INDEX_ENTRY_INTENT_TO_ADD;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_IDXENTRY_INTENT_TO_ADD); }))) {
            mixin(enumMixinStr_GIT_IDXENTRY_INTENT_TO_ADD);
        }
    }
    static if(!is(typeof(GIT_IDXENTRY_VALID))) {
        private enum enumMixinStr_GIT_IDXENTRY_VALID = `enum GIT_IDXENTRY_VALID = GIT_INDEX_ENTRY_VALID;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_IDXENTRY_VALID); }))) {
            mixin(enumMixinStr_GIT_IDXENTRY_VALID);
        }
    }




    static if(!is(typeof(GIT_IDXENTRY_EXTENDED))) {
        private enum enumMixinStr_GIT_IDXENTRY_EXTENDED = `enum GIT_IDXENTRY_EXTENDED = GIT_INDEX_ENTRY_EXTENDED;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_IDXENTRY_EXTENDED); }))) {
            mixin(enumMixinStr_GIT_IDXENTRY_EXTENDED);
        }
    }




    static if(!is(typeof(_STDC_PREDEF_H))) {
        private enum enumMixinStr__STDC_PREDEF_H = `enum _STDC_PREDEF_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__STDC_PREDEF_H); }))) {
            mixin(enumMixinStr__STDC_PREDEF_H);
        }
    }




    static if(!is(typeof(_STDINT_H))) {
        private enum enumMixinStr__STDINT_H = `enum _STDINT_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__STDINT_H); }))) {
            mixin(enumMixinStr__STDINT_H);
        }
    }






    static if(!is(typeof(GIT_IDXENTRY_STAGESHIFT))) {
        private enum enumMixinStr_GIT_IDXENTRY_STAGESHIFT = `enum GIT_IDXENTRY_STAGESHIFT = 12;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_IDXENTRY_STAGESHIFT); }))) {
            mixin(enumMixinStr_GIT_IDXENTRY_STAGESHIFT);
        }
    }




    static if(!is(typeof(GIT_IDXENTRY_STAGEMASK))) {
        private enum enumMixinStr_GIT_IDXENTRY_STAGEMASK = `enum GIT_IDXENTRY_STAGEMASK = ( 0x3000 );`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_IDXENTRY_STAGEMASK); }))) {
            mixin(enumMixinStr_GIT_IDXENTRY_STAGEMASK);
        }
    }




    static if(!is(typeof(GIT_IDXENTRY_NAMEMASK))) {
        private enum enumMixinStr_GIT_IDXENTRY_NAMEMASK = `enum GIT_IDXENTRY_NAMEMASK = ( 0x0fff );`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_IDXENTRY_NAMEMASK); }))) {
            mixin(enumMixinStr_GIT_IDXENTRY_NAMEMASK);
        }
    }




    static if(!is(typeof(GITERR_SHA1))) {
        private enum enumMixinStr_GITERR_SHA1 = `enum GITERR_SHA1 = GIT_ERROR_SHA1;`;
        static if(is(typeof({ mixin(enumMixinStr_GITERR_SHA1); }))) {
            mixin(enumMixinStr_GITERR_SHA1);
        }
    }




    static if(!is(typeof(GITERR_WORKTREE))) {
        private enum enumMixinStr_GITERR_WORKTREE = `enum GITERR_WORKTREE = GIT_ERROR_WORKTREE;`;
        static if(is(typeof({ mixin(enumMixinStr_GITERR_WORKTREE); }))) {
            mixin(enumMixinStr_GITERR_WORKTREE);
        }
    }




    static if(!is(typeof(GITERR_PATCH))) {
        private enum enumMixinStr_GITERR_PATCH = `enum GITERR_PATCH = GIT_ERROR_PATCH;`;
        static if(is(typeof({ mixin(enumMixinStr_GITERR_PATCH); }))) {
            mixin(enumMixinStr_GITERR_PATCH);
        }
    }




    static if(!is(typeof(GITERR_FILESYSTEM))) {
        private enum enumMixinStr_GITERR_FILESYSTEM = `enum GITERR_FILESYSTEM = GIT_ERROR_FILESYSTEM;`;
        static if(is(typeof({ mixin(enumMixinStr_GITERR_FILESYSTEM); }))) {
            mixin(enumMixinStr_GITERR_FILESYSTEM);
        }
    }




    static if(!is(typeof(GITERR_REBASE))) {
        private enum enumMixinStr_GITERR_REBASE = `enum GITERR_REBASE = GIT_ERROR_REBASE;`;
        static if(is(typeof({ mixin(enumMixinStr_GITERR_REBASE); }))) {
            mixin(enumMixinStr_GITERR_REBASE);
        }
    }




    static if(!is(typeof(GITERR_DESCRIBE))) {
        private enum enumMixinStr_GITERR_DESCRIBE = `enum GITERR_DESCRIBE = GIT_ERROR_DESCRIBE;`;
        static if(is(typeof({ mixin(enumMixinStr_GITERR_DESCRIBE); }))) {
            mixin(enumMixinStr_GITERR_DESCRIBE);
        }
    }




    static if(!is(typeof(GITERR_CHERRYPICK))) {
        private enum enumMixinStr_GITERR_CHERRYPICK = `enum GITERR_CHERRYPICK = GIT_ERROR_CHERRYPICK;`;
        static if(is(typeof({ mixin(enumMixinStr_GITERR_CHERRYPICK); }))) {
            mixin(enumMixinStr_GITERR_CHERRYPICK);
        }
    }




    static if(!is(typeof(GITERR_CALLBACK))) {
        private enum enumMixinStr_GITERR_CALLBACK = `enum GITERR_CALLBACK = GIT_ERROR_CALLBACK;`;
        static if(is(typeof({ mixin(enumMixinStr_GITERR_CALLBACK); }))) {
            mixin(enumMixinStr_GITERR_CALLBACK);
        }
    }




    static if(!is(typeof(GITERR_REVERT))) {
        private enum enumMixinStr_GITERR_REVERT = `enum GITERR_REVERT = GIT_ERROR_REVERT;`;
        static if(is(typeof({ mixin(enumMixinStr_GITERR_REVERT); }))) {
            mixin(enumMixinStr_GITERR_REVERT);
        }
    }




    static if(!is(typeof(GITERR_FILTER))) {
        private enum enumMixinStr_GITERR_FILTER = `enum GITERR_FILTER = GIT_ERROR_FILTER;`;
        static if(is(typeof({ mixin(enumMixinStr_GITERR_FILTER); }))) {
            mixin(enumMixinStr_GITERR_FILTER);
        }
    }




    static if(!is(typeof(GITERR_SSH))) {
        private enum enumMixinStr_GITERR_SSH = `enum GITERR_SSH = GIT_ERROR_SSH;`;
        static if(is(typeof({ mixin(enumMixinStr_GITERR_SSH); }))) {
            mixin(enumMixinStr_GITERR_SSH);
        }
    }




    static if(!is(typeof(GITERR_MERGE))) {
        private enum enumMixinStr_GITERR_MERGE = `enum GITERR_MERGE = GIT_ERROR_MERGE;`;
        static if(is(typeof({ mixin(enumMixinStr_GITERR_MERGE); }))) {
            mixin(enumMixinStr_GITERR_MERGE);
        }
    }




    static if(!is(typeof(GITERR_FETCHHEAD))) {
        private enum enumMixinStr_GITERR_FETCHHEAD = `enum GITERR_FETCHHEAD = GIT_ERROR_FETCHHEAD;`;
        static if(is(typeof({ mixin(enumMixinStr_GITERR_FETCHHEAD); }))) {
            mixin(enumMixinStr_GITERR_FETCHHEAD);
        }
    }




    static if(!is(typeof(GITERR_CHECKOUT))) {
        private enum enumMixinStr_GITERR_CHECKOUT = `enum GITERR_CHECKOUT = GIT_ERROR_CHECKOUT;`;
        static if(is(typeof({ mixin(enumMixinStr_GITERR_CHECKOUT); }))) {
            mixin(enumMixinStr_GITERR_CHECKOUT);
        }
    }




    static if(!is(typeof(GITERR_STASH))) {
        private enum enumMixinStr_GITERR_STASH = `enum GITERR_STASH = GIT_ERROR_STASH;`;
        static if(is(typeof({ mixin(enumMixinStr_GITERR_STASH); }))) {
            mixin(enumMixinStr_GITERR_STASH);
        }
    }




    static if(!is(typeof(GITERR_THREAD))) {
        private enum enumMixinStr_GITERR_THREAD = `enum GITERR_THREAD = GIT_ERROR_THREAD;`;
        static if(is(typeof({ mixin(enumMixinStr_GITERR_THREAD); }))) {
            mixin(enumMixinStr_GITERR_THREAD);
        }
    }




    static if(!is(typeof(GITERR_SUBMODULE))) {
        private enum enumMixinStr_GITERR_SUBMODULE = `enum GITERR_SUBMODULE = GIT_ERROR_SUBMODULE;`;
        static if(is(typeof({ mixin(enumMixinStr_GITERR_SUBMODULE); }))) {
            mixin(enumMixinStr_GITERR_SUBMODULE);
        }
    }




    static if(!is(typeof(GITERR_SSL))) {
        private enum enumMixinStr_GITERR_SSL = `enum GITERR_SSL = GIT_ERROR_SSL;`;
        static if(is(typeof({ mixin(enumMixinStr_GITERR_SSL); }))) {
            mixin(enumMixinStr_GITERR_SSL);
        }
    }




    static if(!is(typeof(GITERR_INDEXER))) {
        private enum enumMixinStr_GITERR_INDEXER = `enum GITERR_INDEXER = GIT_ERROR_INDEXER;`;
        static if(is(typeof({ mixin(enumMixinStr_GITERR_INDEXER); }))) {
            mixin(enumMixinStr_GITERR_INDEXER);
        }
    }




    static if(!is(typeof(GITERR_TREE))) {
        private enum enumMixinStr_GITERR_TREE = `enum GITERR_TREE = GIT_ERROR_TREE;`;
        static if(is(typeof({ mixin(enumMixinStr_GITERR_TREE); }))) {
            mixin(enumMixinStr_GITERR_TREE);
        }
    }




    static if(!is(typeof(GITERR_TAG))) {
        private enum enumMixinStr_GITERR_TAG = `enum GITERR_TAG = GIT_ERROR_TAG;`;
        static if(is(typeof({ mixin(enumMixinStr_GITERR_TAG); }))) {
            mixin(enumMixinStr_GITERR_TAG);
        }
    }




    static if(!is(typeof(GITERR_NET))) {
        private enum enumMixinStr_GITERR_NET = `enum GITERR_NET = GIT_ERROR_NET;`;
        static if(is(typeof({ mixin(enumMixinStr_GITERR_NET); }))) {
            mixin(enumMixinStr_GITERR_NET);
        }
    }




    static if(!is(typeof(GITERR_OBJECT))) {
        private enum enumMixinStr_GITERR_OBJECT = `enum GITERR_OBJECT = GIT_ERROR_OBJECT;`;
        static if(is(typeof({ mixin(enumMixinStr_GITERR_OBJECT); }))) {
            mixin(enumMixinStr_GITERR_OBJECT);
        }
    }






    static if(!is(typeof(GITERR_INDEX))) {
        private enum enumMixinStr_GITERR_INDEX = `enum GITERR_INDEX = GIT_ERROR_INDEX;`;
        static if(is(typeof({ mixin(enumMixinStr_GITERR_INDEX); }))) {
            mixin(enumMixinStr_GITERR_INDEX);
        }
    }




    static if(!is(typeof(GITERR_ODB))) {
        private enum enumMixinStr_GITERR_ODB = `enum GITERR_ODB = GIT_ERROR_ODB;`;
        static if(is(typeof({ mixin(enumMixinStr_GITERR_ODB); }))) {
            mixin(enumMixinStr_GITERR_ODB);
        }
    }




    static if(!is(typeof(GITERR_REGEX))) {
        private enum enumMixinStr_GITERR_REGEX = `enum GITERR_REGEX = GIT_ERROR_REGEX;`;
        static if(is(typeof({ mixin(enumMixinStr_GITERR_REGEX); }))) {
            mixin(enumMixinStr_GITERR_REGEX);
        }
    }




    static if(!is(typeof(GITERR_CONFIG))) {
        private enum enumMixinStr_GITERR_CONFIG = `enum GITERR_CONFIG = GIT_ERROR_CONFIG;`;
        static if(is(typeof({ mixin(enumMixinStr_GITERR_CONFIG); }))) {
            mixin(enumMixinStr_GITERR_CONFIG);
        }
    }
    static if(!is(typeof(INT8_MIN))) {
        private enum enumMixinStr_INT8_MIN = `enum INT8_MIN = ( - 128 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT8_MIN); }))) {
            mixin(enumMixinStr_INT8_MIN);
        }
    }




    static if(!is(typeof(INT16_MIN))) {
        private enum enumMixinStr_INT16_MIN = `enum INT16_MIN = ( - 32767 - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT16_MIN); }))) {
            mixin(enumMixinStr_INT16_MIN);
        }
    }




    static if(!is(typeof(INT32_MIN))) {
        private enum enumMixinStr_INT32_MIN = `enum INT32_MIN = ( - 2147483647 - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT32_MIN); }))) {
            mixin(enumMixinStr_INT32_MIN);
        }
    }




    static if(!is(typeof(INT64_MIN))) {
        private enum enumMixinStr_INT64_MIN = `enum INT64_MIN = ( - 9223372036854775807L - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT64_MIN); }))) {
            mixin(enumMixinStr_INT64_MIN);
        }
    }




    static if(!is(typeof(INT8_MAX))) {
        private enum enumMixinStr_INT8_MAX = `enum INT8_MAX = ( 127 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT8_MAX); }))) {
            mixin(enumMixinStr_INT8_MAX);
        }
    }




    static if(!is(typeof(INT16_MAX))) {
        private enum enumMixinStr_INT16_MAX = `enum INT16_MAX = ( 32767 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT16_MAX); }))) {
            mixin(enumMixinStr_INT16_MAX);
        }
    }




    static if(!is(typeof(INT32_MAX))) {
        private enum enumMixinStr_INT32_MAX = `enum INT32_MAX = ( 2147483647 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT32_MAX); }))) {
            mixin(enumMixinStr_INT32_MAX);
        }
    }




    static if(!is(typeof(INT64_MAX))) {
        private enum enumMixinStr_INT64_MAX = `enum INT64_MAX = ( 9223372036854775807L );`;
        static if(is(typeof({ mixin(enumMixinStr_INT64_MAX); }))) {
            mixin(enumMixinStr_INT64_MAX);
        }
    }




    static if(!is(typeof(UINT8_MAX))) {
        private enum enumMixinStr_UINT8_MAX = `enum UINT8_MAX = ( 255 );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT8_MAX); }))) {
            mixin(enumMixinStr_UINT8_MAX);
        }
    }




    static if(!is(typeof(UINT16_MAX))) {
        private enum enumMixinStr_UINT16_MAX = `enum UINT16_MAX = ( 65535 );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT16_MAX); }))) {
            mixin(enumMixinStr_UINT16_MAX);
        }
    }




    static if(!is(typeof(UINT32_MAX))) {
        private enum enumMixinStr_UINT32_MAX = `enum UINT32_MAX = ( 4294967295U );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT32_MAX); }))) {
            mixin(enumMixinStr_UINT32_MAX);
        }
    }




    static if(!is(typeof(UINT64_MAX))) {
        private enum enumMixinStr_UINT64_MAX = `enum UINT64_MAX = ( 18446744073709551615UL );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT64_MAX); }))) {
            mixin(enumMixinStr_UINT64_MAX);
        }
    }




    static if(!is(typeof(INT_LEAST8_MIN))) {
        private enum enumMixinStr_INT_LEAST8_MIN = `enum INT_LEAST8_MIN = ( - 128 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST8_MIN); }))) {
            mixin(enumMixinStr_INT_LEAST8_MIN);
        }
    }




    static if(!is(typeof(INT_LEAST16_MIN))) {
        private enum enumMixinStr_INT_LEAST16_MIN = `enum INT_LEAST16_MIN = ( - 32767 - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST16_MIN); }))) {
            mixin(enumMixinStr_INT_LEAST16_MIN);
        }
    }




    static if(!is(typeof(INT_LEAST32_MIN))) {
        private enum enumMixinStr_INT_LEAST32_MIN = `enum INT_LEAST32_MIN = ( - 2147483647 - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST32_MIN); }))) {
            mixin(enumMixinStr_INT_LEAST32_MIN);
        }
    }




    static if(!is(typeof(INT_LEAST64_MIN))) {
        private enum enumMixinStr_INT_LEAST64_MIN = `enum INT_LEAST64_MIN = ( - 9223372036854775807L - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST64_MIN); }))) {
            mixin(enumMixinStr_INT_LEAST64_MIN);
        }
    }




    static if(!is(typeof(INT_LEAST8_MAX))) {
        private enum enumMixinStr_INT_LEAST8_MAX = `enum INT_LEAST8_MAX = ( 127 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST8_MAX); }))) {
            mixin(enumMixinStr_INT_LEAST8_MAX);
        }
    }




    static if(!is(typeof(INT_LEAST16_MAX))) {
        private enum enumMixinStr_INT_LEAST16_MAX = `enum INT_LEAST16_MAX = ( 32767 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST16_MAX); }))) {
            mixin(enumMixinStr_INT_LEAST16_MAX);
        }
    }




    static if(!is(typeof(INT_LEAST32_MAX))) {
        private enum enumMixinStr_INT_LEAST32_MAX = `enum INT_LEAST32_MAX = ( 2147483647 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST32_MAX); }))) {
            mixin(enumMixinStr_INT_LEAST32_MAX);
        }
    }




    static if(!is(typeof(INT_LEAST64_MAX))) {
        private enum enumMixinStr_INT_LEAST64_MAX = `enum INT_LEAST64_MAX = ( 9223372036854775807L );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_LEAST64_MAX); }))) {
            mixin(enumMixinStr_INT_LEAST64_MAX);
        }
    }




    static if(!is(typeof(UINT_LEAST8_MAX))) {
        private enum enumMixinStr_UINT_LEAST8_MAX = `enum UINT_LEAST8_MAX = ( 255 );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_LEAST8_MAX); }))) {
            mixin(enumMixinStr_UINT_LEAST8_MAX);
        }
    }




    static if(!is(typeof(UINT_LEAST16_MAX))) {
        private enum enumMixinStr_UINT_LEAST16_MAX = `enum UINT_LEAST16_MAX = ( 65535 );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_LEAST16_MAX); }))) {
            mixin(enumMixinStr_UINT_LEAST16_MAX);
        }
    }




    static if(!is(typeof(UINT_LEAST32_MAX))) {
        private enum enumMixinStr_UINT_LEAST32_MAX = `enum UINT_LEAST32_MAX = ( 4294967295U );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_LEAST32_MAX); }))) {
            mixin(enumMixinStr_UINT_LEAST32_MAX);
        }
    }




    static if(!is(typeof(UINT_LEAST64_MAX))) {
        private enum enumMixinStr_UINT_LEAST64_MAX = `enum UINT_LEAST64_MAX = ( 18446744073709551615UL );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_LEAST64_MAX); }))) {
            mixin(enumMixinStr_UINT_LEAST64_MAX);
        }
    }




    static if(!is(typeof(INT_FAST8_MIN))) {
        private enum enumMixinStr_INT_FAST8_MIN = `enum INT_FAST8_MIN = ( - 128 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST8_MIN); }))) {
            mixin(enumMixinStr_INT_FAST8_MIN);
        }
    }




    static if(!is(typeof(GITERR_REPOSITORY))) {
        private enum enumMixinStr_GITERR_REPOSITORY = `enum GITERR_REPOSITORY = GIT_ERROR_REPOSITORY;`;
        static if(is(typeof({ mixin(enumMixinStr_GITERR_REPOSITORY); }))) {
            mixin(enumMixinStr_GITERR_REPOSITORY);
        }
    }




    static if(!is(typeof(INT_FAST16_MIN))) {
        private enum enumMixinStr_INT_FAST16_MIN = `enum INT_FAST16_MIN = ( - 9223372036854775807L - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST16_MIN); }))) {
            mixin(enumMixinStr_INT_FAST16_MIN);
        }
    }




    static if(!is(typeof(INT_FAST32_MIN))) {
        private enum enumMixinStr_INT_FAST32_MIN = `enum INT_FAST32_MIN = ( - 9223372036854775807L - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST32_MIN); }))) {
            mixin(enumMixinStr_INT_FAST32_MIN);
        }
    }




    static if(!is(typeof(INT_FAST64_MIN))) {
        private enum enumMixinStr_INT_FAST64_MIN = `enum INT_FAST64_MIN = ( - 9223372036854775807L - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST64_MIN); }))) {
            mixin(enumMixinStr_INT_FAST64_MIN);
        }
    }




    static if(!is(typeof(INT_FAST8_MAX))) {
        private enum enumMixinStr_INT_FAST8_MAX = `enum INT_FAST8_MAX = ( 127 );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST8_MAX); }))) {
            mixin(enumMixinStr_INT_FAST8_MAX);
        }
    }




    static if(!is(typeof(GITERR_ZLIB))) {
        private enum enumMixinStr_GITERR_ZLIB = `enum GITERR_ZLIB = GIT_ERROR_ZLIB;`;
        static if(is(typeof({ mixin(enumMixinStr_GITERR_ZLIB); }))) {
            mixin(enumMixinStr_GITERR_ZLIB);
        }
    }




    static if(!is(typeof(INT_FAST16_MAX))) {
        private enum enumMixinStr_INT_FAST16_MAX = `enum INT_FAST16_MAX = ( 9223372036854775807L );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST16_MAX); }))) {
            mixin(enumMixinStr_INT_FAST16_MAX);
        }
    }




    static if(!is(typeof(INT_FAST32_MAX))) {
        private enum enumMixinStr_INT_FAST32_MAX = `enum INT_FAST32_MAX = ( 9223372036854775807L );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST32_MAX); }))) {
            mixin(enumMixinStr_INT_FAST32_MAX);
        }
    }




    static if(!is(typeof(INT_FAST64_MAX))) {
        private enum enumMixinStr_INT_FAST64_MAX = `enum INT_FAST64_MAX = ( 9223372036854775807L );`;
        static if(is(typeof({ mixin(enumMixinStr_INT_FAST64_MAX); }))) {
            mixin(enumMixinStr_INT_FAST64_MAX);
        }
    }




    static if(!is(typeof(UINT_FAST8_MAX))) {
        private enum enumMixinStr_UINT_FAST8_MAX = `enum UINT_FAST8_MAX = ( 255 );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_FAST8_MAX); }))) {
            mixin(enumMixinStr_UINT_FAST8_MAX);
        }
    }




    static if(!is(typeof(GITERR_REFERENCE))) {
        private enum enumMixinStr_GITERR_REFERENCE = `enum GITERR_REFERENCE = GIT_ERROR_REFERENCE;`;
        static if(is(typeof({ mixin(enumMixinStr_GITERR_REFERENCE); }))) {
            mixin(enumMixinStr_GITERR_REFERENCE);
        }
    }




    static if(!is(typeof(UINT_FAST16_MAX))) {
        private enum enumMixinStr_UINT_FAST16_MAX = `enum UINT_FAST16_MAX = ( 18446744073709551615UL );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_FAST16_MAX); }))) {
            mixin(enumMixinStr_UINT_FAST16_MAX);
        }
    }




    static if(!is(typeof(UINT_FAST32_MAX))) {
        private enum enumMixinStr_UINT_FAST32_MAX = `enum UINT_FAST32_MAX = ( 18446744073709551615UL );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_FAST32_MAX); }))) {
            mixin(enumMixinStr_UINT_FAST32_MAX);
        }
    }




    static if(!is(typeof(UINT_FAST64_MAX))) {
        private enum enumMixinStr_UINT_FAST64_MAX = `enum UINT_FAST64_MAX = ( 18446744073709551615UL );`;
        static if(is(typeof({ mixin(enumMixinStr_UINT_FAST64_MAX); }))) {
            mixin(enumMixinStr_UINT_FAST64_MAX);
        }
    }




    static if(!is(typeof(GITERR_INVALID))) {
        private enum enumMixinStr_GITERR_INVALID = `enum GITERR_INVALID = GIT_ERROR_INVALID;`;
        static if(is(typeof({ mixin(enumMixinStr_GITERR_INVALID); }))) {
            mixin(enumMixinStr_GITERR_INVALID);
        }
    }




    static if(!is(typeof(INTPTR_MIN))) {
        private enum enumMixinStr_INTPTR_MIN = `enum INTPTR_MIN = ( - 9223372036854775807L - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INTPTR_MIN); }))) {
            mixin(enumMixinStr_INTPTR_MIN);
        }
    }




    static if(!is(typeof(INTPTR_MAX))) {
        private enum enumMixinStr_INTPTR_MAX = `enum INTPTR_MAX = ( 9223372036854775807L );`;
        static if(is(typeof({ mixin(enumMixinStr_INTPTR_MAX); }))) {
            mixin(enumMixinStr_INTPTR_MAX);
        }
    }




    static if(!is(typeof(UINTPTR_MAX))) {
        private enum enumMixinStr_UINTPTR_MAX = `enum UINTPTR_MAX = ( 18446744073709551615UL );`;
        static if(is(typeof({ mixin(enumMixinStr_UINTPTR_MAX); }))) {
            mixin(enumMixinStr_UINTPTR_MAX);
        }
    }




    static if(!is(typeof(INTMAX_MIN))) {
        private enum enumMixinStr_INTMAX_MIN = `enum INTMAX_MIN = ( - 9223372036854775807L - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_INTMAX_MIN); }))) {
            mixin(enumMixinStr_INTMAX_MIN);
        }
    }




    static if(!is(typeof(INTMAX_MAX))) {
        private enum enumMixinStr_INTMAX_MAX = `enum INTMAX_MAX = ( 9223372036854775807L );`;
        static if(is(typeof({ mixin(enumMixinStr_INTMAX_MAX); }))) {
            mixin(enumMixinStr_INTMAX_MAX);
        }
    }




    static if(!is(typeof(UINTMAX_MAX))) {
        private enum enumMixinStr_UINTMAX_MAX = `enum UINTMAX_MAX = ( 18446744073709551615UL );`;
        static if(is(typeof({ mixin(enumMixinStr_UINTMAX_MAX); }))) {
            mixin(enumMixinStr_UINTMAX_MAX);
        }
    }




    static if(!is(typeof(GITERR_OS))) {
        private enum enumMixinStr_GITERR_OS = `enum GITERR_OS = GIT_ERROR_OS;`;
        static if(is(typeof({ mixin(enumMixinStr_GITERR_OS); }))) {
            mixin(enumMixinStr_GITERR_OS);
        }
    }




    static if(!is(typeof(PTRDIFF_MIN))) {
        private enum enumMixinStr_PTRDIFF_MIN = `enum PTRDIFF_MIN = ( - 9223372036854775807L - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_PTRDIFF_MIN); }))) {
            mixin(enumMixinStr_PTRDIFF_MIN);
        }
    }




    static if(!is(typeof(PTRDIFF_MAX))) {
        private enum enumMixinStr_PTRDIFF_MAX = `enum PTRDIFF_MAX = ( 9223372036854775807L );`;
        static if(is(typeof({ mixin(enumMixinStr_PTRDIFF_MAX); }))) {
            mixin(enumMixinStr_PTRDIFF_MAX);
        }
    }




    static if(!is(typeof(SIG_ATOMIC_MIN))) {
        private enum enumMixinStr_SIG_ATOMIC_MIN = `enum SIG_ATOMIC_MIN = ( - 2147483647 - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr_SIG_ATOMIC_MIN); }))) {
            mixin(enumMixinStr_SIG_ATOMIC_MIN);
        }
    }




    static if(!is(typeof(SIG_ATOMIC_MAX))) {
        private enum enumMixinStr_SIG_ATOMIC_MAX = `enum SIG_ATOMIC_MAX = ( 2147483647 );`;
        static if(is(typeof({ mixin(enumMixinStr_SIG_ATOMIC_MAX); }))) {
            mixin(enumMixinStr_SIG_ATOMIC_MAX);
        }
    }




    static if(!is(typeof(GITERR_NOMEMORY))) {
        private enum enumMixinStr_GITERR_NOMEMORY = `enum GITERR_NOMEMORY = GIT_ERROR_NOMEMORY;`;
        static if(is(typeof({ mixin(enumMixinStr_GITERR_NOMEMORY); }))) {
            mixin(enumMixinStr_GITERR_NOMEMORY);
        }
    }




    static if(!is(typeof(SIZE_MAX))) {
        private enum enumMixinStr_SIZE_MAX = `enum SIZE_MAX = ( 18446744073709551615UL );`;
        static if(is(typeof({ mixin(enumMixinStr_SIZE_MAX); }))) {
            mixin(enumMixinStr_SIZE_MAX);
        }
    }




    static if(!is(typeof(WCHAR_MIN))) {
        private enum enumMixinStr_WCHAR_MIN = `enum WCHAR_MIN = __WCHAR_MIN;`;
        static if(is(typeof({ mixin(enumMixinStr_WCHAR_MIN); }))) {
            mixin(enumMixinStr_WCHAR_MIN);
        }
    }




    static if(!is(typeof(WCHAR_MAX))) {
        private enum enumMixinStr_WCHAR_MAX = `enum WCHAR_MAX = __WCHAR_MAX;`;
        static if(is(typeof({ mixin(enumMixinStr_WCHAR_MAX); }))) {
            mixin(enumMixinStr_WCHAR_MAX);
        }
    }




    static if(!is(typeof(WINT_MIN))) {
        private enum enumMixinStr_WINT_MIN = `enum WINT_MIN = ( 0u );`;
        static if(is(typeof({ mixin(enumMixinStr_WINT_MIN); }))) {
            mixin(enumMixinStr_WINT_MIN);
        }
    }




    static if(!is(typeof(WINT_MAX))) {
        private enum enumMixinStr_WINT_MAX = `enum WINT_MAX = ( 4294967295u );`;
        static if(is(typeof({ mixin(enumMixinStr_WINT_MAX); }))) {
            mixin(enumMixinStr_WINT_MAX);
        }
    }
    static if(!is(typeof(GITERR_NONE))) {
        private enum enumMixinStr_GITERR_NONE = `enum GITERR_NONE = GIT_ERROR_NONE;`;
        static if(is(typeof({ mixin(enumMixinStr_GITERR_NONE); }))) {
            mixin(enumMixinStr_GITERR_NONE);
        }
    }
    static if(!is(typeof(GIT_CVAR_STRING))) {
        private enum enumMixinStr_GIT_CVAR_STRING = `enum GIT_CVAR_STRING = GIT_CONFIGMAP_STRING;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_CVAR_STRING); }))) {
            mixin(enumMixinStr_GIT_CVAR_STRING);
        }
    }






    static if(!is(typeof(GIT_CVAR_INT32))) {
        private enum enumMixinStr_GIT_CVAR_INT32 = `enum GIT_CVAR_INT32 = GIT_CONFIGMAP_INT32;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_CVAR_INT32); }))) {
            mixin(enumMixinStr_GIT_CVAR_INT32);
        }
    }
    static if(!is(typeof(GIT_CVAR_TRUE))) {
        private enum enumMixinStr_GIT_CVAR_TRUE = `enum GIT_CVAR_TRUE = GIT_CONFIGMAP_TRUE;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_CVAR_TRUE); }))) {
            mixin(enumMixinStr_GIT_CVAR_TRUE);
        }
    }




    static if(!is(typeof(GIT_CVAR_FALSE))) {
        private enum enumMixinStr_GIT_CVAR_FALSE = `enum GIT_CVAR_FALSE = GIT_CONFIGMAP_FALSE;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_CVAR_FALSE); }))) {
            mixin(enumMixinStr_GIT_CVAR_FALSE);
        }
    }
    static if(!is(typeof(_STDLIB_H))) {
        private enum enumMixinStr__STDLIB_H = `enum _STDLIB_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__STDLIB_H); }))) {
            mixin(enumMixinStr__STDLIB_H);
        }
    }






    static if(!is(typeof(GIT_ATTR_VALUE_T))) {
        private enum enumMixinStr_GIT_ATTR_VALUE_T = `enum GIT_ATTR_VALUE_T = GIT_ATTR_VALUE_STRING;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_ATTR_VALUE_T); }))) {
            mixin(enumMixinStr_GIT_ATTR_VALUE_T);
        }
    }




    static if(!is(typeof(GIT_ATTR_FALSE_T))) {
        private enum enumMixinStr_GIT_ATTR_FALSE_T = `enum GIT_ATTR_FALSE_T = GIT_ATTR_VALUE_FALSE;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_ATTR_FALSE_T); }))) {
            mixin(enumMixinStr_GIT_ATTR_FALSE_T);
        }
    }
    static if(!is(typeof(GIT_ATTR_TRUE_T))) {
        private enum enumMixinStr_GIT_ATTR_TRUE_T = `enum GIT_ATTR_TRUE_T = GIT_ATTR_VALUE_TRUE;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_ATTR_TRUE_T); }))) {
            mixin(enumMixinStr_GIT_ATTR_TRUE_T);
        }
    }






    static if(!is(typeof(GIT_ATTR_UNSPECIFIED_T))) {
        private enum enumMixinStr_GIT_ATTR_UNSPECIFIED_T = `enum GIT_ATTR_UNSPECIFIED_T = GIT_ATTR_VALUE_UNSPECIFIED;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_ATTR_UNSPECIFIED_T); }))) {
            mixin(enumMixinStr_GIT_ATTR_UNSPECIFIED_T);
        }
    }
    static if(!is(typeof(__ldiv_t_defined))) {
        private enum enumMixinStr___ldiv_t_defined = `enum __ldiv_t_defined = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___ldiv_t_defined); }))) {
            mixin(enumMixinStr___ldiv_t_defined);
        }
    }




    static if(!is(typeof(GIT_OID_HEX_ZERO))) {
        private enum enumMixinStr_GIT_OID_HEX_ZERO = `enum GIT_OID_HEX_ZERO = "0000000000000000000000000000000000000000";`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_OID_HEX_ZERO); }))) {
            mixin(enumMixinStr_GIT_OID_HEX_ZERO);
        }
    }




    static if(!is(typeof(GIT_PATH_MAX))) {
        private enum enumMixinStr_GIT_PATH_MAX = `enum GIT_PATH_MAX = 4096;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_PATH_MAX); }))) {
            mixin(enumMixinStr_GIT_PATH_MAX);
        }
    }




    static if(!is(typeof(GIT_PATH_LIST_SEPARATOR))) {
        private enum enumMixinStr_GIT_PATH_LIST_SEPARATOR = `enum GIT_PATH_LIST_SEPARATOR = ':';`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_PATH_LIST_SEPARATOR); }))) {
            mixin(enumMixinStr_GIT_PATH_LIST_SEPARATOR);
        }
    }




    static if(!is(typeof(__lldiv_t_defined))) {
        private enum enumMixinStr___lldiv_t_defined = `enum __lldiv_t_defined = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___lldiv_t_defined); }))) {
            mixin(enumMixinStr___lldiv_t_defined);
        }
    }




    static if(!is(typeof(RAND_MAX))) {
        private enum enumMixinStr_RAND_MAX = `enum RAND_MAX = 2147483647;`;
        static if(is(typeof({ mixin(enumMixinStr_RAND_MAX); }))) {
            mixin(enumMixinStr_RAND_MAX);
        }
    }




    static if(!is(typeof(EXIT_FAILURE))) {
        private enum enumMixinStr_EXIT_FAILURE = `enum EXIT_FAILURE = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_EXIT_FAILURE); }))) {
            mixin(enumMixinStr_EXIT_FAILURE);
        }
    }




    static if(!is(typeof(EXIT_SUCCESS))) {
        private enum enumMixinStr_EXIT_SUCCESS = `enum EXIT_SUCCESS = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_EXIT_SUCCESS); }))) {
            mixin(enumMixinStr_EXIT_SUCCESS);
        }
    }




    static if(!is(typeof(MB_CUR_MAX))) {
        private enum enumMixinStr_MB_CUR_MAX = `enum MB_CUR_MAX = ( __ctype_get_mb_cur_max ( ) );`;
        static if(is(typeof({ mixin(enumMixinStr_MB_CUR_MAX); }))) {
            mixin(enumMixinStr_MB_CUR_MAX);
        }
    }
    static if(!is(typeof(GIT_CLONE_OPTIONS_INIT))) {
        private enum enumMixinStr_GIT_CLONE_OPTIONS_INIT = `enum GIT_CLONE_OPTIONS_INIT = { GIT_CLONE_OPTIONS_VERSION , { GIT_CHECKOUT_OPTIONS_VERSION , GIT_CHECKOUT_SAFE } , { 1 , { 1 } , GIT_FETCH_PRUNE_UNSPECIFIED , 1 , GIT_REMOTE_DOWNLOAD_TAGS_UNSPECIFIED , { 1 } } };`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_CLONE_OPTIONS_INIT); }))) {
            mixin(enumMixinStr_GIT_CLONE_OPTIONS_INIT);
        }
    }




    static if(!is(typeof(GIT_CLONE_OPTIONS_VERSION))) {
        private enum enumMixinStr_GIT_CLONE_OPTIONS_VERSION = `enum GIT_CLONE_OPTIONS_VERSION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_CLONE_OPTIONS_VERSION); }))) {
            mixin(enumMixinStr_GIT_CLONE_OPTIONS_VERSION);
        }
    }






    static if(!is(typeof(GIT_CHERRYPICK_OPTIONS_INIT))) {
        private enum enumMixinStr_GIT_CHERRYPICK_OPTIONS_INIT = `enum GIT_CHERRYPICK_OPTIONS_INIT = { GIT_CHERRYPICK_OPTIONS_VERSION , 0 , { 1 , GIT_MERGE_FIND_RENAMES } , GIT_CHECKOUT_OPTIONS_INIT };`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_CHERRYPICK_OPTIONS_INIT); }))) {
            mixin(enumMixinStr_GIT_CHERRYPICK_OPTIONS_INIT);
        }
    }




    static if(!is(typeof(GIT_CHERRYPICK_OPTIONS_VERSION))) {
        private enum enumMixinStr_GIT_CHERRYPICK_OPTIONS_VERSION = `enum GIT_CHERRYPICK_OPTIONS_VERSION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_CHERRYPICK_OPTIONS_VERSION); }))) {
            mixin(enumMixinStr_GIT_CHERRYPICK_OPTIONS_VERSION);
        }
    }






    static if(!is(typeof(GIT_CHECKOUT_OPTIONS_INIT))) {
        private enum enumMixinStr_GIT_CHECKOUT_OPTIONS_INIT = `enum GIT_CHECKOUT_OPTIONS_INIT = { GIT_CHECKOUT_OPTIONS_VERSION , GIT_CHECKOUT_SAFE };`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_CHECKOUT_OPTIONS_INIT); }))) {
            mixin(enumMixinStr_GIT_CHECKOUT_OPTIONS_INIT);
        }
    }




    static if(!is(typeof(GIT_CHECKOUT_OPTIONS_VERSION))) {
        private enum enumMixinStr_GIT_CHECKOUT_OPTIONS_VERSION = `enum GIT_CHECKOUT_OPTIONS_VERSION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_CHECKOUT_OPTIONS_VERSION); }))) {
            mixin(enumMixinStr_GIT_CHECKOUT_OPTIONS_VERSION);
        }
    }
    static if(!is(typeof(GIT_BLOB_FILTER_OPTIONS_INIT))) {
        private enum enumMixinStr_GIT_BLOB_FILTER_OPTIONS_INIT = `enum GIT_BLOB_FILTER_OPTIONS_INIT = { GIT_BLOB_FILTER_OPTIONS_VERSION , GIT_BLOB_FILTER_CHECK_FOR_BINARY };`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_BLOB_FILTER_OPTIONS_INIT); }))) {
            mixin(enumMixinStr_GIT_BLOB_FILTER_OPTIONS_INIT);
        }
    }




    static if(!is(typeof(GIT_BLOB_FILTER_OPTIONS_VERSION))) {
        private enum enumMixinStr_GIT_BLOB_FILTER_OPTIONS_VERSION = `enum GIT_BLOB_FILTER_OPTIONS_VERSION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_BLOB_FILTER_OPTIONS_VERSION); }))) {
            mixin(enumMixinStr_GIT_BLOB_FILTER_OPTIONS_VERSION);
        }
    }






    static if(!is(typeof(GIT_BLAME_OPTIONS_INIT))) {
        private enum enumMixinStr_GIT_BLAME_OPTIONS_INIT = `enum GIT_BLAME_OPTIONS_INIT = { GIT_BLAME_OPTIONS_VERSION };`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_BLAME_OPTIONS_INIT); }))) {
            mixin(enumMixinStr_GIT_BLAME_OPTIONS_INIT);
        }
    }




    static if(!is(typeof(GIT_BLAME_OPTIONS_VERSION))) {
        private enum enumMixinStr_GIT_BLAME_OPTIONS_VERSION = `enum GIT_BLAME_OPTIONS_VERSION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_BLAME_OPTIONS_VERSION); }))) {
            mixin(enumMixinStr_GIT_BLAME_OPTIONS_VERSION);
        }
    }






    static if(!is(typeof(GIT_ATTR_CHECK_INCLUDE_HEAD))) {
        private enum enumMixinStr_GIT_ATTR_CHECK_INCLUDE_HEAD = `enum GIT_ATTR_CHECK_INCLUDE_HEAD = ( 1 << 3 );`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_ATTR_CHECK_INCLUDE_HEAD); }))) {
            mixin(enumMixinStr_GIT_ATTR_CHECK_INCLUDE_HEAD);
        }
    }




    static if(!is(typeof(GIT_ATTR_CHECK_NO_SYSTEM))) {
        private enum enumMixinStr_GIT_ATTR_CHECK_NO_SYSTEM = `enum GIT_ATTR_CHECK_NO_SYSTEM = ( 1 << 2 );`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_ATTR_CHECK_NO_SYSTEM); }))) {
            mixin(enumMixinStr_GIT_ATTR_CHECK_NO_SYSTEM);
        }
    }




    static if(!is(typeof(GIT_ATTR_CHECK_INDEX_ONLY))) {
        private enum enumMixinStr_GIT_ATTR_CHECK_INDEX_ONLY = `enum GIT_ATTR_CHECK_INDEX_ONLY = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_ATTR_CHECK_INDEX_ONLY); }))) {
            mixin(enumMixinStr_GIT_ATTR_CHECK_INDEX_ONLY);
        }
    }




    static if(!is(typeof(GIT_ATTR_CHECK_INDEX_THEN_FILE))) {
        private enum enumMixinStr_GIT_ATTR_CHECK_INDEX_THEN_FILE = `enum GIT_ATTR_CHECK_INDEX_THEN_FILE = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_ATTR_CHECK_INDEX_THEN_FILE); }))) {
            mixin(enumMixinStr_GIT_ATTR_CHECK_INDEX_THEN_FILE);
        }
    }




    static if(!is(typeof(GIT_ATTR_CHECK_FILE_THEN_INDEX))) {
        private enum enumMixinStr_GIT_ATTR_CHECK_FILE_THEN_INDEX = `enum GIT_ATTR_CHECK_FILE_THEN_INDEX = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_ATTR_CHECK_FILE_THEN_INDEX); }))) {
            mixin(enumMixinStr_GIT_ATTR_CHECK_FILE_THEN_INDEX);
        }
    }
    static if(!is(typeof(GIT_APPLY_OPTIONS_INIT))) {
        private enum enumMixinStr_GIT_APPLY_OPTIONS_INIT = `enum GIT_APPLY_OPTIONS_INIT = { GIT_APPLY_OPTIONS_VERSION };`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_APPLY_OPTIONS_INIT); }))) {
            mixin(enumMixinStr_GIT_APPLY_OPTIONS_INIT);
        }
    }




    static if(!is(typeof(GIT_APPLY_OPTIONS_VERSION))) {
        private enum enumMixinStr_GIT_APPLY_OPTIONS_VERSION = `enum GIT_APPLY_OPTIONS_VERSION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_GIT_APPLY_OPTIONS_VERSION); }))) {
            mixin(enumMixinStr_GIT_APPLY_OPTIONS_VERSION);
        }
    }
    static if(!is(typeof(__GLIBC_MINOR__))) {
        private enum enumMixinStr___GLIBC_MINOR__ = `enum __GLIBC_MINOR__ = 32;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_MINOR__); }))) {
            mixin(enumMixinStr___GLIBC_MINOR__);
        }
    }




    static if(!is(typeof(__GLIBC__))) {
        private enum enumMixinStr___GLIBC__ = `enum __GLIBC__ = 2;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC__); }))) {
            mixin(enumMixinStr___GLIBC__);
        }
    }




    static if(!is(typeof(__GNU_LIBRARY__))) {
        private enum enumMixinStr___GNU_LIBRARY__ = `enum __GNU_LIBRARY__ = 6;`;
        static if(is(typeof({ mixin(enumMixinStr___GNU_LIBRARY__); }))) {
            mixin(enumMixinStr___GNU_LIBRARY__);
        }
    }




    static if(!is(typeof(__GLIBC_USE_DEPRECATED_SCANF))) {
        private enum enumMixinStr___GLIBC_USE_DEPRECATED_SCANF = `enum __GLIBC_USE_DEPRECATED_SCANF = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_DEPRECATED_SCANF); }))) {
            mixin(enumMixinStr___GLIBC_USE_DEPRECATED_SCANF);
        }
    }




    static if(!is(typeof(__GLIBC_USE_DEPRECATED_GETS))) {
        private enum enumMixinStr___GLIBC_USE_DEPRECATED_GETS = `enum __GLIBC_USE_DEPRECATED_GETS = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_DEPRECATED_GETS); }))) {
            mixin(enumMixinStr___GLIBC_USE_DEPRECATED_GETS);
        }
    }




    static if(!is(typeof(__USE_FORTIFY_LEVEL))) {
        private enum enumMixinStr___USE_FORTIFY_LEVEL = `enum __USE_FORTIFY_LEVEL = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_FORTIFY_LEVEL); }))) {
            mixin(enumMixinStr___USE_FORTIFY_LEVEL);
        }
    }




    static if(!is(typeof(__USE_ATFILE))) {
        private enum enumMixinStr___USE_ATFILE = `enum __USE_ATFILE = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_ATFILE); }))) {
            mixin(enumMixinStr___USE_ATFILE);
        }
    }




    static if(!is(typeof(__USE_MISC))) {
        private enum enumMixinStr___USE_MISC = `enum __USE_MISC = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_MISC); }))) {
            mixin(enumMixinStr___USE_MISC);
        }
    }




    static if(!is(typeof(_ATFILE_SOURCE))) {
        private enum enumMixinStr__ATFILE_SOURCE = `enum _ATFILE_SOURCE = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__ATFILE_SOURCE); }))) {
            mixin(enumMixinStr__ATFILE_SOURCE);
        }
    }




    static if(!is(typeof(__USE_XOPEN2K8))) {
        private enum enumMixinStr___USE_XOPEN2K8 = `enum __USE_XOPEN2K8 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_XOPEN2K8); }))) {
            mixin(enumMixinStr___USE_XOPEN2K8);
        }
    }




    static if(!is(typeof(__USE_ISOC99))) {
        private enum enumMixinStr___USE_ISOC99 = `enum __USE_ISOC99 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_ISOC99); }))) {
            mixin(enumMixinStr___USE_ISOC99);
        }
    }




    static if(!is(typeof(__USE_ISOC95))) {
        private enum enumMixinStr___USE_ISOC95 = `enum __USE_ISOC95 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_ISOC95); }))) {
            mixin(enumMixinStr___USE_ISOC95);
        }
    }




    static if(!is(typeof(__USE_XOPEN2K))) {
        private enum enumMixinStr___USE_XOPEN2K = `enum __USE_XOPEN2K = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_XOPEN2K); }))) {
            mixin(enumMixinStr___USE_XOPEN2K);
        }
    }




    static if(!is(typeof(__USE_POSIX199506))) {
        private enum enumMixinStr___USE_POSIX199506 = `enum __USE_POSIX199506 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_POSIX199506); }))) {
            mixin(enumMixinStr___USE_POSIX199506);
        }
    }




    static if(!is(typeof(__USE_POSIX199309))) {
        private enum enumMixinStr___USE_POSIX199309 = `enum __USE_POSIX199309 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_POSIX199309); }))) {
            mixin(enumMixinStr___USE_POSIX199309);
        }
    }




    static if(!is(typeof(__USE_POSIX2))) {
        private enum enumMixinStr___USE_POSIX2 = `enum __USE_POSIX2 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_POSIX2); }))) {
            mixin(enumMixinStr___USE_POSIX2);
        }
    }




    static if(!is(typeof(__USE_POSIX))) {
        private enum enumMixinStr___USE_POSIX = `enum __USE_POSIX = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_POSIX); }))) {
            mixin(enumMixinStr___USE_POSIX);
        }
    }




    static if(!is(typeof(_POSIX_C_SOURCE))) {
        private enum enumMixinStr__POSIX_C_SOURCE = `enum _POSIX_C_SOURCE = 200809L;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_C_SOURCE); }))) {
            mixin(enumMixinStr__POSIX_C_SOURCE);
        }
    }




    static if(!is(typeof(_POSIX_SOURCE))) {
        private enum enumMixinStr__POSIX_SOURCE = `enum _POSIX_SOURCE = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__POSIX_SOURCE); }))) {
            mixin(enumMixinStr__POSIX_SOURCE);
        }
    }




    static if(!is(typeof(__USE_POSIX_IMPLICITLY))) {
        private enum enumMixinStr___USE_POSIX_IMPLICITLY = `enum __USE_POSIX_IMPLICITLY = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_POSIX_IMPLICITLY); }))) {
            mixin(enumMixinStr___USE_POSIX_IMPLICITLY);
        }
    }




    static if(!is(typeof(__USE_ISOC11))) {
        private enum enumMixinStr___USE_ISOC11 = `enum __USE_ISOC11 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___USE_ISOC11); }))) {
            mixin(enumMixinStr___USE_ISOC11);
        }
    }




    static if(!is(typeof(__GLIBC_USE_ISOC2X))) {
        private enum enumMixinStr___GLIBC_USE_ISOC2X = `enum __GLIBC_USE_ISOC2X = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_ISOC2X); }))) {
            mixin(enumMixinStr___GLIBC_USE_ISOC2X);
        }
    }




    static if(!is(typeof(_DEFAULT_SOURCE))) {
        private enum enumMixinStr__DEFAULT_SOURCE = `enum _DEFAULT_SOURCE = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__DEFAULT_SOURCE); }))) {
            mixin(enumMixinStr__DEFAULT_SOURCE);
        }
    }
    static if(!is(typeof(_FEATURES_H))) {
        private enum enumMixinStr__FEATURES_H = `enum _FEATURES_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__FEATURES_H); }))) {
            mixin(enumMixinStr__FEATURES_H);
        }
    }
    static if(!is(typeof(BYTE_ORDER))) {
        private enum enumMixinStr_BYTE_ORDER = `enum BYTE_ORDER = __BYTE_ORDER;`;
        static if(is(typeof({ mixin(enumMixinStr_BYTE_ORDER); }))) {
            mixin(enumMixinStr_BYTE_ORDER);
        }
    }




    static if(!is(typeof(PDP_ENDIAN))) {
        private enum enumMixinStr_PDP_ENDIAN = `enum PDP_ENDIAN = __PDP_ENDIAN;`;
        static if(is(typeof({ mixin(enumMixinStr_PDP_ENDIAN); }))) {
            mixin(enumMixinStr_PDP_ENDIAN);
        }
    }




    static if(!is(typeof(BIG_ENDIAN))) {
        private enum enumMixinStr_BIG_ENDIAN = `enum BIG_ENDIAN = __BIG_ENDIAN;`;
        static if(is(typeof({ mixin(enumMixinStr_BIG_ENDIAN); }))) {
            mixin(enumMixinStr_BIG_ENDIAN);
        }
    }




    static if(!is(typeof(LITTLE_ENDIAN))) {
        private enum enumMixinStr_LITTLE_ENDIAN = `enum LITTLE_ENDIAN = __LITTLE_ENDIAN;`;
        static if(is(typeof({ mixin(enumMixinStr_LITTLE_ENDIAN); }))) {
            mixin(enumMixinStr_LITTLE_ENDIAN);
        }
    }




    static if(!is(typeof(_ENDIAN_H))) {
        private enum enumMixinStr__ENDIAN_H = `enum _ENDIAN_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__ENDIAN_H); }))) {
            mixin(enumMixinStr__ENDIAN_H);
        }
    }




    static if(!is(typeof(__SYSCALL_WORDSIZE))) {
        private enum enumMixinStr___SYSCALL_WORDSIZE = `enum __SYSCALL_WORDSIZE = 64;`;
        static if(is(typeof({ mixin(enumMixinStr___SYSCALL_WORDSIZE); }))) {
            mixin(enumMixinStr___SYSCALL_WORDSIZE);
        }
    }




    static if(!is(typeof(__WORDSIZE_TIME64_COMPAT32))) {
        private enum enumMixinStr___WORDSIZE_TIME64_COMPAT32 = `enum __WORDSIZE_TIME64_COMPAT32 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___WORDSIZE_TIME64_COMPAT32); }))) {
            mixin(enumMixinStr___WORDSIZE_TIME64_COMPAT32);
        }
    }




    static if(!is(typeof(__WORDSIZE))) {
        private enum enumMixinStr___WORDSIZE = `enum __WORDSIZE = 64;`;
        static if(is(typeof({ mixin(enumMixinStr___WORDSIZE); }))) {
            mixin(enumMixinStr___WORDSIZE);
        }
    }




    static if(!is(typeof(__WCHAR_MIN))) {
        private enum enumMixinStr___WCHAR_MIN = `enum __WCHAR_MIN = ( - __WCHAR_MAX - 1 );`;
        static if(is(typeof({ mixin(enumMixinStr___WCHAR_MIN); }))) {
            mixin(enumMixinStr___WCHAR_MIN);
        }
    }




    static if(!is(typeof(__WCHAR_MAX))) {
        private enum enumMixinStr___WCHAR_MAX = `enum __WCHAR_MAX = 0x7fffffff;`;
        static if(is(typeof({ mixin(enumMixinStr___WCHAR_MAX); }))) {
            mixin(enumMixinStr___WCHAR_MAX);
        }
    }




    static if(!is(typeof(_BITS_WCHAR_H))) {
        private enum enumMixinStr__BITS_WCHAR_H = `enum _BITS_WCHAR_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_WCHAR_H); }))) {
            mixin(enumMixinStr__BITS_WCHAR_H);
        }
    }




    static if(!is(typeof(__WCOREFLAG))) {
        private enum enumMixinStr___WCOREFLAG = `enum __WCOREFLAG = 0x80;`;
        static if(is(typeof({ mixin(enumMixinStr___WCOREFLAG); }))) {
            mixin(enumMixinStr___WCOREFLAG);
        }
    }




    static if(!is(typeof(__W_CONTINUED))) {
        private enum enumMixinStr___W_CONTINUED = `enum __W_CONTINUED = 0xffff;`;
        static if(is(typeof({ mixin(enumMixinStr___W_CONTINUED); }))) {
            mixin(enumMixinStr___W_CONTINUED);
        }
    }
    static if(!is(typeof(__WCLONE))) {
        private enum enumMixinStr___WCLONE = `enum __WCLONE = 0x80000000;`;
        static if(is(typeof({ mixin(enumMixinStr___WCLONE); }))) {
            mixin(enumMixinStr___WCLONE);
        }
    }




    static if(!is(typeof(__WALL))) {
        private enum enumMixinStr___WALL = `enum __WALL = 0x40000000;`;
        static if(is(typeof({ mixin(enumMixinStr___WALL); }))) {
            mixin(enumMixinStr___WALL);
        }
    }




    static if(!is(typeof(__WNOTHREAD))) {
        private enum enumMixinStr___WNOTHREAD = `enum __WNOTHREAD = 0x20000000;`;
        static if(is(typeof({ mixin(enumMixinStr___WNOTHREAD); }))) {
            mixin(enumMixinStr___WNOTHREAD);
        }
    }




    static if(!is(typeof(WNOWAIT))) {
        private enum enumMixinStr_WNOWAIT = `enum WNOWAIT = 0x01000000;`;
        static if(is(typeof({ mixin(enumMixinStr_WNOWAIT); }))) {
            mixin(enumMixinStr_WNOWAIT);
        }
    }




    static if(!is(typeof(WCONTINUED))) {
        private enum enumMixinStr_WCONTINUED = `enum WCONTINUED = 8;`;
        static if(is(typeof({ mixin(enumMixinStr_WCONTINUED); }))) {
            mixin(enumMixinStr_WCONTINUED);
        }
    }




    static if(!is(typeof(WEXITED))) {
        private enum enumMixinStr_WEXITED = `enum WEXITED = 4;`;
        static if(is(typeof({ mixin(enumMixinStr_WEXITED); }))) {
            mixin(enumMixinStr_WEXITED);
        }
    }




    static if(!is(typeof(WSTOPPED))) {
        private enum enumMixinStr_WSTOPPED = `enum WSTOPPED = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_WSTOPPED); }))) {
            mixin(enumMixinStr_WSTOPPED);
        }
    }




    static if(!is(typeof(WUNTRACED))) {
        private enum enumMixinStr_WUNTRACED = `enum WUNTRACED = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_WUNTRACED); }))) {
            mixin(enumMixinStr_WUNTRACED);
        }
    }




    static if(!is(typeof(WNOHANG))) {
        private enum enumMixinStr_WNOHANG = `enum WNOHANG = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_WNOHANG); }))) {
            mixin(enumMixinStr_WNOHANG);
        }
    }




    static if(!is(typeof(_BITS_UINTN_IDENTITY_H))) {
        private enum enumMixinStr__BITS_UINTN_IDENTITY_H = `enum _BITS_UINTN_IDENTITY_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_UINTN_IDENTITY_H); }))) {
            mixin(enumMixinStr__BITS_UINTN_IDENTITY_H);
        }
    }




    static if(!is(typeof(__FD_SETSIZE))) {
        private enum enumMixinStr___FD_SETSIZE = `enum __FD_SETSIZE = 1024;`;
        static if(is(typeof({ mixin(enumMixinStr___FD_SETSIZE); }))) {
            mixin(enumMixinStr___FD_SETSIZE);
        }
    }




    static if(!is(typeof(__KERNEL_OLD_TIMEVAL_MATCHES_TIMEVAL64))) {
        private enum enumMixinStr___KERNEL_OLD_TIMEVAL_MATCHES_TIMEVAL64 = `enum __KERNEL_OLD_TIMEVAL_MATCHES_TIMEVAL64 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___KERNEL_OLD_TIMEVAL_MATCHES_TIMEVAL64); }))) {
            mixin(enumMixinStr___KERNEL_OLD_TIMEVAL_MATCHES_TIMEVAL64);
        }
    }




    static if(!is(typeof(__STATFS_MATCHES_STATFS64))) {
        private enum enumMixinStr___STATFS_MATCHES_STATFS64 = `enum __STATFS_MATCHES_STATFS64 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___STATFS_MATCHES_STATFS64); }))) {
            mixin(enumMixinStr___STATFS_MATCHES_STATFS64);
        }
    }




    static if(!is(typeof(__RLIM_T_MATCHES_RLIM64_T))) {
        private enum enumMixinStr___RLIM_T_MATCHES_RLIM64_T = `enum __RLIM_T_MATCHES_RLIM64_T = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___RLIM_T_MATCHES_RLIM64_T); }))) {
            mixin(enumMixinStr___RLIM_T_MATCHES_RLIM64_T);
        }
    }




    static if(!is(typeof(__INO_T_MATCHES_INO64_T))) {
        private enum enumMixinStr___INO_T_MATCHES_INO64_T = `enum __INO_T_MATCHES_INO64_T = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___INO_T_MATCHES_INO64_T); }))) {
            mixin(enumMixinStr___INO_T_MATCHES_INO64_T);
        }
    }




    static if(!is(typeof(__OFF_T_MATCHES_OFF64_T))) {
        private enum enumMixinStr___OFF_T_MATCHES_OFF64_T = `enum __OFF_T_MATCHES_OFF64_T = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___OFF_T_MATCHES_OFF64_T); }))) {
            mixin(enumMixinStr___OFF_T_MATCHES_OFF64_T);
        }
    }




    static if(!is(typeof(__CPU_MASK_TYPE))) {
        private enum enumMixinStr___CPU_MASK_TYPE = `enum __CPU_MASK_TYPE = __SYSCALL_ULONG_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___CPU_MASK_TYPE); }))) {
            mixin(enumMixinStr___CPU_MASK_TYPE);
        }
    }




    static if(!is(typeof(__SSIZE_T_TYPE))) {
        private enum enumMixinStr___SSIZE_T_TYPE = `enum __SSIZE_T_TYPE = __SWORD_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___SSIZE_T_TYPE); }))) {
            mixin(enumMixinStr___SSIZE_T_TYPE);
        }
    }




    static if(!is(typeof(__FSID_T_TYPE))) {
        private enum enumMixinStr___FSID_T_TYPE = `enum __FSID_T_TYPE = { int __val [ 2 ] ; };`;
        static if(is(typeof({ mixin(enumMixinStr___FSID_T_TYPE); }))) {
            mixin(enumMixinStr___FSID_T_TYPE);
        }
    }




    static if(!is(typeof(__BLKSIZE_T_TYPE))) {
        private enum enumMixinStr___BLKSIZE_T_TYPE = `enum __BLKSIZE_T_TYPE = __SYSCALL_SLONG_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___BLKSIZE_T_TYPE); }))) {
            mixin(enumMixinStr___BLKSIZE_T_TYPE);
        }
    }




    static if(!is(typeof(__TIMER_T_TYPE))) {
        private enum enumMixinStr___TIMER_T_TYPE = `enum __TIMER_T_TYPE = void *;`;
        static if(is(typeof({ mixin(enumMixinStr___TIMER_T_TYPE); }))) {
            mixin(enumMixinStr___TIMER_T_TYPE);
        }
    }




    static if(!is(typeof(__CLOCKID_T_TYPE))) {
        private enum enumMixinStr___CLOCKID_T_TYPE = `enum __CLOCKID_T_TYPE = __S32_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___CLOCKID_T_TYPE); }))) {
            mixin(enumMixinStr___CLOCKID_T_TYPE);
        }
    }




    static if(!is(typeof(__KEY_T_TYPE))) {
        private enum enumMixinStr___KEY_T_TYPE = `enum __KEY_T_TYPE = __S32_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___KEY_T_TYPE); }))) {
            mixin(enumMixinStr___KEY_T_TYPE);
        }
    }




    static if(!is(typeof(__DADDR_T_TYPE))) {
        private enum enumMixinStr___DADDR_T_TYPE = `enum __DADDR_T_TYPE = __S32_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___DADDR_T_TYPE); }))) {
            mixin(enumMixinStr___DADDR_T_TYPE);
        }
    }




    static if(!is(typeof(__SUSECONDS64_T_TYPE))) {
        private enum enumMixinStr___SUSECONDS64_T_TYPE = `enum __SUSECONDS64_T_TYPE = __SQUAD_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___SUSECONDS64_T_TYPE); }))) {
            mixin(enumMixinStr___SUSECONDS64_T_TYPE);
        }
    }




    static if(!is(typeof(__SUSECONDS_T_TYPE))) {
        private enum enumMixinStr___SUSECONDS_T_TYPE = `enum __SUSECONDS_T_TYPE = __SYSCALL_SLONG_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___SUSECONDS_T_TYPE); }))) {
            mixin(enumMixinStr___SUSECONDS_T_TYPE);
        }
    }




    static if(!is(typeof(__USECONDS_T_TYPE))) {
        private enum enumMixinStr___USECONDS_T_TYPE = `enum __USECONDS_T_TYPE = __U32_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___USECONDS_T_TYPE); }))) {
            mixin(enumMixinStr___USECONDS_T_TYPE);
        }
    }




    static if(!is(typeof(__TIME_T_TYPE))) {
        private enum enumMixinStr___TIME_T_TYPE = `enum __TIME_T_TYPE = __SYSCALL_SLONG_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___TIME_T_TYPE); }))) {
            mixin(enumMixinStr___TIME_T_TYPE);
        }
    }




    static if(!is(typeof(__CLOCK_T_TYPE))) {
        private enum enumMixinStr___CLOCK_T_TYPE = `enum __CLOCK_T_TYPE = __SYSCALL_SLONG_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___CLOCK_T_TYPE); }))) {
            mixin(enumMixinStr___CLOCK_T_TYPE);
        }
    }




    static if(!is(typeof(__ID_T_TYPE))) {
        private enum enumMixinStr___ID_T_TYPE = `enum __ID_T_TYPE = __U32_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___ID_T_TYPE); }))) {
            mixin(enumMixinStr___ID_T_TYPE);
        }
    }




    static if(!is(typeof(__FSFILCNT64_T_TYPE))) {
        private enum enumMixinStr___FSFILCNT64_T_TYPE = `enum __FSFILCNT64_T_TYPE = __UQUAD_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___FSFILCNT64_T_TYPE); }))) {
            mixin(enumMixinStr___FSFILCNT64_T_TYPE);
        }
    }




    static if(!is(typeof(__FSFILCNT_T_TYPE))) {
        private enum enumMixinStr___FSFILCNT_T_TYPE = `enum __FSFILCNT_T_TYPE = __SYSCALL_ULONG_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___FSFILCNT_T_TYPE); }))) {
            mixin(enumMixinStr___FSFILCNT_T_TYPE);
        }
    }




    static if(!is(typeof(__FSBLKCNT64_T_TYPE))) {
        private enum enumMixinStr___FSBLKCNT64_T_TYPE = `enum __FSBLKCNT64_T_TYPE = __UQUAD_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___FSBLKCNT64_T_TYPE); }))) {
            mixin(enumMixinStr___FSBLKCNT64_T_TYPE);
        }
    }




    static if(!is(typeof(__FSBLKCNT_T_TYPE))) {
        private enum enumMixinStr___FSBLKCNT_T_TYPE = `enum __FSBLKCNT_T_TYPE = __SYSCALL_ULONG_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___FSBLKCNT_T_TYPE); }))) {
            mixin(enumMixinStr___FSBLKCNT_T_TYPE);
        }
    }




    static if(!is(typeof(__BLKCNT64_T_TYPE))) {
        private enum enumMixinStr___BLKCNT64_T_TYPE = `enum __BLKCNT64_T_TYPE = __SQUAD_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___BLKCNT64_T_TYPE); }))) {
            mixin(enumMixinStr___BLKCNT64_T_TYPE);
        }
    }




    static if(!is(typeof(__BLKCNT_T_TYPE))) {
        private enum enumMixinStr___BLKCNT_T_TYPE = `enum __BLKCNT_T_TYPE = __SYSCALL_SLONG_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___BLKCNT_T_TYPE); }))) {
            mixin(enumMixinStr___BLKCNT_T_TYPE);
        }
    }




    static if(!is(typeof(__RLIM64_T_TYPE))) {
        private enum enumMixinStr___RLIM64_T_TYPE = `enum __RLIM64_T_TYPE = __UQUAD_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___RLIM64_T_TYPE); }))) {
            mixin(enumMixinStr___RLIM64_T_TYPE);
        }
    }




    static if(!is(typeof(__RLIM_T_TYPE))) {
        private enum enumMixinStr___RLIM_T_TYPE = `enum __RLIM_T_TYPE = __SYSCALL_ULONG_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___RLIM_T_TYPE); }))) {
            mixin(enumMixinStr___RLIM_T_TYPE);
        }
    }




    static if(!is(typeof(__PID_T_TYPE))) {
        private enum enumMixinStr___PID_T_TYPE = `enum __PID_T_TYPE = __S32_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___PID_T_TYPE); }))) {
            mixin(enumMixinStr___PID_T_TYPE);
        }
    }




    static if(!is(typeof(__OFF64_T_TYPE))) {
        private enum enumMixinStr___OFF64_T_TYPE = `enum __OFF64_T_TYPE = __SQUAD_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___OFF64_T_TYPE); }))) {
            mixin(enumMixinStr___OFF64_T_TYPE);
        }
    }




    static if(!is(typeof(__OFF_T_TYPE))) {
        private enum enumMixinStr___OFF_T_TYPE = `enum __OFF_T_TYPE = __SYSCALL_SLONG_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___OFF_T_TYPE); }))) {
            mixin(enumMixinStr___OFF_T_TYPE);
        }
    }




    static if(!is(typeof(__FSWORD_T_TYPE))) {
        private enum enumMixinStr___FSWORD_T_TYPE = `enum __FSWORD_T_TYPE = __SYSCALL_SLONG_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___FSWORD_T_TYPE); }))) {
            mixin(enumMixinStr___FSWORD_T_TYPE);
        }
    }




    static if(!is(typeof(__NLINK_T_TYPE))) {
        private enum enumMixinStr___NLINK_T_TYPE = `enum __NLINK_T_TYPE = __SYSCALL_ULONG_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___NLINK_T_TYPE); }))) {
            mixin(enumMixinStr___NLINK_T_TYPE);
        }
    }




    static if(!is(typeof(__MODE_T_TYPE))) {
        private enum enumMixinStr___MODE_T_TYPE = `enum __MODE_T_TYPE = __U32_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___MODE_T_TYPE); }))) {
            mixin(enumMixinStr___MODE_T_TYPE);
        }
    }




    static if(!is(typeof(__INO64_T_TYPE))) {
        private enum enumMixinStr___INO64_T_TYPE = `enum __INO64_T_TYPE = __UQUAD_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___INO64_T_TYPE); }))) {
            mixin(enumMixinStr___INO64_T_TYPE);
        }
    }




    static if(!is(typeof(__INO_T_TYPE))) {
        private enum enumMixinStr___INO_T_TYPE = `enum __INO_T_TYPE = __SYSCALL_ULONG_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___INO_T_TYPE); }))) {
            mixin(enumMixinStr___INO_T_TYPE);
        }
    }




    static if(!is(typeof(__GID_T_TYPE))) {
        private enum enumMixinStr___GID_T_TYPE = `enum __GID_T_TYPE = __U32_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___GID_T_TYPE); }))) {
            mixin(enumMixinStr___GID_T_TYPE);
        }
    }




    static if(!is(typeof(__UID_T_TYPE))) {
        private enum enumMixinStr___UID_T_TYPE = `enum __UID_T_TYPE = __U32_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___UID_T_TYPE); }))) {
            mixin(enumMixinStr___UID_T_TYPE);
        }
    }




    static if(!is(typeof(__DEV_T_TYPE))) {
        private enum enumMixinStr___DEV_T_TYPE = `enum __DEV_T_TYPE = __UQUAD_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___DEV_T_TYPE); }))) {
            mixin(enumMixinStr___DEV_T_TYPE);
        }
    }




    static if(!is(typeof(__SYSCALL_ULONG_TYPE))) {
        private enum enumMixinStr___SYSCALL_ULONG_TYPE = `enum __SYSCALL_ULONG_TYPE = __ULONGWORD_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___SYSCALL_ULONG_TYPE); }))) {
            mixin(enumMixinStr___SYSCALL_ULONG_TYPE);
        }
    }




    static if(!is(typeof(__SYSCALL_SLONG_TYPE))) {
        private enum enumMixinStr___SYSCALL_SLONG_TYPE = `enum __SYSCALL_SLONG_TYPE = __SLONGWORD_TYPE;`;
        static if(is(typeof({ mixin(enumMixinStr___SYSCALL_SLONG_TYPE); }))) {
            mixin(enumMixinStr___SYSCALL_SLONG_TYPE);
        }
    }




    static if(!is(typeof(_BITS_TYPESIZES_H))) {
        private enum enumMixinStr__BITS_TYPESIZES_H = `enum _BITS_TYPESIZES_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_TYPESIZES_H); }))) {
            mixin(enumMixinStr__BITS_TYPESIZES_H);
        }
    }




    static if(!is(typeof(__timer_t_defined))) {
        private enum enumMixinStr___timer_t_defined = `enum __timer_t_defined = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___timer_t_defined); }))) {
            mixin(enumMixinStr___timer_t_defined);
        }
    }




    static if(!is(typeof(__time_t_defined))) {
        private enum enumMixinStr___time_t_defined = `enum __time_t_defined = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___time_t_defined); }))) {
            mixin(enumMixinStr___time_t_defined);
        }
    }




    static if(!is(typeof(__struct_tm_defined))) {
        private enum enumMixinStr___struct_tm_defined = `enum __struct_tm_defined = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___struct_tm_defined); }))) {
            mixin(enumMixinStr___struct_tm_defined);
        }
    }




    static if(!is(typeof(__timeval_defined))) {
        private enum enumMixinStr___timeval_defined = `enum __timeval_defined = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___timeval_defined); }))) {
            mixin(enumMixinStr___timeval_defined);
        }
    }




    static if(!is(typeof(_STRUCT_TIMESPEC))) {
        private enum enumMixinStr__STRUCT_TIMESPEC = `enum _STRUCT_TIMESPEC = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__STRUCT_TIMESPEC); }))) {
            mixin(enumMixinStr__STRUCT_TIMESPEC);
        }
    }




    static if(!is(typeof(__itimerspec_defined))) {
        private enum enumMixinStr___itimerspec_defined = `enum __itimerspec_defined = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___itimerspec_defined); }))) {
            mixin(enumMixinStr___itimerspec_defined);
        }
    }




    static if(!is(typeof(__sigset_t_defined))) {
        private enum enumMixinStr___sigset_t_defined = `enum __sigset_t_defined = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___sigset_t_defined); }))) {
            mixin(enumMixinStr___sigset_t_defined);
        }
    }




    static if(!is(typeof(_BITS_TYPES_LOCALE_T_H))) {
        private enum enumMixinStr__BITS_TYPES_LOCALE_T_H = `enum _BITS_TYPES_LOCALE_T_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_TYPES_LOCALE_T_H); }))) {
            mixin(enumMixinStr__BITS_TYPES_LOCALE_T_H);
        }
    }




    static if(!is(typeof(__clockid_t_defined))) {
        private enum enumMixinStr___clockid_t_defined = `enum __clockid_t_defined = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___clockid_t_defined); }))) {
            mixin(enumMixinStr___clockid_t_defined);
        }
    }




    static if(!is(typeof(__clock_t_defined))) {
        private enum enumMixinStr___clock_t_defined = `enum __clock_t_defined = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___clock_t_defined); }))) {
            mixin(enumMixinStr___clock_t_defined);
        }
    }




    static if(!is(typeof(_SIGSET_NWORDS))) {
        private enum enumMixinStr__SIGSET_NWORDS = `enum _SIGSET_NWORDS = ( 1024 / ( 8 * ( unsigned long int ) .sizeof ) );`;
        static if(is(typeof({ mixin(enumMixinStr__SIGSET_NWORDS); }))) {
            mixin(enumMixinStr__SIGSET_NWORDS);
        }
    }






    static if(!is(typeof(_BITS_TYPES___LOCALE_T_H))) {
        private enum enumMixinStr__BITS_TYPES___LOCALE_T_H = `enum _BITS_TYPES___LOCALE_T_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_TYPES___LOCALE_T_H); }))) {
            mixin(enumMixinStr__BITS_TYPES___LOCALE_T_H);
        }
    }




    static if(!is(typeof(__STD_TYPE))) {
        private enum enumMixinStr___STD_TYPE = `enum __STD_TYPE = typedef;`;
        static if(is(typeof({ mixin(enumMixinStr___STD_TYPE); }))) {
            mixin(enumMixinStr___STD_TYPE);
        }
    }




    static if(!is(typeof(__U64_TYPE))) {
        private enum enumMixinStr___U64_TYPE = `enum __U64_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___U64_TYPE); }))) {
            mixin(enumMixinStr___U64_TYPE);
        }
    }




    static if(!is(typeof(__S64_TYPE))) {
        private enum enumMixinStr___S64_TYPE = `enum __S64_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___S64_TYPE); }))) {
            mixin(enumMixinStr___S64_TYPE);
        }
    }




    static if(!is(typeof(__ULONG32_TYPE))) {
        private enum enumMixinStr___ULONG32_TYPE = `enum __ULONG32_TYPE = unsigned int;`;
        static if(is(typeof({ mixin(enumMixinStr___ULONG32_TYPE); }))) {
            mixin(enumMixinStr___ULONG32_TYPE);
        }
    }




    static if(!is(typeof(__SLONG32_TYPE))) {
        private enum enumMixinStr___SLONG32_TYPE = `enum __SLONG32_TYPE = int;`;
        static if(is(typeof({ mixin(enumMixinStr___SLONG32_TYPE); }))) {
            mixin(enumMixinStr___SLONG32_TYPE);
        }
    }




    static if(!is(typeof(__UWORD_TYPE))) {
        private enum enumMixinStr___UWORD_TYPE = `enum __UWORD_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___UWORD_TYPE); }))) {
            mixin(enumMixinStr___UWORD_TYPE);
        }
    }




    static if(!is(typeof(__SWORD_TYPE))) {
        private enum enumMixinStr___SWORD_TYPE = `enum __SWORD_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___SWORD_TYPE); }))) {
            mixin(enumMixinStr___SWORD_TYPE);
        }
    }




    static if(!is(typeof(__UQUAD_TYPE))) {
        private enum enumMixinStr___UQUAD_TYPE = `enum __UQUAD_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___UQUAD_TYPE); }))) {
            mixin(enumMixinStr___UQUAD_TYPE);
        }
    }




    static if(!is(typeof(__SQUAD_TYPE))) {
        private enum enumMixinStr___SQUAD_TYPE = `enum __SQUAD_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___SQUAD_TYPE); }))) {
            mixin(enumMixinStr___SQUAD_TYPE);
        }
    }




    static if(!is(typeof(__ULONGWORD_TYPE))) {
        private enum enumMixinStr___ULONGWORD_TYPE = `enum __ULONGWORD_TYPE = unsigned long int;`;
        static if(is(typeof({ mixin(enumMixinStr___ULONGWORD_TYPE); }))) {
            mixin(enumMixinStr___ULONGWORD_TYPE);
        }
    }




    static if(!is(typeof(__SLONGWORD_TYPE))) {
        private enum enumMixinStr___SLONGWORD_TYPE = `enum __SLONGWORD_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___SLONGWORD_TYPE); }))) {
            mixin(enumMixinStr___SLONGWORD_TYPE);
        }
    }




    static if(!is(typeof(__U32_TYPE))) {
        private enum enumMixinStr___U32_TYPE = `enum __U32_TYPE = unsigned int;`;
        static if(is(typeof({ mixin(enumMixinStr___U32_TYPE); }))) {
            mixin(enumMixinStr___U32_TYPE);
        }
    }




    static if(!is(typeof(__S32_TYPE))) {
        private enum enumMixinStr___S32_TYPE = `enum __S32_TYPE = int;`;
        static if(is(typeof({ mixin(enumMixinStr___S32_TYPE); }))) {
            mixin(enumMixinStr___S32_TYPE);
        }
    }




    static if(!is(typeof(__U16_TYPE))) {
        private enum enumMixinStr___U16_TYPE = `enum __U16_TYPE = unsigned short int;`;
        static if(is(typeof({ mixin(enumMixinStr___U16_TYPE); }))) {
            mixin(enumMixinStr___U16_TYPE);
        }
    }




    static if(!is(typeof(__S16_TYPE))) {
        private enum enumMixinStr___S16_TYPE = `enum __S16_TYPE = short int;`;
        static if(is(typeof({ mixin(enumMixinStr___S16_TYPE); }))) {
            mixin(enumMixinStr___S16_TYPE);
        }
    }




    static if(!is(typeof(_BITS_TYPES_H))) {
        private enum enumMixinStr__BITS_TYPES_H = `enum _BITS_TYPES_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_TYPES_H); }))) {
            mixin(enumMixinStr__BITS_TYPES_H);
        }
    }




    static if(!is(typeof(__TIMESIZE))) {
        private enum enumMixinStr___TIMESIZE = `enum __TIMESIZE = 64;`;
        static if(is(typeof({ mixin(enumMixinStr___TIMESIZE); }))) {
            mixin(enumMixinStr___TIMESIZE);
        }
    }




    static if(!is(typeof(__TIME64_T_TYPE))) {
        private enum enumMixinStr___TIME64_T_TYPE = `enum __TIME64_T_TYPE = long int;`;
        static if(is(typeof({ mixin(enumMixinStr___TIME64_T_TYPE); }))) {
            mixin(enumMixinStr___TIME64_T_TYPE);
        }
    }




    static if(!is(typeof(_BITS_TIME64_H))) {
        private enum enumMixinStr__BITS_TIME64_H = `enum _BITS_TIME64_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_TIME64_H); }))) {
            mixin(enumMixinStr__BITS_TIME64_H);
        }
    }




    static if(!is(typeof(TIMER_ABSTIME))) {
        private enum enumMixinStr_TIMER_ABSTIME = `enum TIMER_ABSTIME = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_TIMER_ABSTIME); }))) {
            mixin(enumMixinStr_TIMER_ABSTIME);
        }
    }




    static if(!is(typeof(CLOCK_TAI))) {
        private enum enumMixinStr_CLOCK_TAI = `enum CLOCK_TAI = 11;`;
        static if(is(typeof({ mixin(enumMixinStr_CLOCK_TAI); }))) {
            mixin(enumMixinStr_CLOCK_TAI);
        }
    }




    static if(!is(typeof(CLOCK_BOOTTIME_ALARM))) {
        private enum enumMixinStr_CLOCK_BOOTTIME_ALARM = `enum CLOCK_BOOTTIME_ALARM = 9;`;
        static if(is(typeof({ mixin(enumMixinStr_CLOCK_BOOTTIME_ALARM); }))) {
            mixin(enumMixinStr_CLOCK_BOOTTIME_ALARM);
        }
    }




    static if(!is(typeof(CLOCK_REALTIME_ALARM))) {
        private enum enumMixinStr_CLOCK_REALTIME_ALARM = `enum CLOCK_REALTIME_ALARM = 8;`;
        static if(is(typeof({ mixin(enumMixinStr_CLOCK_REALTIME_ALARM); }))) {
            mixin(enumMixinStr_CLOCK_REALTIME_ALARM);
        }
    }




    static if(!is(typeof(CLOCK_BOOTTIME))) {
        private enum enumMixinStr_CLOCK_BOOTTIME = `enum CLOCK_BOOTTIME = 7;`;
        static if(is(typeof({ mixin(enumMixinStr_CLOCK_BOOTTIME); }))) {
            mixin(enumMixinStr_CLOCK_BOOTTIME);
        }
    }




    static if(!is(typeof(CLOCK_MONOTONIC_COARSE))) {
        private enum enumMixinStr_CLOCK_MONOTONIC_COARSE = `enum CLOCK_MONOTONIC_COARSE = 6;`;
        static if(is(typeof({ mixin(enumMixinStr_CLOCK_MONOTONIC_COARSE); }))) {
            mixin(enumMixinStr_CLOCK_MONOTONIC_COARSE);
        }
    }




    static if(!is(typeof(CLOCK_REALTIME_COARSE))) {
        private enum enumMixinStr_CLOCK_REALTIME_COARSE = `enum CLOCK_REALTIME_COARSE = 5;`;
        static if(is(typeof({ mixin(enumMixinStr_CLOCK_REALTIME_COARSE); }))) {
            mixin(enumMixinStr_CLOCK_REALTIME_COARSE);
        }
    }




    static if(!is(typeof(CLOCK_MONOTONIC_RAW))) {
        private enum enumMixinStr_CLOCK_MONOTONIC_RAW = `enum CLOCK_MONOTONIC_RAW = 4;`;
        static if(is(typeof({ mixin(enumMixinStr_CLOCK_MONOTONIC_RAW); }))) {
            mixin(enumMixinStr_CLOCK_MONOTONIC_RAW);
        }
    }




    static if(!is(typeof(CLOCK_THREAD_CPUTIME_ID))) {
        private enum enumMixinStr_CLOCK_THREAD_CPUTIME_ID = `enum CLOCK_THREAD_CPUTIME_ID = 3;`;
        static if(is(typeof({ mixin(enumMixinStr_CLOCK_THREAD_CPUTIME_ID); }))) {
            mixin(enumMixinStr_CLOCK_THREAD_CPUTIME_ID);
        }
    }




    static if(!is(typeof(CLOCK_PROCESS_CPUTIME_ID))) {
        private enum enumMixinStr_CLOCK_PROCESS_CPUTIME_ID = `enum CLOCK_PROCESS_CPUTIME_ID = 2;`;
        static if(is(typeof({ mixin(enumMixinStr_CLOCK_PROCESS_CPUTIME_ID); }))) {
            mixin(enumMixinStr_CLOCK_PROCESS_CPUTIME_ID);
        }
    }




    static if(!is(typeof(CLOCK_MONOTONIC))) {
        private enum enumMixinStr_CLOCK_MONOTONIC = `enum CLOCK_MONOTONIC = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_CLOCK_MONOTONIC); }))) {
            mixin(enumMixinStr_CLOCK_MONOTONIC);
        }
    }




    static if(!is(typeof(CLOCK_REALTIME))) {
        private enum enumMixinStr_CLOCK_REALTIME = `enum CLOCK_REALTIME = 0;`;
        static if(is(typeof({ mixin(enumMixinStr_CLOCK_REALTIME); }))) {
            mixin(enumMixinStr_CLOCK_REALTIME);
        }
    }




    static if(!is(typeof(CLOCKS_PER_SEC))) {
        private enum enumMixinStr_CLOCKS_PER_SEC = `enum CLOCKS_PER_SEC = ( cast( __clock_t ) 1000000 );`;
        static if(is(typeof({ mixin(enumMixinStr_CLOCKS_PER_SEC); }))) {
            mixin(enumMixinStr_CLOCKS_PER_SEC);
        }
    }




    static if(!is(typeof(_BITS_TIME_H))) {
        private enum enumMixinStr__BITS_TIME_H = `enum _BITS_TIME_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_TIME_H); }))) {
            mixin(enumMixinStr__BITS_TIME_H);
        }
    }




    static if(!is(typeof(__ONCE_FLAG_INIT))) {
        private enum enumMixinStr___ONCE_FLAG_INIT = `enum __ONCE_FLAG_INIT = { 0 };`;
        static if(is(typeof({ mixin(enumMixinStr___ONCE_FLAG_INIT); }))) {
            mixin(enumMixinStr___ONCE_FLAG_INIT);
        }
    }




    static if(!is(typeof(_THREAD_SHARED_TYPES_H))) {
        private enum enumMixinStr__THREAD_SHARED_TYPES_H = `enum _THREAD_SHARED_TYPES_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__THREAD_SHARED_TYPES_H); }))) {
            mixin(enumMixinStr__THREAD_SHARED_TYPES_H);
        }
    }






    static if(!is(typeof(__PTHREAD_RWLOCK_ELISION_EXTRA))) {
        private enum enumMixinStr___PTHREAD_RWLOCK_ELISION_EXTRA = `enum __PTHREAD_RWLOCK_ELISION_EXTRA = 0 , { 0 , 0 , 0 , 0 , 0 , 0 , 0 };`;
        static if(is(typeof({ mixin(enumMixinStr___PTHREAD_RWLOCK_ELISION_EXTRA); }))) {
            mixin(enumMixinStr___PTHREAD_RWLOCK_ELISION_EXTRA);
        }
    }
    static if(!is(typeof(__PTHREAD_MUTEX_HAVE_PREV))) {
        private enum enumMixinStr___PTHREAD_MUTEX_HAVE_PREV = `enum __PTHREAD_MUTEX_HAVE_PREV = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___PTHREAD_MUTEX_HAVE_PREV); }))) {
            mixin(enumMixinStr___PTHREAD_MUTEX_HAVE_PREV);
        }
    }




    static if(!is(typeof(_THREAD_MUTEX_INTERNAL_H))) {
        private enum enumMixinStr__THREAD_MUTEX_INTERNAL_H = `enum _THREAD_MUTEX_INTERNAL_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__THREAD_MUTEX_INTERNAL_H); }))) {
            mixin(enumMixinStr__THREAD_MUTEX_INTERNAL_H);
        }
    }




    static if(!is(typeof(_BITS_STDINT_UINTN_H))) {
        private enum enumMixinStr__BITS_STDINT_UINTN_H = `enum _BITS_STDINT_UINTN_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_STDINT_UINTN_H); }))) {
            mixin(enumMixinStr__BITS_STDINT_UINTN_H);
        }
    }




    static if(!is(typeof(_BITS_STDINT_INTN_H))) {
        private enum enumMixinStr__BITS_STDINT_INTN_H = `enum _BITS_STDINT_INTN_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_STDINT_INTN_H); }))) {
            mixin(enumMixinStr__BITS_STDINT_INTN_H);
        }
    }
    static if(!is(typeof(__have_pthread_attr_t))) {
        private enum enumMixinStr___have_pthread_attr_t = `enum __have_pthread_attr_t = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___have_pthread_attr_t); }))) {
            mixin(enumMixinStr___have_pthread_attr_t);
        }
    }




    static if(!is(typeof(_BITS_PTHREADTYPES_COMMON_H))) {
        private enum enumMixinStr__BITS_PTHREADTYPES_COMMON_H = `enum _BITS_PTHREADTYPES_COMMON_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_PTHREADTYPES_COMMON_H); }))) {
            mixin(enumMixinStr__BITS_PTHREADTYPES_COMMON_H);
        }
    }
    static if(!is(typeof(__SIZEOF_PTHREAD_BARRIERATTR_T))) {
        private enum enumMixinStr___SIZEOF_PTHREAD_BARRIERATTR_T = `enum __SIZEOF_PTHREAD_BARRIERATTR_T = 4;`;
        static if(is(typeof({ mixin(enumMixinStr___SIZEOF_PTHREAD_BARRIERATTR_T); }))) {
            mixin(enumMixinStr___SIZEOF_PTHREAD_BARRIERATTR_T);
        }
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_RWLOCKATTR_T))) {
        private enum enumMixinStr___SIZEOF_PTHREAD_RWLOCKATTR_T = `enum __SIZEOF_PTHREAD_RWLOCKATTR_T = 8;`;
        static if(is(typeof({ mixin(enumMixinStr___SIZEOF_PTHREAD_RWLOCKATTR_T); }))) {
            mixin(enumMixinStr___SIZEOF_PTHREAD_RWLOCKATTR_T);
        }
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_CONDATTR_T))) {
        private enum enumMixinStr___SIZEOF_PTHREAD_CONDATTR_T = `enum __SIZEOF_PTHREAD_CONDATTR_T = 4;`;
        static if(is(typeof({ mixin(enumMixinStr___SIZEOF_PTHREAD_CONDATTR_T); }))) {
            mixin(enumMixinStr___SIZEOF_PTHREAD_CONDATTR_T);
        }
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_COND_T))) {
        private enum enumMixinStr___SIZEOF_PTHREAD_COND_T = `enum __SIZEOF_PTHREAD_COND_T = 48;`;
        static if(is(typeof({ mixin(enumMixinStr___SIZEOF_PTHREAD_COND_T); }))) {
            mixin(enumMixinStr___SIZEOF_PTHREAD_COND_T);
        }
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_MUTEXATTR_T))) {
        private enum enumMixinStr___SIZEOF_PTHREAD_MUTEXATTR_T = `enum __SIZEOF_PTHREAD_MUTEXATTR_T = 4;`;
        static if(is(typeof({ mixin(enumMixinStr___SIZEOF_PTHREAD_MUTEXATTR_T); }))) {
            mixin(enumMixinStr___SIZEOF_PTHREAD_MUTEXATTR_T);
        }
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_BARRIER_T))) {
        private enum enumMixinStr___SIZEOF_PTHREAD_BARRIER_T = `enum __SIZEOF_PTHREAD_BARRIER_T = 32;`;
        static if(is(typeof({ mixin(enumMixinStr___SIZEOF_PTHREAD_BARRIER_T); }))) {
            mixin(enumMixinStr___SIZEOF_PTHREAD_BARRIER_T);
        }
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_RWLOCK_T))) {
        private enum enumMixinStr___SIZEOF_PTHREAD_RWLOCK_T = `enum __SIZEOF_PTHREAD_RWLOCK_T = 56;`;
        static if(is(typeof({ mixin(enumMixinStr___SIZEOF_PTHREAD_RWLOCK_T); }))) {
            mixin(enumMixinStr___SIZEOF_PTHREAD_RWLOCK_T);
        }
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_ATTR_T))) {
        private enum enumMixinStr___SIZEOF_PTHREAD_ATTR_T = `enum __SIZEOF_PTHREAD_ATTR_T = 56;`;
        static if(is(typeof({ mixin(enumMixinStr___SIZEOF_PTHREAD_ATTR_T); }))) {
            mixin(enumMixinStr___SIZEOF_PTHREAD_ATTR_T);
        }
    }




    static if(!is(typeof(__SIZEOF_PTHREAD_MUTEX_T))) {
        private enum enumMixinStr___SIZEOF_PTHREAD_MUTEX_T = `enum __SIZEOF_PTHREAD_MUTEX_T = 40;`;
        static if(is(typeof({ mixin(enumMixinStr___SIZEOF_PTHREAD_MUTEX_T); }))) {
            mixin(enumMixinStr___SIZEOF_PTHREAD_MUTEX_T);
        }
    }




    static if(!is(typeof(_BITS_PTHREADTYPES_ARCH_H))) {
        private enum enumMixinStr__BITS_PTHREADTYPES_ARCH_H = `enum _BITS_PTHREADTYPES_ARCH_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_PTHREADTYPES_ARCH_H); }))) {
            mixin(enumMixinStr__BITS_PTHREADTYPES_ARCH_H);
        }
    }




    static if(!is(typeof(__LDOUBLE_REDIRECTS_TO_FLOAT128_ABI))) {
        private enum enumMixinStr___LDOUBLE_REDIRECTS_TO_FLOAT128_ABI = `enum __LDOUBLE_REDIRECTS_TO_FLOAT128_ABI = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___LDOUBLE_REDIRECTS_TO_FLOAT128_ABI); }))) {
            mixin(enumMixinStr___LDOUBLE_REDIRECTS_TO_FLOAT128_ABI);
        }
    }




    static if(!is(typeof(__GLIBC_USE_IEC_60559_TYPES_EXT))) {
        private enum enumMixinStr___GLIBC_USE_IEC_60559_TYPES_EXT = `enum __GLIBC_USE_IEC_60559_TYPES_EXT = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_IEC_60559_TYPES_EXT); }))) {
            mixin(enumMixinStr___GLIBC_USE_IEC_60559_TYPES_EXT);
        }
    }




    static if(!is(typeof(__GLIBC_USE_IEC_60559_FUNCS_EXT_C2X))) {
        private enum enumMixinStr___GLIBC_USE_IEC_60559_FUNCS_EXT_C2X = `enum __GLIBC_USE_IEC_60559_FUNCS_EXT_C2X = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_IEC_60559_FUNCS_EXT_C2X); }))) {
            mixin(enumMixinStr___GLIBC_USE_IEC_60559_FUNCS_EXT_C2X);
        }
    }




    static if(!is(typeof(__GLIBC_USE_IEC_60559_FUNCS_EXT))) {
        private enum enumMixinStr___GLIBC_USE_IEC_60559_FUNCS_EXT = `enum __GLIBC_USE_IEC_60559_FUNCS_EXT = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_IEC_60559_FUNCS_EXT); }))) {
            mixin(enumMixinStr___GLIBC_USE_IEC_60559_FUNCS_EXT);
        }
    }




    static if(!is(typeof(__GLIBC_USE_IEC_60559_BFP_EXT_C2X))) {
        private enum enumMixinStr___GLIBC_USE_IEC_60559_BFP_EXT_C2X = `enum __GLIBC_USE_IEC_60559_BFP_EXT_C2X = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_IEC_60559_BFP_EXT_C2X); }))) {
            mixin(enumMixinStr___GLIBC_USE_IEC_60559_BFP_EXT_C2X);
        }
    }




    static if(!is(typeof(__GLIBC_USE_IEC_60559_BFP_EXT))) {
        private enum enumMixinStr___GLIBC_USE_IEC_60559_BFP_EXT = `enum __GLIBC_USE_IEC_60559_BFP_EXT = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_IEC_60559_BFP_EXT); }))) {
            mixin(enumMixinStr___GLIBC_USE_IEC_60559_BFP_EXT);
        }
    }




    static if(!is(typeof(__GLIBC_USE_LIB_EXT2))) {
        private enum enumMixinStr___GLIBC_USE_LIB_EXT2 = `enum __GLIBC_USE_LIB_EXT2 = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___GLIBC_USE_LIB_EXT2); }))) {
            mixin(enumMixinStr___GLIBC_USE_LIB_EXT2);
        }
    }




    static if(!is(typeof(__HAVE_FLOAT64X_LONG_DOUBLE))) {
        private enum enumMixinStr___HAVE_FLOAT64X_LONG_DOUBLE = `enum __HAVE_FLOAT64X_LONG_DOUBLE = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___HAVE_FLOAT64X_LONG_DOUBLE); }))) {
            mixin(enumMixinStr___HAVE_FLOAT64X_LONG_DOUBLE);
        }
    }




    static if(!is(typeof(__HAVE_FLOAT64X))) {
        private enum enumMixinStr___HAVE_FLOAT64X = `enum __HAVE_FLOAT64X = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___HAVE_FLOAT64X); }))) {
            mixin(enumMixinStr___HAVE_FLOAT64X);
        }
    }




    static if(!is(typeof(__HAVE_DISTINCT_FLOAT128))) {
        private enum enumMixinStr___HAVE_DISTINCT_FLOAT128 = `enum __HAVE_DISTINCT_FLOAT128 = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___HAVE_DISTINCT_FLOAT128); }))) {
            mixin(enumMixinStr___HAVE_DISTINCT_FLOAT128);
        }
    }




    static if(!is(typeof(__HAVE_FLOAT128))) {
        private enum enumMixinStr___HAVE_FLOAT128 = `enum __HAVE_FLOAT128 = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___HAVE_FLOAT128); }))) {
            mixin(enumMixinStr___HAVE_FLOAT128);
        }
    }
    static if(!is(typeof(__CFLOAT64X))) {
        private enum enumMixinStr___CFLOAT64X = `enum __CFLOAT64X = _Complex long double;`;
        static if(is(typeof({ mixin(enumMixinStr___CFLOAT64X); }))) {
            mixin(enumMixinStr___CFLOAT64X);
        }
    }




    static if(!is(typeof(__CFLOAT32X))) {
        private enum enumMixinStr___CFLOAT32X = `enum __CFLOAT32X = _Complex double;`;
        static if(is(typeof({ mixin(enumMixinStr___CFLOAT32X); }))) {
            mixin(enumMixinStr___CFLOAT32X);
        }
    }




    static if(!is(typeof(__CFLOAT64))) {
        private enum enumMixinStr___CFLOAT64 = `enum __CFLOAT64 = _Complex double;`;
        static if(is(typeof({ mixin(enumMixinStr___CFLOAT64); }))) {
            mixin(enumMixinStr___CFLOAT64);
        }
    }




    static if(!is(typeof(__CFLOAT32))) {
        private enum enumMixinStr___CFLOAT32 = `enum __CFLOAT32 = _Complex float;`;
        static if(is(typeof({ mixin(enumMixinStr___CFLOAT32); }))) {
            mixin(enumMixinStr___CFLOAT32);
        }
    }
    static if(!is(typeof(__HAVE_FLOATN_NOT_TYPEDEF))) {
        private enum enumMixinStr___HAVE_FLOATN_NOT_TYPEDEF = `enum __HAVE_FLOATN_NOT_TYPEDEF = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___HAVE_FLOATN_NOT_TYPEDEF); }))) {
            mixin(enumMixinStr___HAVE_FLOATN_NOT_TYPEDEF);
        }
    }




    static if(!is(typeof(__HAVE_FLOAT128_UNLIKE_LDBL))) {
        private enum enumMixinStr___HAVE_FLOAT128_UNLIKE_LDBL = `enum __HAVE_FLOAT128_UNLIKE_LDBL = ( 0 && 64 != 113 );`;
        static if(is(typeof({ mixin(enumMixinStr___HAVE_FLOAT128_UNLIKE_LDBL); }))) {
            mixin(enumMixinStr___HAVE_FLOAT128_UNLIKE_LDBL);
        }
    }




    static if(!is(typeof(__HAVE_DISTINCT_FLOAT128X))) {
        private enum enumMixinStr___HAVE_DISTINCT_FLOAT128X = `enum __HAVE_DISTINCT_FLOAT128X = __HAVE_FLOAT128X;`;
        static if(is(typeof({ mixin(enumMixinStr___HAVE_DISTINCT_FLOAT128X); }))) {
            mixin(enumMixinStr___HAVE_DISTINCT_FLOAT128X);
        }
    }




    static if(!is(typeof(__HAVE_DISTINCT_FLOAT64X))) {
        private enum enumMixinStr___HAVE_DISTINCT_FLOAT64X = `enum __HAVE_DISTINCT_FLOAT64X = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___HAVE_DISTINCT_FLOAT64X); }))) {
            mixin(enumMixinStr___HAVE_DISTINCT_FLOAT64X);
        }
    }




    static if(!is(typeof(__HAVE_DISTINCT_FLOAT32X))) {
        private enum enumMixinStr___HAVE_DISTINCT_FLOAT32X = `enum __HAVE_DISTINCT_FLOAT32X = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___HAVE_DISTINCT_FLOAT32X); }))) {
            mixin(enumMixinStr___HAVE_DISTINCT_FLOAT32X);
        }
    }




    static if(!is(typeof(__HAVE_DISTINCT_FLOAT64))) {
        private enum enumMixinStr___HAVE_DISTINCT_FLOAT64 = `enum __HAVE_DISTINCT_FLOAT64 = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___HAVE_DISTINCT_FLOAT64); }))) {
            mixin(enumMixinStr___HAVE_DISTINCT_FLOAT64);
        }
    }




    static if(!is(typeof(__HAVE_DISTINCT_FLOAT32))) {
        private enum enumMixinStr___HAVE_DISTINCT_FLOAT32 = `enum __HAVE_DISTINCT_FLOAT32 = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___HAVE_DISTINCT_FLOAT32); }))) {
            mixin(enumMixinStr___HAVE_DISTINCT_FLOAT32);
        }
    }




    static if(!is(typeof(__HAVE_DISTINCT_FLOAT16))) {
        private enum enumMixinStr___HAVE_DISTINCT_FLOAT16 = `enum __HAVE_DISTINCT_FLOAT16 = __HAVE_FLOAT16;`;
        static if(is(typeof({ mixin(enumMixinStr___HAVE_DISTINCT_FLOAT16); }))) {
            mixin(enumMixinStr___HAVE_DISTINCT_FLOAT16);
        }
    }




    static if(!is(typeof(__HAVE_FLOAT128X))) {
        private enum enumMixinStr___HAVE_FLOAT128X = `enum __HAVE_FLOAT128X = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___HAVE_FLOAT128X); }))) {
            mixin(enumMixinStr___HAVE_FLOAT128X);
        }
    }




    static if(!is(typeof(__HAVE_FLOAT32X))) {
        private enum enumMixinStr___HAVE_FLOAT32X = `enum __HAVE_FLOAT32X = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___HAVE_FLOAT32X); }))) {
            mixin(enumMixinStr___HAVE_FLOAT32X);
        }
    }




    static if(!is(typeof(__HAVE_FLOAT64))) {
        private enum enumMixinStr___HAVE_FLOAT64 = `enum __HAVE_FLOAT64 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___HAVE_FLOAT64); }))) {
            mixin(enumMixinStr___HAVE_FLOAT64);
        }
    }




    static if(!is(typeof(__HAVE_FLOAT32))) {
        private enum enumMixinStr___HAVE_FLOAT32 = `enum __HAVE_FLOAT32 = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___HAVE_FLOAT32); }))) {
            mixin(enumMixinStr___HAVE_FLOAT32);
        }
    }




    static if(!is(typeof(__HAVE_FLOAT16))) {
        private enum enumMixinStr___HAVE_FLOAT16 = `enum __HAVE_FLOAT16 = 0;`;
        static if(is(typeof({ mixin(enumMixinStr___HAVE_FLOAT16); }))) {
            mixin(enumMixinStr___HAVE_FLOAT16);
        }
    }






    static if(!is(typeof(__BYTE_ORDER))) {
        private enum enumMixinStr___BYTE_ORDER = `enum __BYTE_ORDER = __LITTLE_ENDIAN;`;
        static if(is(typeof({ mixin(enumMixinStr___BYTE_ORDER); }))) {
            mixin(enumMixinStr___BYTE_ORDER);
        }
    }




    static if(!is(typeof(_BITS_ENDIANNESS_H))) {
        private enum enumMixinStr__BITS_ENDIANNESS_H = `enum _BITS_ENDIANNESS_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_ENDIANNESS_H); }))) {
            mixin(enumMixinStr__BITS_ENDIANNESS_H);
        }
    }






    static if(!is(typeof(__FLOAT_WORD_ORDER))) {
        private enum enumMixinStr___FLOAT_WORD_ORDER = `enum __FLOAT_WORD_ORDER = __LITTLE_ENDIAN;`;
        static if(is(typeof({ mixin(enumMixinStr___FLOAT_WORD_ORDER); }))) {
            mixin(enumMixinStr___FLOAT_WORD_ORDER);
        }
    }




    static if(!is(typeof(__PDP_ENDIAN))) {
        private enum enumMixinStr___PDP_ENDIAN = `enum __PDP_ENDIAN = 3412;`;
        static if(is(typeof({ mixin(enumMixinStr___PDP_ENDIAN); }))) {
            mixin(enumMixinStr___PDP_ENDIAN);
        }
    }




    static if(!is(typeof(__BIG_ENDIAN))) {
        private enum enumMixinStr___BIG_ENDIAN = `enum __BIG_ENDIAN = 4321;`;
        static if(is(typeof({ mixin(enumMixinStr___BIG_ENDIAN); }))) {
            mixin(enumMixinStr___BIG_ENDIAN);
        }
    }




    static if(!is(typeof(__LITTLE_ENDIAN))) {
        private enum enumMixinStr___LITTLE_ENDIAN = `enum __LITTLE_ENDIAN = 1234;`;
        static if(is(typeof({ mixin(enumMixinStr___LITTLE_ENDIAN); }))) {
            mixin(enumMixinStr___LITTLE_ENDIAN);
        }
    }




    static if(!is(typeof(_BITS_ENDIAN_H))) {
        private enum enumMixinStr__BITS_ENDIAN_H = `enum _BITS_ENDIAN_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_ENDIAN_H); }))) {
            mixin(enumMixinStr__BITS_ENDIAN_H);
        }
    }
    static if(!is(typeof(_BITS_BYTESWAP_H))) {
        private enum enumMixinStr__BITS_BYTESWAP_H = `enum _BITS_BYTESWAP_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__BITS_BYTESWAP_H); }))) {
            mixin(enumMixinStr__BITS_BYTESWAP_H);
        }
    }






    static if(!is(typeof(_ALLOCA_H))) {
        private enum enumMixinStr__ALLOCA_H = `enum _ALLOCA_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__ALLOCA_H); }))) {
            mixin(enumMixinStr__ALLOCA_H);
        }
    }




    static if(!is(typeof(_SYS_CDEFS_H))) {
        private enum enumMixinStr__SYS_CDEFS_H = `enum _SYS_CDEFS_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__SYS_CDEFS_H); }))) {
            mixin(enumMixinStr__SYS_CDEFS_H);
        }
    }
    static if(!is(typeof(__THROW))) {
        private enum enumMixinStr___THROW = `enum __THROW = __attribute__ ( ( __nothrow__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___THROW); }))) {
            mixin(enumMixinStr___THROW);
        }
    }




    static if(!is(typeof(__THROWNL))) {
        private enum enumMixinStr___THROWNL = `enum __THROWNL = __attribute__ ( ( __nothrow__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___THROWNL); }))) {
            mixin(enumMixinStr___THROWNL);
        }
    }
    static if(!is(typeof(__ptr_t))) {
        private enum enumMixinStr___ptr_t = `enum __ptr_t = void *;`;
        static if(is(typeof({ mixin(enumMixinStr___ptr_t); }))) {
            mixin(enumMixinStr___ptr_t);
        }
    }
    static if(!is(typeof(__flexarr))) {
        private enum enumMixinStr___flexarr = `enum __flexarr = [ ];`;
        static if(is(typeof({ mixin(enumMixinStr___flexarr); }))) {
            mixin(enumMixinStr___flexarr);
        }
    }




    static if(!is(typeof(__glibc_c99_flexarr_available))) {
        private enum enumMixinStr___glibc_c99_flexarr_available = `enum __glibc_c99_flexarr_available = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___glibc_c99_flexarr_available); }))) {
            mixin(enumMixinStr___glibc_c99_flexarr_available);
        }
    }
    static if(!is(typeof(__attribute_malloc__))) {
        private enum enumMixinStr___attribute_malloc__ = `enum __attribute_malloc__ = __attribute__ ( ( __malloc__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___attribute_malloc__); }))) {
            mixin(enumMixinStr___attribute_malloc__);
        }
    }






    static if(!is(typeof(__attribute_pure__))) {
        private enum enumMixinStr___attribute_pure__ = `enum __attribute_pure__ = __attribute__ ( ( __pure__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___attribute_pure__); }))) {
            mixin(enumMixinStr___attribute_pure__);
        }
    }




    static if(!is(typeof(__attribute_const__))) {
        private enum enumMixinStr___attribute_const__ = `enum __attribute_const__ = __attribute__ ( cast( __const__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___attribute_const__); }))) {
            mixin(enumMixinStr___attribute_const__);
        }
    }




    static if(!is(typeof(__attribute_used__))) {
        private enum enumMixinStr___attribute_used__ = `enum __attribute_used__ = __attribute__ ( ( __used__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___attribute_used__); }))) {
            mixin(enumMixinStr___attribute_used__);
        }
    }




    static if(!is(typeof(__attribute_noinline__))) {
        private enum enumMixinStr___attribute_noinline__ = `enum __attribute_noinline__ = __attribute__ ( ( __noinline__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___attribute_noinline__); }))) {
            mixin(enumMixinStr___attribute_noinline__);
        }
    }




    static if(!is(typeof(__attribute_deprecated__))) {
        private enum enumMixinStr___attribute_deprecated__ = `enum __attribute_deprecated__ = __attribute__ ( ( __deprecated__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___attribute_deprecated__); }))) {
            mixin(enumMixinStr___attribute_deprecated__);
        }
    }
    static if(!is(typeof(__attribute_warn_unused_result__))) {
        private enum enumMixinStr___attribute_warn_unused_result__ = `enum __attribute_warn_unused_result__ = __attribute__ ( ( __warn_unused_result__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___attribute_warn_unused_result__); }))) {
            mixin(enumMixinStr___attribute_warn_unused_result__);
        }
    }






    static if(!is(typeof(__always_inline))) {
        private enum enumMixinStr___always_inline = `enum __always_inline = __inline __attribute__ ( ( __always_inline__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___always_inline); }))) {
            mixin(enumMixinStr___always_inline);
        }
    }






    static if(!is(typeof(__extern_inline))) {
        private enum enumMixinStr___extern_inline = `enum __extern_inline = extern __inline __attribute__ ( ( __gnu_inline__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___extern_inline); }))) {
            mixin(enumMixinStr___extern_inline);
        }
    }




    static if(!is(typeof(__extern_always_inline))) {
        private enum enumMixinStr___extern_always_inline = `enum __extern_always_inline = extern __inline __attribute__ ( ( __always_inline__ ) ) __attribute__ ( ( __gnu_inline__ ) );`;
        static if(is(typeof({ mixin(enumMixinStr___extern_always_inline); }))) {
            mixin(enumMixinStr___extern_always_inline);
        }
    }




    static if(!is(typeof(__fortify_function))) {
        private enum enumMixinStr___fortify_function = `enum __fortify_function = extern __inline __attribute__ ( ( __always_inline__ ) ) __attribute__ ( ( __gnu_inline__ ) ) ;`;
        static if(is(typeof({ mixin(enumMixinStr___fortify_function); }))) {
            mixin(enumMixinStr___fortify_function);
        }
    }




    static if(!is(typeof(__restrict_arr))) {
        private enum enumMixinStr___restrict_arr = `enum __restrict_arr = __restrict;`;
        static if(is(typeof({ mixin(enumMixinStr___restrict_arr); }))) {
            mixin(enumMixinStr___restrict_arr);
        }
    }
    static if(!is(typeof(__HAVE_GENERIC_SELECTION))) {
        private enum enumMixinStr___HAVE_GENERIC_SELECTION = `enum __HAVE_GENERIC_SELECTION = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___HAVE_GENERIC_SELECTION); }))) {
            mixin(enumMixinStr___HAVE_GENERIC_SELECTION);
        }
    }






    static if(!is(typeof(_SYS_SELECT_H))) {
        private enum enumMixinStr__SYS_SELECT_H = `enum _SYS_SELECT_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__SYS_SELECT_H); }))) {
            mixin(enumMixinStr__SYS_SELECT_H);
        }
    }






    static if(!is(typeof(__NFDBITS))) {
        private enum enumMixinStr___NFDBITS = `enum __NFDBITS = ( 8 * cast( int ) ( __fd_mask ) .sizeof );`;
        static if(is(typeof({ mixin(enumMixinStr___NFDBITS); }))) {
            mixin(enumMixinStr___NFDBITS);
        }
    }
    static if(!is(typeof(FD_SETSIZE))) {
        private enum enumMixinStr_FD_SETSIZE = `enum FD_SETSIZE = 1024;`;
        static if(is(typeof({ mixin(enumMixinStr_FD_SETSIZE); }))) {
            mixin(enumMixinStr_FD_SETSIZE);
        }
    }




    static if(!is(typeof(NFDBITS))) {
        private enum enumMixinStr_NFDBITS = `enum NFDBITS = ( 8 * cast( int ) ( __fd_mask ) .sizeof );`;
        static if(is(typeof({ mixin(enumMixinStr_NFDBITS); }))) {
            mixin(enumMixinStr_NFDBITS);
        }
    }
    static if(!is(typeof(_SYS_TYPES_H))) {
        private enum enumMixinStr__SYS_TYPES_H = `enum _SYS_TYPES_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__SYS_TYPES_H); }))) {
            mixin(enumMixinStr__SYS_TYPES_H);
        }
    }
    static if(!is(typeof(__BIT_TYPES_DEFINED__))) {
        private enum enumMixinStr___BIT_TYPES_DEFINED__ = `enum __BIT_TYPES_DEFINED__ = 1;`;
        static if(is(typeof({ mixin(enumMixinStr___BIT_TYPES_DEFINED__); }))) {
            mixin(enumMixinStr___BIT_TYPES_DEFINED__);
        }
    }
    static if(!is(typeof(_TIME_H))) {
        private enum enumMixinStr__TIME_H = `enum _TIME_H = 1;`;
        static if(is(typeof({ mixin(enumMixinStr__TIME_H); }))) {
            mixin(enumMixinStr__TIME_H);
        }
    }






    static if(!is(typeof(TIME_UTC))) {
        private enum enumMixinStr_TIME_UTC = `enum TIME_UTC = 1;`;
        static if(is(typeof({ mixin(enumMixinStr_TIME_UTC); }))) {
            mixin(enumMixinStr_TIME_UTC);
        }
    }
    static if(!is(typeof(NULL))) {
        private enum enumMixinStr_NULL = `enum NULL = ( cast( void * ) 0 );`;
        static if(is(typeof({ mixin(enumMixinStr_NULL); }))) {
            mixin(enumMixinStr_NULL);
        }
    }



}
