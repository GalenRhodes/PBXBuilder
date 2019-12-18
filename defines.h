#define ABS(a) ({__typeof__(a) _ABS_a = (a); _ABS_a < 0 ? -_ABS_a : _ABS_a; })
#define AF_ALG PF_ALG
#define AF_APPLETALK PF_APPLETALK
#define AF_ASH PF_ASH
#define AF_ATMPVC PF_ATMPVC
#define AF_ATMSVC PF_ATMSVC
#define AF_AX25 PF_AX25
#define AF_BLUETOOTH PF_BLUETOOTH
#define AF_BRIDGE PF_BRIDGE
#define AF_CAIF PF_CAIF
#define AF_CAN PF_CAN
#define AF_DECnet PF_DECnet
#define AF_ECONET PF_ECONET
#define AF_FILE PF_FILE
#define AF_IB PF_IB
#define AF_IEEE802154 PF_IEEE802154
#define AF_INET PF_INET
#define AF_INET6 PF_INET6
#define AF_IPX PF_IPX
#define AF_IRDA PF_IRDA
#define AF_ISDN PF_ISDN
#define AF_IUCV PF_IUCV
#define AF_KCM PF_KCM
#define AF_KEY PF_KEY
#define AF_LLC PF_LLC
#define AF_LOCAL PF_LOCAL
#define AF_MAX PF_MAX
#define AF_MPLS PF_MPLS
#define AF_NETBEUI PF_NETBEUI
#define AF_NETLINK PF_NETLINK
#define AF_NETROM PF_NETROM
#define AF_NFC PF_NFC
#define AF_PACKET PF_PACKET
#define AF_PHONET PF_PHONET
#define AF_PPPOX PF_PPPOX
#define AF_QIPCRTR PF_QIPCRTR
#define AF_RDS PF_RDS
#define AF_ROSE PF_ROSE
#define AF_ROUTE PF_ROUTE
#define AF_RXRPC PF_RXRPC
#define AF_SECURITY PF_SECURITY
#define AF_SMC PF_SMC
#define AF_SNA PF_SNA
#define AF_TIPC PF_TIPC
#define AF_UNIX PF_UNIX
#define AF_UNSPEC PF_UNSPEC
#define AF_VSOCK PF_VSOCK
#define AF_WANPIPE PF_WANPIPE
#define AF_X25 PF_X25
#define AIO_PRIO_DELTA_MAX 20
#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define API_AVAILABLE(...)
#define API_DEPRECATED(...)
#define API_DEPRECATED_WITH_REPLACEMENT(...)
#define API_UNAVAILABLE(...)
#define APPKIT_DECLARE
#define APPKIT_EXPORT APPKIT_EXTERN
#define APPKIT_EXTERN extern
#define ASSIGN(object, value) object = (value)
#define ASSIGNCOPY(object, value) object = [(value) copy]
#define AT_EACCESS 0x200
#define AT_FDCWD -100
#define AT_REMOVEDIR 0x200
#define AT_SYMLINK_FOLLOW 0x400
#define AT_SYMLINK_NOFOLLOW 0x100
#define AUTORELEASE(object) (object)
#define BASE_NATIVE_OBJC_EXCEPTIONS 1
#define BC_BASE_MAX _POSIX2_BC_BASE_MAX
#define BC_DIM_MAX _POSIX2_BC_DIM_MAX
#define BC_SCALE_MAX _POSIX2_BC_SCALE_MAX
#define BC_STRING_MAX _POSIX2_BC_STRING_MAX
#define BEZIERPATH_H
#define BIG_ENDIAN __BIG_ENDIAN
#define BLOCKS_EXPORT extern
#define BLOCK_SCOPE __block
#define BUFSIZ _IO_BUFSIZ
#define BUS_ADRALN BUS_ADRALN
#define BUS_ADRERR BUS_ADRERR
#define BUS_MCEERR_AO BUS_MCEERR_AO
#define BUS_MCEERR_AR BUS_MCEERR_AR
#define BUS_OBJERR BUS_OBJERR
#define BYTE_ORDER __BYTE_ORDER
#define Block_copy(x) ((__typeof(x))_Block_copy((const void *)(x)))
#define Block_release(x) _Block_release((const void *)(x))
#define CALL_BLOCK(block, args, ...) block(args, ## __VA_ARGS__)
#define CALL_BLOCK_NO_ARGS(block) block()
#define CANBSIZ MAX_CANON
#define CGFLOAT_DEFINED 1
#define CGFLOAT_IS_DBL 1
#define CGFLOAT_MAX DBL_MAX
#define CGFLOAT_MIN DBL_MIN
#define CHARCLASS_NAME_MAX 2048
#define CHAR_BIT __CHAR_BIT__
#define CHAR_MAX __SCHAR_MAX__
#define CHAR_MIN SCHAR_MIN
#define CHECK_INDEX_RANGE_ERROR(INDEX, OVER) if ((NSUInteger)INDEX >= (NSUInteger)OVER) [NSException raise: NSRangeException format: @"in %s, index %" PRIuPTR " is out of range", GSNameFromSelector(_cmd), (NSUInteger)INDEX]
#define CLD_CONTINUED CLD_CONTINUED
#define CLD_DUMPED CLD_DUMPED
#define CLD_EXITED CLD_EXITED
#define CLD_KILLED CLD_KILLED
#define CLD_STOPPED CLD_STOPPED
#define CLD_TRAPPED CLD_TRAPPED
#define CLOCKS_PER_SEC ((__clock_t) 1000000)
#define CLOCK_BOOTTIME 7
#define CLOCK_BOOTTIME_ALARM 9
#define CLOCK_MONOTONIC 1
#define CLOCK_MONOTONIC_COARSE 6
#define CLOCK_MONOTONIC_RAW 4
#define CLOCK_PROCESS_CPUTIME_ID 2
#define CLOCK_REALTIME 0
#define CLOCK_REALTIME_ALARM 8
#define CLOCK_REALTIME_COARSE 5
#define CLOCK_TAI 11
#define CLOCK_THREAD_CPUTIME_ID 3
#define CMSG_ALIGN(len) (((len) + sizeof (size_t) - 1) & (size_t) ~(sizeof (size_t) - 1))
#define CMSG_DATA(cmsg) ((cmsg)->__cmsg_data)
#define CMSG_FIRSTHDR(mhdr) ((size_t) (mhdr)->msg_controllen >= sizeof (struct cmsghdr) ? (struct cmsghdr *) (mhdr)->msg_control : (struct cmsghdr *) 0)
#define CMSG_LEN(len) (CMSG_ALIGN (sizeof (struct cmsghdr)) + (len))
#define CMSG_NXTHDR(mhdr, cmsg) __cmsg_nxthdr (mhdr, cmsg)
#define CMSG_SPACE(len) (CMSG_ALIGN (len) + CMSG_ALIGN (sizeof (struct cmsghdr)))
#define COLL_WEIGHTS_MAX 255
#define CREATE_AUTORELEASE_POOL(X) NSAutoreleasePool *X = [NSAutoreleasePool new]
#define DBL_DECIMAL_DIG __DBL_DECIMAL_DIG__
#define DBL_DIG __DBL_DIG__
#define DBL_EPSILON __DBL_EPSILON__
#define DBL_HAS_SUBNORM __DBL_HAS_DENORM__
#define DBL_MANT_DIG __DBL_MANT_DIG__
#define DBL_MAX __DBL_MAX__
#define DBL_MAX_10_EXP __DBL_MAX_10_EXP__
#define DBL_MAX_EXP __DBL_MAX_EXP__
#define DBL_MIN __DBL_MIN__
#define DBL_MIN_10_EXP __DBL_MIN_10_EXP__
#define DBL_MIN_EXP __DBL_MIN_EXP__
#define DBL_TRUE_MIN __DBL_DENORM_MIN__
#define DEALLOC
#define DECIMAL_DIG __DECIMAL_DIG__
#define DEFCTXT GSCurrentContext()
#define DEFINE_BLOCK_TYPE(name, retTy, argTys, ...) typedef retTy(^name)(argTys, ## __VA_ARGS__)
#define DEFINE_BLOCK_TYPE_NO_ARGS(name, retTy) typedef retTy(^name)()
#define DELAYTIMER_MAX 2147483647
#define DESTROY(object) object = nil
#define DEV_BSIZE 512
#define DISPATCH_ALIAS_V2(sym)
#define DISPATCH_ALWAYS_INLINE __attribute__((__always_inline__))
#define DISPATCH_API_VERSION 20180109
#define DISPATCH_APPLY_AUTO ((dispatch_queue_t _Nonnull)0)
#define DISPATCH_APPLY_AUTO_AVAILABLE 1
#define DISPATCH_APPLY_QUEUE_ARG_NULLABILITY _Nullable
#define DISPATCH_ASSUME_NONNULL_BEGIN _Pragma("clang assume_nonnull begin")
#define DISPATCH_ASSUME_NONNULL_END _Pragma("clang assume_nonnull end")
#define DISPATCH_COLD __attribute__((__cold__))
#define DISPATCH_COMPILER_CAN_ASSUME(expr) __builtin_assume(expr)
#define DISPATCH_CONST __attribute__((__const__))
#define DISPATCH_CURRENT_QUEUE_LABEL NULL
#define DISPATCH_DATA_DECL(name) DISPATCH_DECL(name)
#define DISPATCH_DATA_DESTRUCTOR_DEFAULT NULL
#define DISPATCH_DATA_DESTRUCTOR_FREE (_dispatch_data_destructor_free)
#define DISPATCH_DATA_DESTRUCTOR_MUNMAP (_dispatch_data_destructor_munmap)
#define DISPATCH_DATA_DESTRUCTOR_TYPE_DECL(name) DISPATCH_EXPORT const dispatch_block_t _dispatch_data_destructor_##name
#define DISPATCH_DECL(name) typedef struct name##_s *name##_t
#define DISPATCH_DECL_SUBCLASS(name, base) typedef base##_t name##_t
#define DISPATCH_ENUM(name, type, ...) typedef enum : type { __VA_ARGS__ } name##_t
#define DISPATCH_ENUM_API_AVAILABLE(...) API_AVAILABLE(__VA_ARGS__)
#define DISPATCH_ENUM_API_DEPRECATED(...) API_DEPRECATED(__VA_ARGS__)
#define DISPATCH_ENUM_API_DEPRECATED_WITH_REPLACEMENT(...) API_DEPRECATED_WITH_REPLACEMENT(__VA_ARGS__)
#define DISPATCH_EXPECT(x, v) __builtin_expect((x), (v))
#define DISPATCH_EXPORT extern __attribute__((visibility("default")))
#define DISPATCH_FALLTHROUGH
#define DISPATCH_FREEBSD_UNAVAILABLE()
#define DISPATCH_GLOBAL_OBJECT(type, object) ((type)&(object))
#define DISPATCH_INLINE static __inline__
#define DISPATCH_IO_RANDOM 1
#define DISPATCH_IO_STOP 0x1
#define DISPATCH_IO_STREAM 0
#define DISPATCH_IO_STRICT_INTERVAL 0x1
#define DISPATCH_LINUX_UNAVAILABLE() DISPATCH_UNAVAILABLE_MSG( "This interface is unavailable on linux systems")
#define DISPATCH_MACH_SEND_DEAD 0x1
#define DISPATCH_MALLOC __attribute__((__malloc__))
#define DISPATCH_MEMORYPRESSURE_CRITICAL 0x04
#define DISPATCH_MEMORYPRESSURE_NORMAL 0x01
#define DISPATCH_MEMORYPRESSURE_WARN 0x02
#define DISPATCH_NOESCAPE __attribute__((__noescape__))
#define DISPATCH_NONNULL1 __attribute__((__nonnull__(1)))
#define DISPATCH_NONNULL2 __attribute__((__nonnull__(2)))
#define DISPATCH_NONNULL3 __attribute__((__nonnull__(3)))
#define DISPATCH_NONNULL4 __attribute__((__nonnull__(4)))
#define DISPATCH_NONNULL5 __attribute__((__nonnull__(5)))
#define DISPATCH_NONNULL6 __attribute__((__nonnull__(6)))
#define DISPATCH_NONNULL7 __attribute__((__nonnull__(7)))
#define DISPATCH_NONNULL_ALL __attribute__((__nonnull__))
#define DISPATCH_NORETURN __attribute__((__noreturn__))
#define DISPATCH_NOTHROW __attribute__((__nothrow__))
#define DISPATCH_NOT_TAIL_CALLED __attribute__((__not_tail_called__))
#define DISPATCH_ONCE_INLINE_FASTPATH 1
#define DISPATCH_PROC_EXEC 0x20000000
#define DISPATCH_PROC_EXIT 0x80000000
#define DISPATCH_PROC_FORK 0x40000000
#define DISPATCH_PROC_SIGNAL 0x08000000
#define DISPATCH_PURE __attribute__((__pure__))
#define DISPATCH_QUEUE_CONCURRENT DISPATCH_GLOBAL_OBJECT(dispatch_queue_attr_t, _dispatch_queue_attr_concurrent)
#define DISPATCH_QUEUE_CONCURRENT_INACTIVE dispatch_queue_attr_make_initially_inactive(DISPATCH_QUEUE_CONCURRENT)
#define DISPATCH_QUEUE_CONCURRENT_WITH_AUTORELEASE_POOL dispatch_queue_attr_make_with_autorelease_frequency( DISPATCH_QUEUE_CONCURRENT, DISPATCH_AUTORELEASE_FREQUENCY_WORK_ITEM)
#define DISPATCH_QUEUE_PRIORITY_BACKGROUND INT16_MIN
#define DISPATCH_QUEUE_PRIORITY_DEFAULT 0
#define DISPATCH_QUEUE_PRIORITY_HIGH 2
#define DISPATCH_QUEUE_PRIORITY_LOW (-2)
#define DISPATCH_QUEUE_SERIAL NULL
#define DISPATCH_QUEUE_SERIAL_INACTIVE dispatch_queue_attr_make_initially_inactive(DISPATCH_QUEUE_SERIAL)
#define DISPATCH_QUEUE_SERIAL_WITH_AUTORELEASE_POOL dispatch_queue_attr_make_with_autorelease_frequency( DISPATCH_QUEUE_SERIAL, DISPATCH_AUTORELEASE_FREQUENCY_WORK_ITEM)
#define DISPATCH_REFINED_FOR_SWIFT
#define DISPATCH_RETURNS_RETAINED
#define DISPATCH_RETURNS_RETAINED_BLOCK __attribute__((__ns_returns_retained__))
#define DISPATCH_SENTINEL __attribute__((__sentinel__))
#define DISPATCH_SOURCE_DECL(name) DISPATCH_DECL(name);
#define DISPATCH_SOURCE_TYPE_DATA_ADD (&_dispatch_source_type_data_add)
#define DISPATCH_SOURCE_TYPE_DATA_OR (&_dispatch_source_type_data_or)
#define DISPATCH_SOURCE_TYPE_DATA_REPLACE (&_dispatch_source_type_data_replace)
#define DISPATCH_SOURCE_TYPE_DECL(name) DISPATCH_EXPORT const struct dispatch_source_type_s _dispatch_source_type_##name
#define DISPATCH_SOURCE_TYPE_MACH_RECV (&_dispatch_source_type_mach_recv)
#define DISPATCH_SOURCE_TYPE_MACH_SEND (&_dispatch_source_type_mach_send)
#define DISPATCH_SOURCE_TYPE_MEMORYPRESSURE (&_dispatch_source_type_memorypressure)
#define DISPATCH_SOURCE_TYPE_PROC (&_dispatch_source_type_proc)
#define DISPATCH_SOURCE_TYPE_READ (&_dispatch_source_type_read)
#define DISPATCH_SOURCE_TYPE_SIGNAL (&_dispatch_source_type_signal)
#define DISPATCH_SOURCE_TYPE_TIMER (&_dispatch_source_type_timer)
#define DISPATCH_SOURCE_TYPE_VNODE (&_dispatch_source_type_vnode)
#define DISPATCH_SOURCE_TYPE_WRITE (&_dispatch_source_type_write)
#define DISPATCH_SWIFT3_OVERLAY 0
#define DISPATCH_SWIFT3_UNAVAILABLE(_msg)
#define DISPATCH_SWIFT_NAME(_name)
#define DISPATCH_SWIFT_UNAVAILABLE(_msg) __attribute__((__availability__(swift, unavailable, message=_msg)))
#define DISPATCH_TARGET_QUEUE_DEFAULT NULL
#define DISPATCH_TIMER_STRICT 0x1
#define DISPATCH_TIME_FOREVER (~0ull)
#define DISPATCH_TIME_NOW (0ull)
#define DISPATCH_TRANSPARENT_UNION __attribute__((__transparent_union__))
#define DISPATCH_UNAVAILABLE __attribute__((__unavailable__))
#define DISPATCH_UNAVAILABLE_MSG(msg) __attribute__((__unavailable__(msg)))
#define DISPATCH_VNODE_ATTRIB 0x8
#define DISPATCH_VNODE_DELETE 0x1
#define DISPATCH_VNODE_EXTEND 0x4
#define DISPATCH_VNODE_FUNLOCK 0x100
#define DISPATCH_VNODE_LINK 0x10
#define DISPATCH_VNODE_RENAME 0x20
#define DISPATCH_VNODE_REVOKE 0x40
#define DISPATCH_VNODE_WRITE 0x2
#define DISPATCH_WARN_RESULT __attribute__((__warn_unused_result__))
#define DLog(...)
#define E2BIG 7
#define EACCES 13
#define EADDRINUSE 98
#define EADDRNOTAVAIL 99
#define EADV 68
#define EAFNOSUPPORT 97
#define EAGAIN 11
#define EALREADY 114
#define EBADE 52
#define EBADF 9
#define EBADFD 77
#define EBADMSG 74
#define EBADR 53
#define EBADRQC 56
#define EBADSLT 57
#define EBFONT 59
#define EBUSY 16
#define ECANCELED 125
#define ECHILD 10
#define ECHRNG 44
#define ECOMM 70
#define ECONNABORTED 103
#define ECONNREFUSED 111
#define ECONNRESET 104
#define EDEADLK 35
#define EDEADLOCK EDEADLK
#define EDESTADDRREQ 89
#define EDOM 33
#define EDOTDOT 73
#define EDQUOT 122
#define EEXIST 17
#define EFAULT 14
#define EFBIG 27
#define EHOSTDOWN 112
#define EHOSTUNREACH 113
#define EHWPOISON 133
#define EIDRM 43
#define EILSEQ 84
#define EINPROGRESS 115
#define EINTR 4
#define EINVAL 22
#define EIO 5
#define EISCONN 106
#define EISDIR 21
#define EISNAM 120
#define EKEYEXPIRED 127
#define EKEYREJECTED 129
#define EKEYREVOKED 128
#define EL2HLT 51
#define EL2NSYNC 45
#define EL3HLT 46
#define EL3RST 47
#define ELIBACC 79
#define ELIBBAD 80
#define ELIBEXEC 83
#define ELIBMAX 82
#define ELIBSCN 81
#define ELNRNG 48
#define ELOOP 40
#define EMEDIUMTYPE 124
#define EMFILE 24
#define EMLINK 31
#define EMSGSIZE 90
#define EMULTIHOP 72
#define ENAMETOOLONG 36
#define ENAVAIL 119
#define ENETDOWN 100
#define ENETRESET 102
#define ENETUNREACH 101
#define ENFILE 23
#define ENOANO 55
#define ENOBUFS 105
#define ENOCSI 50
#define ENODATA 61
#define ENODEV 19
#define ENOENT 2
#define ENOEXEC 8
#define ENOKEY 126
#define ENOLCK 37
#define ENOLINK 67
#define ENOMEDIUM 123
#define ENOMEM 12
#define ENOMSG 42
#define ENONET 64
#define ENOPKG 65
#define ENOPROTOOPT 92
#define ENOSPC 28
#define ENOSR 63
#define ENOSTR 60
#define ENOSYS 38
#define ENOTBLK 15
#define ENOTCONN 107
#define ENOTDIR 20
#define ENOTEMPTY 39
#define ENOTNAM 118
#define ENOTRECOVERABLE 131
#define ENOTSOCK 88
#define ENOTSUP EOPNOTSUPP
#define ENOTTY 25
#define ENOTUNIQ 76
#define ENTER_POOL @autoreleasepool{do{
#define ENXIO 6
#define EOF (-1)
#define EOPNOTSUPP 95
#define EOVERFLOW 75
#define EOWNERDEAD 130
#define EPERM 1
#define EPFNOSUPPORT 96
#define EPIPE 32
#define EPROTO 71
#define EPROTONOSUPPORT 93
#define EPROTOTYPE 91
#define ERANGE 34
#define EREMCHG 78
#define EREMOTE 66
#define EREMOTEIO 121
#define ERESTART 85
#define ERFKILL 132
#define EROFS 30
#define ESHUTDOWN 108
#define ESOCKTNOSUPPORT 94
#define ESPIPE 29
#define ESRCH 3
#define ESRMNT 69
#define ESTALE 116
#define ESTRPIPE 86
#define ETIME 62
#define ETIMEDOUT 110
#define ETOOMANYREFS 109
#define ETXTBSY 26
#define EUCLEAN 117
#define EUNATCH 49
#define EUSERS 87
#define EWOULDBLOCK EAGAIN
#define EXDEV 18
#define EXEC_PAGESIZE 4096
#define EXFULL 54
#define EXIT_FAILURE 1
#define EXIT_SUCCESS 0
#define EXPR_NEST_MAX _POSIX2_EXPR_NEST_MAX
#define FAPPEND O_APPEND
#define FASYNC O_ASYNC
#define FD_CLOEXEC 1
#define FD_CLR(fd, fdsetp) __FD_CLR (fd, fdsetp)
#define FD_ISSET(fd, fdsetp) __FD_ISSET (fd, fdsetp)
#define FD_SET(fd, fdsetp) __FD_SET (fd, fdsetp)
#define FD_SETSIZE __FD_SETSIZE
#define FD_ZERO(fdsetp) __FD_ZERO (fdsetp)
#define FFSYNC O_FSYNC
#define FILENAME_MAX 4096
#define FIOGETOWN 0x8903
#define FIOSETOWN 0x8901
#define FLT_DECIMAL_DIG __FLT_DECIMAL_DIG__
#define FLT_DIG __FLT_DIG__
#define FLT_EPSILON __FLT_EPSILON__
#define FLT_EVAL_METHOD __FLT_EVAL_METHOD__
#define FLT_HAS_SUBNORM __FLT_HAS_DENORM__
#define FLT_MANT_DIG __FLT_MANT_DIG__
#define FLT_MAX __FLT_MAX__
#define FLT_MAX_10_EXP __FLT_MAX_10_EXP__
#define FLT_MAX_EXP __FLT_MAX_EXP__
#define FLT_MIN __FLT_MIN__
#define FLT_MIN_10_EXP __FLT_MIN_10_EXP__
#define FLT_MIN_EXP __FLT_MIN_EXP__
#define FLT_RADIX __FLT_RADIX__
#define FLT_ROUNDS (__builtin_flt_rounds())
#define FLT_TRUE_MIN __FLT_DENORM_MIN__
#define FNDELAY O_NDELAY
#define FNONBLOCK O_NONBLOCK
#define FOPEN_MAX 16
#define FOUNDATION_EXPORT GS_EXPORT
#define FPE_FLTDIV FPE_FLTDIV
#define FPE_FLTINV FPE_FLTINV
#define FPE_FLTOVF FPE_FLTOVF
#define FPE_FLTRES FPE_FLTRES
#define FPE_FLTSUB FPE_FLTSUB
#define FPE_FLTUND FPE_FLTUND
#define FPE_INTDIV FPE_INTDIV
#define FPE_INTOVF FPE_INTOVF
#define FP_ILOGB0 (-2147483647 - 1)
#define FP_ILOGBNAN (-2147483647 - 1)
#define FP_INFINITE 1
#define FP_NAN 0
#define FP_NORMAL 4
#define FP_SUBNORMAL 3
#define FP_XSTATE_MAGIC1 0x46505853U
#define FP_XSTATE_MAGIC2 0x46505845U
#define FP_XSTATE_MAGIC2_SIZE sizeof(FP_XSTATE_MAGIC2)
#define FP_ZERO 2
#define F_DUPFD 0
#define F_DUPFD_CLOEXEC 1030
#define F_EXLCK 4
#define F_GETFD 1
#define F_GETFL 3
#define F_GETLK 5
#define F_GETLK64 5
#define F_GETOWN __F_GETOWN
#define F_LOCK 1
#define F_OK 0
#define F_RDLCK 0
#define F_SETFD 2
#define F_SETFL 4
#define F_SETLK 6
#define F_SETLK64 6
#define F_SETLKW 7
#define F_SETLKW64 7
#define F_SETOWN __F_SETOWN
#define F_SHLCK 8
#define F_TEST 3
#define F_TLOCK 2
#define F_ULOCK 0
#define F_UNLCK 2
#define F_WRLCK 1
#define GCC_VERSION (__GNUC__ * 1000 + __GNUC_MINOR__)
#define GNUSTEP 1
#define GNUSTEP_BASE_GCC_VERSION 4.0.0
#define GNUSTEP_BASE_LIBRARY 1
#define GNUSTEP_BASE_MAJOR_VERSION 1
#define GNUSTEP_BASE_MINOR_VERSION 27
#define GNUSTEP_BASE_SUBMINOR_VERSION 0
#define GNUSTEP_BASE_VERSION 1.27.0
#define GNUSTEP_GUI_MAJOR_VERSION 0
#define GNUSTEP_GUI_MINOR_VERSION 28
#define GNUSTEP_GUI_SUBMINOR_VERSION 0
#define GNUSTEP_GUI_VERSION 0.28.0
#define GNUSTEP_NEW_STRING_ABI
#define GNUSTEP_RUNTIME 1
#define GNU_GUI_LIBRARY 1
#define GSApplicationSupportDirectory NSApplicationSupportDirectory
#define GSCTXT NSGraphicsContext
#define GSDIAGNOSE 1
#define GSLocalizedStaticString(key, comment) key
#define GSNOSUPERDEALLOC if (0) [super dealloc]
#define GSNativeChar char
#define GSOnceFLog(format, args...) do { static BOOL beenHere = NO; if (beenHere == NO) { NSString *s = GSDebugFunctionMsg( __PRETTY_FUNCTION__, __FILE__, __LINE__, [NSString stringWithFormat: format, ##args]); beenHere = YES; NSLog(@"%@", s); }} while (0)
#define GSOnceMLog(format, args...) do { static BOOL beenHere = NO; if (beenHere == NO) { NSString *s = GSDebugFunctionMsg( __PRETTY_FUNCTION__, __FILE__, __LINE__, [NSString stringWithFormat: format, ##args]); beenHere = YES; NSLog(@"%@", s); }} while (0)
#define GSREGEXTYPE void
#define GSWARN 1
#define GS_API_LATEST 999999
#define GS_API_MACOSX 100000
#define GS_API_NONE 0
#define GS_API_OPENSTEP 40000
#define GS_API_OSSPEC 10000
#define GS_API_VERSION(ADD, REM) (!defined(GS_GNUSTEP_V) || (GS_GNUSTEP_V >= ADD && GS_GNUSTEP_V < REM))
#define GS_CLANG_MINREQ(maj, min) ((__clang_major__ << 16) + __clang_minor__ >= ((maj) << 16) + (min))
#define GS_CONSUMED(O) gs_consumed(O);
#define GS_DECLARE
#define GS_DEPRECATED_FUNC __attribute__ ((deprecated))
#define GS_EXPORT extern
#define GS_EXPOSE(X) (!GS_NONFRAGILE || defined(EXPOSE_##X##_IVARS))
#define GS_FAKE_MAIN 0
#define GS_GCC_MINREQ(maj, min) 0
#define GS_GENERIC_CLASS(clz, ...) clz<__VA_ARGS__>
#define GS_GENERIC_TYPE(typeRef) GS_GENERIC_TYPE_F(typeRef, id)
#define GS_GENERIC_TYPE_F(typeRef, fallback) typeRef
#define GS_GEOM_ATTR __attribute__((unused))
#define GS_GEOM_SCOPE static inline
#define GS_HAS_DECLARED_PROPERTIES 1
#define GS_HAVE_I128 0
#define GS_HAVE_I64 1
#define GS_HAVE_OBJC_ROOT_CLASS_ATTR 1
#define GS_IMMUTABLE(O) ([O makeImmutable] == YES ? O : AUTORELEASE([O copy]))
#define GS_INITIALIZED_LOCK(IDENT, CLASSNAME) (IDENT != nil ? (id)IDENT : (id)[CLASSNAME newLockAt: &IDENT])
#define GS_LOCALISATION_BUNDLE [NSBundle mainBundle]
#define GS_MAX_OBJECTS_FROM_STACK 128
#define GS_MIXEDABI 0
#define GS_NONFRAGILE 1
#define GS_NORETURN_METHOD __attribute__((__noreturn__))
#define GS_OSX_ADJUST(V) ((V) >= 10000 ? (V) : ((V)/100*10000 + (V)%100*10))
#define GS_PROTOCOLS_HAVE_OPTIONAL 1
#define GS_RANGE_ATTR __attribute__((unused))
#define GS_RANGE_CHECK(RANGE, SIZE) if (RANGE.location > (NSUInteger)SIZE || RANGE.length > ((NSUInteger)SIZE - RANGE.location)) [NSException raise: NSRangeException format: @"in %s, range { %" PRIuPTR ", %" PRIuPTR " } extends beyond size (%" PRIuPTR ")", GSNameFromSelector(_cmd), RANGE.location, RANGE.length, (NSUInteger)SIZE]
#define GS_RANGE_SCOPE static inline
#define GS_ROOT_CLASS __attribute__((objc_root_class))
#define GS_SIZEOF_DOUBLE 8
#define GS_SIZEOF_FLOAT 4
#define GS_SIZEOF_INT 4
#define GS_SIZEOF_LONG 8
#define GS_SIZEOF_LONG_LONG 8
#define GS_SIZEOF_SHORT 2
#define GS_SIZEOF_VOIDP 8
#define GS_UNREACHABLE() __builtin_unreachable()
#define GS_UNUSED_ARG __attribute__((unused))
#define GS_UNUSED_FUNC __attribute__((unused))
#define GS_UNUSED_IVAR __attribute__((unused))
#define GS_USEIDLIST(firstObject, code...) ({ va_list __ap; unsigned int __max = GS_MAX_OBJECTS_FROM_STACK; unsigned int __count = 0; id __buf[__max]; id *__objects = __buf; id __obj = firstObject; va_start(__ap, firstObject); while (__obj != nil && __count < __max) { __objects[__count] = __obj; __obj = va_arg(__ap, id); if (++__count == __max) { while (__obj != nil) { __count++; __obj = va_arg(__ap, id); } } } va_end(__ap); if (__count > __max) { unsigned int __tmp; __objects = (id*)NSZoneMalloc(NSDefaultMallocZone(),__count*sizeof(id)); va_start(__ap, firstObject); __objects[0] = firstObject; for (__tmp = 1; __tmp < __count; __tmp++) { __objects[__tmp] = va_arg(__ap, id); } va_end(__ap); } code; if (__objects != __buf) NSZoneFree (NSDefaultMallocZone(),__objects); })
#define GS_USEIDPAIRLIST(firstObject, code...) ({ va_list __ap; unsigned int __max = GS_MAX_OBJECTS_FROM_STACK; unsigned int __count = 0; id __buf[__max]; id *__objects = __buf; id *__pairs = &__objects[__max/2]; id __obj = firstObject; va_start(__ap, firstObject); while (__obj != nil && __count < __max) { if ((__count % 2) == 0) { __objects[__count/2] = __obj; } else { __pairs[__count/2] = __obj; } __obj = va_arg(__ap, id); if (++__count == __max) { while (__obj != nil) { __count++; __obj = va_arg(__ap, id); } } } if ((__count % 2) == 1) { __pairs[__count/2] = nil; __count++; } va_end(__ap); if (__count > __max) { unsigned int __tmp; __objects = (id*)malloc(__count*sizeof(id)); __pairs = &__objects[__count/2]; __objects[0] = firstObject; va_start(__ap, firstObject); for (__tmp = 1; __tmp < __count; __tmp++) { if ((__tmp % 2) == 0) { __objects[__tmp/2] = va_arg(__ap, id); } else { __pairs[__tmp/2] = va_arg(__ap, id); } } va_end(__ap); } code; if (__objects != __buf) free(__objects); })
#define GS_USE_AVAHI 0
#define GS_USE_GNUTLS 1
#define GS_USE_ICU 1
#define GS_USE_LIBDISPATCH 1
#define GS_USE_LIBDISPATCH_RUNLOOP 1
#define GS_USE_LIBXML 1
#define GS_USE_MDNS 0
#define GS_WITH_GC 0
#define GS_WORDS_BIGENDIAN 0
#define HOST_NAME_MAX 64
#define HUGE_VAL (__builtin_huge_val ())
#define HUGE_VALF (__builtin_huge_valf ())
#define HUGE_VALL (__builtin_huge_vall ())
#define HZ 100
#define IBAction void)__attribute__((ibaction)
#define IBInspectable
#define IBOutlet __attribute__((iboutlet))
#define IBOutletCollection(ClassName) __attribute__((iboutletcollection(ClassName)))
#define IB_DESIGNABLE
#define IF_NO_GC(X)
#define ILL_BADSTK ILL_BADSTK
#define ILL_COPROC ILL_COPROC
#define ILL_ILLADR ILL_ILLADR
#define ILL_ILLOPC ILL_ILLOPC
#define ILL_ILLOPN ILL_ILLOPN
#define ILL_ILLTRP ILL_ILLTRP
#define ILL_PRVOPC ILL_PRVOPC
#define ILL_PRVREG ILL_PRVREG
#define INCLUDED_NSArray_GNUstepBase_h
#define INCLUDED_NSAttributedString_GNUstepBase_h
#define INCLUDED_NSBundle_GNUstepBase_h
#define INCLUDED_NSCalendarDate_GNUstepBase_h
#define INCLUDED_NSData_GNUstepBase_h
#define INCLUDED_NSDebug_GNUstepBase_h
#define INCLUDED_NSFileHandle_GNUstepBase_h
#define INCLUDED_NSLock_GNUstepBase_h
#define INCLUDED_NSMutableString_GNUstepBase_h
#define INCLUDED_NSNumber_GNUstepBase_h
#define INCLUDED_NSObject_GNUstepBase_h
#define INCLUDED_NSProcessInfo_GNUstepBase_h
#define INCLUDED_NSStream_GNUstepBase_h
#define INCLUDED_NSString_GNUstepBase_h
#define INCLUDED_NSTask_GNUstepBase_h
#define INCLUDED_NSThread_GNUstepBase_h
#define INCLUDED_NSURL_GNUstepBase_h
#define INFINITY (__builtin_inff ())
#define INT16_C(c) c
#define INT16_MAX (32767)
#define INT16_MIN (-32767-1)
#define INT32_C(c) c
#define INT32_MAX (2147483647)
#define INT32_MIN (-2147483647-1)
#define INT64_C(c) c ## L
#define INT64_MAX (__INT64_C(9223372036854775807))
#define INT64_MIN (-__INT64_C(9223372036854775807)-1)
#define INT8_C(c) c
#define INT8_MAX (127)
#define INT8_MIN (-128)
#define INTMAX_C(c) c ## L
#define INTMAX_MAX (__INT64_C(9223372036854775807))
#define INTMAX_MIN (-__INT64_C(9223372036854775807)-1)
#define INTPTR_MAX (9223372036854775807L)
#define INTPTR_MIN (-9223372036854775807L-1)
#define INT_FAST16_MAX (9223372036854775807L)
#define INT_FAST16_MIN (-9223372036854775807L-1)
#define INT_FAST32_MAX (9223372036854775807L)
#define INT_FAST32_MIN (-9223372036854775807L-1)
#define INT_FAST64_MAX (__INT64_C(9223372036854775807))
#define INT_FAST64_MIN (-__INT64_C(9223372036854775807)-1)
#define INT_FAST8_MAX (127)
#define INT_FAST8_MIN (-128)
#define INT_LEAST16_MAX (32767)
#define INT_LEAST16_MIN (-32767-1)
#define INT_LEAST32_MAX (2147483647)
#define INT_LEAST32_MIN (-2147483647-1)
#define INT_LEAST64_MAX (__INT64_C(9223372036854775807))
#define INT_LEAST64_MIN (-__INT64_C(9223372036854775807)-1)
#define INT_LEAST8_MAX (127)
#define INT_LEAST8_MIN (-128)
#define INT_MAX __INT_MAX__
#define INT_MIN (-__INT_MAX__ -1)
#define LC_ADDRESS __LC_ADDRESS
#define LC_ADDRESS_MASK (1 << __LC_ADDRESS)
#define LC_ALL __LC_ALL
#define LC_ALL_MASK (LC_CTYPE_MASK | LC_NUMERIC_MASK | LC_TIME_MASK | LC_COLLATE_MASK | LC_MONETARY_MASK | LC_MESSAGES_MASK | LC_PAPER_MASK | LC_NAME_MASK | LC_ADDRESS_MASK | LC_TELEPHONE_MASK | LC_MEASUREMENT_MASK | LC_IDENTIFICATION_MASK )
#define LC_COLLATE __LC_COLLATE
#define LC_COLLATE_MASK (1 << __LC_COLLATE)
#define LC_CTYPE __LC_CTYPE
#define LC_CTYPE_MASK (1 << __LC_CTYPE)
#define LC_GLOBAL_LOCALE ((locale_t) -1L)
#define LC_IDENTIFICATION __LC_IDENTIFICATION
#define LC_IDENTIFICATION_MASK (1 << __LC_IDENTIFICATION)
#define LC_MEASUREMENT __LC_MEASUREMENT
#define LC_MEASUREMENT_MASK (1 << __LC_MEASUREMENT)
#define LC_MESSAGES __LC_MESSAGES
#define LC_MESSAGES_MASK (1 << __LC_MESSAGES)
#define LC_MONETARY __LC_MONETARY
#define LC_MONETARY_MASK (1 << __LC_MONETARY)
#define LC_NAME __LC_NAME
#define LC_NAME_MASK (1 << __LC_NAME)
#define LC_NUMERIC __LC_NUMERIC
#define LC_NUMERIC_MASK (1 << __LC_NUMERIC)
#define LC_PAPER __LC_PAPER
#define LC_PAPER_MASK (1 << __LC_PAPER)
#define LC_TELEPHONE __LC_TELEPHONE
#define LC_TELEPHONE_MASK (1 << __LC_TELEPHONE)
#define LC_TIME __LC_TIME
#define LC_TIME_MASK (1 << __LC_TIME)
#define LDBL_DECIMAL_DIG __LDBL_DECIMAL_DIG__
#define LDBL_DIG __LDBL_DIG__
#define LDBL_EPSILON __LDBL_EPSILON__
#define LDBL_HAS_SUBNORM __LDBL_HAS_DENORM__
#define LDBL_MANT_DIG __LDBL_MANT_DIG__
#define LDBL_MAX __LDBL_MAX__
#define LDBL_MAX_10_EXP __LDBL_MAX_10_EXP__
#define LDBL_MAX_EXP __LDBL_MAX_EXP__
#define LDBL_MIN __LDBL_MIN__
#define LDBL_MIN_10_EXP __LDBL_MIN_10_EXP__
#define LDBL_MIN_EXP __LDBL_MIN_EXP__
#define LDBL_TRUE_MIN __LDBL_DENORM_MIN__
#define LEAVE_POOL }while(0);}
#define LINE_MAX _POSIX2_LINE_MAX
#define LITTLE_ENDIAN __LITTLE_ENDIAN
#define LLONG_MAX __LONG_LONG_MAX__
#define LLONG_MIN (-__LONG_LONG_MAX__-1LL)
#define LOCK_EX 2
#define LOCK_NB 4
#define LOCK_SH 1
#define LOCK_UN 8
#define LOGIN_NAME_MAX 256
#define LONG2PTR(L) (((char*)0)+(L))
#define LONG_MAX __LONG_MAX__
#define LONG_MIN (-__LONG_MAX__ -1L)
#define L_INCR SEEK_CUR
#define L_SET SEEK_SET
#define L_XTND SEEK_END
#define L_ctermid 9
#define L_tmpnam 20
#define MAC_OS_X_VERSION_10_0 1000
#define MAC_OS_X_VERSION_10_1 1010
#define MAC_OS_X_VERSION_10_10 1100
#define MAC_OS_X_VERSION_10_11 1110
#define MAC_OS_X_VERSION_10_12 1120
#define MAC_OS_X_VERSION_10_13 1130
#define MAC_OS_X_VERSION_10_14 1140
#define MAC_OS_X_VERSION_10_2 1020
#define MAC_OS_X_VERSION_10_3 1030
#define MAC_OS_X_VERSION_10_4 1040
#define MAC_OS_X_VERSION_10_5 1050
#define MAC_OS_X_VERSION_10_6 1060
#define MAC_OS_X_VERSION_10_7 1070
#define MAC_OS_X_VERSION_10_8 1080
#define MAC_OS_X_VERSION_10_9 1090
#define MAC_OS_X_VERSION_MAX_ALLOWED GS_API_LATEST
#define MATH_ERREXCEPT 2
#define MATH_ERRNO 1
#define MAX(a, b) (((a)>(b))?(a):(b))
#define MAXHOSTNAMELEN 64
#define MAXPATHLEN PATH_MAX
#define MAXSYMLINKS 20
#define MAX_CANON 255
#define MAX_INPUT 255
#define MB_CUR_MAX (__ctype_get_mb_cur_max ())
#define MB_LEN_MAX 16
#define MIN(a, b) (((a)<(b))?(a):(b))
#define MINSIGSTKSZ 2048
#define MQ_PRIO_MAX 32768
#define MSG_BATCH MSG_BATCH
#define MSG_CMSG_CLOEXEC MSG_CMSG_CLOEXEC
#define MSG_CONFIRM MSG_CONFIRM
#define MSG_CTRUNC MSG_CTRUNC
#define MSG_DONTROUTE MSG_DONTROUTE
#define MSG_DONTWAIT MSG_DONTWAIT
#define MSG_EOR MSG_EOR
#define MSG_ERRQUEUE MSG_ERRQUEUE
#define MSG_FASTOPEN MSG_FASTOPEN
#define MSG_FIN MSG_FIN
#define MSG_MORE MSG_MORE
#define MSG_NOSIGNAL MSG_NOSIGNAL
#define MSG_OOB MSG_OOB
#define MSG_PEEK MSG_PEEK
#define MSG_PROXY MSG_PROXY
#define MSG_RST MSG_RST
#define MSG_SYN MSG_SYN
#define MSG_TRUNC MSG_TRUNC
#define MSG_WAITALL MSG_WAITALL
#define MSG_WAITFORONE MSG_WAITFORONE
#define MSG_ZEROCOPY MSG_ZEROCOPY
#define M_1_PI 0.31830988618379067154
#define M_2_PI 0.63661977236758134308
#define M_2_SQRTPI 1.12837916709551257390
#define M_E 2.7182818284590452354
#define M_LN10 2.30258509299404568402
#define M_LN2 0.69314718055994530942
#define M_LOG10E 0.43429448190325182765
#define M_LOG2E 1.4426950408889634074
#define M_PI 3.14159265358979323846
#define M_PI_2 1.57079632679489661923
#define M_PI_4 0.78539816339744830962
#define M_SQRT1_2 0.70710678118654752440
#define M_SQRT2 1.41421356237309504880
#define NAME_MAX 255
#define NAN (__builtin_nanf (""))
#define NBBY CHAR_BIT
#define NCARGS 131072
#define NFDBITS __NFDBITS
#define NGREG __NGREG
#define NGROUPS NGROUPS_MAX
#define NGROUPS_MAX 65536
#define NO ((BOOL)0)
#define NODEV ((dev_t) -1)
#define NOFILE 256
#define NOGROUP (-1)
#define NO_GNUSTEP 0
#define NSAlertAlternate NSAlertAlternateReturn
#define NSAlertDefault NSAlertDefaultReturn
#define NSAlertOther NSAlertOtherReturn
#define NSAppKitVersionNumber10_0 577
#define NSAppKitVersionNumber10_1 620
#define NSAppKitVersionNumber10_2 663
#define NSAppKitVersionNumber10_2_3 663.6
#define NSAppKitVersionNumber10_3 743
#define NSAppKitVersionNumber10_3_2 743.14
#define NSAppKitVersionNumber10_3_3 743.2
#define NSAppKitVersionNumber10_3_5 743.24
#define NSAppKitVersionNumber10_3_7 743.33
#define NSAppKitVersionNumber10_3_9 743.36
#define NSAppKitVersionNumber10_4 824
#define NSAppKitVersionNumber10_4_1 824.1
#define NSAppKitVersionNumber10_4_3 824.23
#define NSAppKitVersionNumber10_4_4 824.33
#define NSAppKitVersionNumber10_4_7 824.41
#define NSAppKitVersionNumber10_5 949
#define NSAppKitVersionNumber10_5_2 949.27
#define NSAppKitVersionNumber10_5_3 949.33
#define NSAppKitVersionNumber10_6 1038
#define NSAppKitVersionNumber10_7 1138
#define NSAppKitVersionNumber10_7_2 1138.23
#define NSAssert(condition, desc, args...) do { if (!(condition)) { [[NSAssertionHandler currentHandler] handleFailureInMethod: _cmd object: self file: [NSString stringWithUTF8String: __FILE__] lineNumber: __LINE__ description: (desc) , ## args]; } } while(0)
#define NSAssert1(condition, desc, arg1) NSAssert((condition), (desc), (arg1))
#define NSAssert2(condition, desc, arg1, arg2) NSAssert((condition), (desc), (arg1), (arg2))
#define NSAssert3(condition, desc, arg1, arg2, arg3) NSAssert((condition), (desc), (arg1), (arg2), (arg3))
#define NSAssert4(condition, desc, arg1, arg2, arg3, arg4) NSAssert((condition), (desc), (arg1), (arg2), (arg3), (arg4))
#define NSAssert5(condition, desc, arg1, arg2, arg3, arg4, arg5) NSAssert((condition), (desc), (arg1), (arg2), (arg3), (arg4), (arg5))
#define NSAtomicWrite NSDataWritingAtomic
#define NSBSDOperatingSystem GSBSDOperatingSystem
#define NSBeOperatingSystem GSBeOperatingSystem
#define NSBecomingMultiThreaded NSWillBecomeMultiThreadedNotification
#define NSCAssert(condition, desc, args...) do { if (!(condition)) { [[NSAssertionHandler currentHandler] handleFailureInFunction: [NSString stringWithUTF8String: __PRETTY_FUNCTION__] file: [NSString stringWithUTF8String: __FILE__] lineNumber: __LINE__ description: (desc) , ## args]; } } while(0)
#define NSCAssert1(condition, desc, arg1) NSCAssert((condition), (desc), (arg1))
#define NSCAssert2(condition, desc, arg1, arg2) NSCAssert((condition), (desc), (arg1), (arg2))
#define NSCAssert3(condition, desc, arg1, arg2, arg3) NSCAssert((condition), (desc), (arg1), (arg2), (arg3))
#define NSCAssert4(condition, desc, arg1, arg2, arg3, arg4) NSCAssert((condition), (desc), (arg1), (arg2), (arg3), (arg4))
#define NSCAssert5(condition, desc, arg1, arg2, arg3, arg4, arg5) NSCAssert((condition), (desc), (arg1), (arg2), (arg3), (arg4), (arg5))
#define NSCParameterAssert(condition) NSCAssert((condition), @"Invalid parameter not satisfying: %s", #condition)
#define NSCygwinOperatingSystem GSCygwinOperatingSystem
#define NSDebugFLLog(level, format, args...) do { if (GSDebugSet(level) == YES) { NSString *s = GSDebugFunctionMsg( __PRETTY_FUNCTION__, __FILE__, __LINE__, [NSString stringWithFormat: format, ##args]); NSLog(@"%@", s); }} while (0)
#define NSDebugFLog(format, args...) do { if (GSDebugSet(@"dflt") == YES) { NSString *s = GSDebugFunctionMsg( __PRETTY_FUNCTION__, __FILE__, __LINE__, [NSString stringWithFormat: format, ##args]); NSLog(@"%@", s); }} while (0)
#define NSDebugFRLog(object, msg) do { NSString *tag = GSDebugFunctionMsg( __PRETTY_FUNCTION__, __FILE__, __LINE__, msg); GSDebugAllocationTagRecordedObject(object, tag); } while (0)
#define NSDebugLLog(level, format, args...) do { if (GSDebugSet(level) == YES) NSLog(format , ## args); } while (0)
#define NSDebugLog(format, args...) do { if (GSDebugSet(@"dflt") == YES) NSLog(format , ## args); } while (0)
#define NSDebugMLLog(level, format, args...) do { if (GSDebugSet(level) == YES) { NSString *s = GSDebugMethodMsg( self, _cmd, __FILE__, __LINE__, [NSString stringWithFormat: format, ##args]); NSLog(@"%@", s); }} while (0)
#define NSDebugMLog(format, args...) do { if (GSDebugSet(@"dflt") == YES) { NSString *s = GSDebugMethodMsg( self, _cmd, __FILE__, __LINE__, [NSString stringWithFormat: format, ##args]); NSLog(@"%@", s); }} while (0)
#define NSDebugMRLog(object, msg) do { NSString *tag = GSDebugMethodMsg( self, _cmd, __FILE__, __LINE__, msg); GSDebugAllocationTagRecordedObject(object, tag); } while (0)
#define NSDecimalMaxDigit 38
#define NSDecimalMaxSize (16/sizeof(mp_limb_t))
#define NSDecimalNoScale 128
#define NSEC_PER_MSEC 1000000ull
#define NSEC_PER_SEC 1000000000ull
#define NSEC_PER_USEC 1000ull
#define NSGNULinuxOperatingSystem GSGNULinuxOperatingSystem
#define NSIG _NSIG
#define NSINTEGER_DEFINED 1
#define NSIntegerMax INTPTR_MAX
#define NSIntegerMin INTPTR_MIN
#define NSLocalizedString(key, comment) [[NSBundle mainBundle] localizedStringForKey: (key) value: @"" table: nil]
#define NSLocalizedStringFromTable(key, tbl, comment) [[NSBundle mainBundle] localizedStringForKey: (key) value: @"" table: (tbl)]
#define NSLocalizedStringFromTableInBundle(key, tbl, bundle, comment) [bundle localizedStringForKey: (key) value: @"" table: (tbl)]
#define NSMaximumStringLength (INT_MAX-1)
#define NSNotAPointerMapKey ((const void *)0xffffffff)
#define NSNotAnIntMapKey ((const void *)0x80000000)
#define NSParameterAssert(condition) NSAssert((condition), @"Invalid parameter not satisfying: %s", #condition)
#define NSSquareStatusItemLength ((CGFloat) -2.0)
#define NSThreadExiting NSThreadWillExitNotification
#define NSUIntegerMax UINTPTR_MAX
#define NSURLResponseUnknownLength ((long long)-1)
#define NSUpdateWindowsRunLoopOrdering 600000
#define NSUserDefaultsChanged NSUserDefaultsDidChangeNotification
#define NSVariableStatusItemLength ((CGFloat) -1.0)
#define NSWarnFLog(format, args...) do { if (GSDebugSet(@"NoWarn") == NO) { NSString *s = GSDebugFunctionMsg( __PRETTY_FUNCTION__, __FILE__, __LINE__, [NSString stringWithFormat: format, ##args]); NSLog(@"%@", s); }} while (0)
#define NSWarnLog(format, args...) do { if (GSDebugSet(@"NoWarn") == NO) { NSLog(format , ## args); }} while (0)
#define NSWarnMLog(format, args...) do { if (GSDebugSet(@"NoWarn") == NO) { NSString *s = GSDebugFunctionMsg( __PRETTY_FUNCTION__, __FILE__, __LINE__, [NSString stringWithFormat: format, ##args]); NSLog(@"%@", s); }} while (0)
#define NS_ALERTALTERNATE NSAlertAlternateReturn
#define NS_ALERTDEFAULT NSAlertDefaultReturn
#define NS_ALERTERROR NSAlertErrorReturn
#define NS_ALERTOTHER NSAlertOtherReturn
#define NS_ASSUME_NONNULL_BEGIN _Pragma("clang assume_nonnull begin")
#define NS_ASSUME_NONNULL_END _Pragma("clang assume_nonnull end")
#define NS_AUTOMATED_REFCOUNT_UNAVAILABLE __attribute__((unavailable("Not available with automatic reference counting")))
#define NS_AVAILABLE(...)
#define NS_AVAILABLE_MAC(...)
#define NS_CLASS_AVAILABLE(...)
#define NS_CLASS_AVAILABLE_MAC(...)
#define NS_CLASS_DEPRECATED(...)
#define NS_CLASS_DEPRECATED_MAC(...)
#define NS_CONSUMED __attribute__((ns_consumed))
#define NS_CONSUMES_SELF __attribute__((ns_consumes_self))
#define NS_DEPRECATED(...)
#define NS_DEPRECATED_MAC(...)
#define NS_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
#define NS_DURING @try {
#define NS_ENDHANDLER }
#define NS_ENUM(...) _GS_GET_ENUM_MACRO(__VA_ARGS__,_GS_NAMED_ENUM,_GS_ANON_ENUM)(__VA_ARGS__)
#define NS_ENUM_AVAILABLE(...)
#define NS_ENUM_AVAILABLE_MAC(...)
#define NS_ENUM_DEPRECATED(...)
#define NS_ENUM_DEPRECATED_MAC(...)
#define NS_FORMAT_ARGUMENT(A) __attribute__((format_arg(A)))
#define NS_FORMAT_FUNCTION(F, A) __attribute__((format(__NSString__, F, A)))
#define NS_HANDLER } @catch (NSException * localException) {
#define NS_INLINE static __inline__ __attribute__((always_inline))
#define NS_INVOCATION(aClass, message...) ({ id __proxy = [NSInvocation _newProxyForInvocation: aClass]; [__proxy message]; [NSInvocation _returnInvocationAndDestroyProxy: __proxy]; })
#define NS_MESSAGE(target, message...) ({ id __proxy = [NSInvocation _newProxyForMessage: target]; [__proxy message]; [NSInvocation _returnInvocationAndDestroyProxy: __proxy]; })
#define NS_OPTIONS(ty, name) NS_ENUM(ty,name)
#define NS_REQUIRES_NIL_TERMINATION __attribute__((sentinel))
#define NS_RETURNS_NOT_RETAINED __attribute__((ns_returns_not_retained))
#define NS_RETURNS_RETAINED __attribute__((ns_returns_retained))
#define NS_ROOT_CLASS __attribute__((objc_root_class))
#define NS_UNAVAILABLE
#define NS_VALRETURN(val) return (val)
#define NS_VALUERETURN(object, id) return (object)
#define NS_VOIDRETURN return
#define NULL ((void*)0)
#define NXConstantString NSConstantString
#define Nil ((Class)_OBJC_NULL_PTR)
#define OBJC2RUNTIME 1
#define OBJC_ATOMIC_MALLOC(VAR, TYPE, NUM) (OBJC_DEP("OBJC_ATOMIC_MALLOC is deprecated\n"),(VAR) = (TYPE *) malloc ((unsigned)(NUM)*sizeof(TYPE)))
#define OBJC_CALLOC(VAR, TYPE, NUM) (OBJC_DEP("OBJC_CALLOC is deprecated ... use calloc\n"),(VAR) = (TYPE *) calloc ((unsigned)(NUM), sizeof(TYPE)))
#define OBJC_DEP(M) ({ static BOOL beenHere = NO; if (beenHere == NO) { beenHere = YES; fprintf(stderr, "%s:%d %s", __FILE__, __LINE__, (M));}})
#define OBJC_DEPRECATED
#define OBJC_FREE(PTR) (OBJC_DEP("OBJC_FREE is deprecated ... use free\n"), free (PTR))
#define OBJC_GNUSTEP_RUNTIME_UNSUPPORTED(x)
#define OBJC_MALLOC(VAR, TYPE, NUM) (OBJC_DEP("OBJC_MALLOC is deprecated ... use malloc\n"),(VAR) = (TYPE *) malloc ((unsigned)(NUM)*sizeof(TYPE)))
#define OBJC_NEW_PROPERTIES 1
#define OBJC_NONPORTABLE
#define OBJC_PUBLIC
#define OBJC_REALLOC(VAR, TYPE, NUM) (OBJC_DEP("OBJC_REALLOC is deprecated ... use realloc\n"),(VAR) = (TYPE *) realloc ((VAR), (unsigned)(NUM)*sizeof(TYPE)))
#define OBJC_SMALL_OBJECT_MASK 7
#define OBJC_SMALL_OBJECT_SHIFT 3
#define OBJC_STRINGIFY(s) OBJC_XSTRINGIFY(s)
#define OBJC_VALLOC(VAR, TYPE, NUM) (OBJC_DEP("OBJC_VALLOC is deprecated\n"),(VAR) = (TYPE *) valloc ((unsigned)(NUM)*sizeof(TYPE)))
#define OBJC_XSTRINGIFY(s) @#s
#define OBJC_ZEROCOST_EXCEPTIONS 1
#define OSTYPE_DECLARED
#define OS_API_VERSION(ADD, REM) (!defined(GS_OPENSTEP_V) || (GS_OPENSTEP_V>=GS_OSX_ADJUST(ADD) && GS_OPENSTEP_V<GS_OSX_ADJUST(REM)))
#define OS_ASSUME_NONNULL_BEGIN _Pragma("clang assume_nonnull begin")
#define OS_ASSUME_NONNULL_END _Pragma("clang assume_nonnull end")
#define OS_COMPILER_CAN_ASSUME(expr) __builtin_assume(expr)
#define OS_CONCAT(x, y) __OS_CONCAT(x, y)
#define OS_ENUM(_name, _type, ...) typedef enum : _type { __VA_ARGS__ } _name##_t
#define OS_EXPECT(x, v) __builtin_expect((x), (v))
#define OS_EXPORT
#define OS_NOTHROW
#define OS_OBJECT_BRIDGE
#define OS_OBJECT_CONSUMED
#define OS_OBJECT_DECL_CLASS(name) typedef struct name##_s *name##_t
#define OS_OBJECT_GLOBAL_OBJECT(type, object) ((OS_OBJECT_BRIDGE type)&(object))
#define OS_OBJECT_HAVE_OBJC_SUPPORT 0
#define OS_OBJECT_OBJC_RUNTIME_VISIBLE
#define OS_OBJECT_RETURNS_RETAINED
#define OS_OBJECT_SWIFT3 0
#define OS_OBJECT_USE_OBJC 0
#define OS_OBJECT_USE_OBJC_RETAIN_RELEASE 0
#define OS_REFINED_FOR_SWIFT
#define OS_STRINGIFY(s) __OS_STRINGIFY(s)
#define OS_SWIFT_NAME(_name)
#define OS_SWIFT_UNAVAILABLE(_msg) __attribute__((__availability__(swift, unavailable, message=_msg)))
#define OS_UNUSED __attribute__((__unused__))
#define OS_WARN_RESULT
#define OS_WARN_RESULT_NEEDS_RELEASE OS_WARN_RESULT
#define O_ACCMODE 0003
#define O_APPEND 02000
#define O_ASYNC 020000
#define O_CLOEXEC __O_CLOEXEC
#define O_CREAT 0100
#define O_DIRECTORY __O_DIRECTORY
#define O_DSYNC __O_DSYNC
#define O_EXCL 0200
#define O_FSYNC O_SYNC
#define O_NDELAY O_NONBLOCK
#define O_NOCTTY 0400
#define O_NOFOLLOW __O_NOFOLLOW
#define O_NONBLOCK 04000
#define O_RDONLY 00
#define O_RDWR 02
#define O_RSYNC O_SYNC
#define O_SYNC 04010000
#define O_TRUNC 01000
#define O_WRONLY 01
#define PACKAGE_SCOPE @package
#define PATH_MAX 4096
#define PDP_ENDIAN __PDP_ENDIAN
#define PF_ALG 38
#define PF_APPLETALK 5
#define PF_ASH 18
#define PF_ATMPVC 8
#define PF_ATMSVC 20
#define PF_AX25 3
#define PF_BLUETOOTH 31
#define PF_BRIDGE 7
#define PF_CAIF 37
#define PF_CAN 29
#define PF_DECnet 12
#define PF_ECONET 19
#define PF_FILE PF_LOCAL
#define PF_IB 27
#define PF_IEEE802154 36
#define PF_INET 2
#define PF_INET6 10
#define PF_IPX 4
#define PF_IRDA 23
#define PF_ISDN 34
#define PF_IUCV 32
#define PF_KCM 41
#define PF_KEY 15
#define PF_LLC 26
#define PF_LOCAL 1
#define PF_MAX 44
#define PF_MPLS 28
#define PF_NETBEUI 13
#define PF_NETLINK 16
#define PF_NETROM 6
#define PF_NFC 39
#define PF_PACKET 17
#define PF_PHONET 35
#define PF_PPPOX 24
#define PF_QIPCRTR 42
#define PF_RDS 21
#define PF_ROSE 11
#define PF_ROUTE PF_NETLINK
#define PF_RXRPC 33
#define PF_SECURITY 14
#define PF_SMC 43
#define PF_SNA 22
#define PF_TIPC 30
#define PF_UNIX PF_LOCAL
#define PF_UNSPEC 0
#define PF_VSOCK 40
#define PF_WANPIPE 25
#define PF_X25 9
#define PIPE_BUF 4096
#define POLL_ERR POLL_ERR
#define POLL_HUP POLL_HUP
#define POLL_IN POLL_IN
#define POLL_MSG POLL_MSG
#define POLL_OUT POLL_OUT
#define POLL_PRI POLL_PRI
#define POSIX_FADV_DONTNEED __POSIX_FADV_DONTNEED
#define POSIX_FADV_NOREUSE __POSIX_FADV_NOREUSE
#define POSIX_FADV_NORMAL 0
#define POSIX_FADV_RANDOM 1
#define POSIX_FADV_SEQUENTIAL 2
#define POSIX_FADV_WILLNEED 3
#define PRIX16 "X"
#define PRIX32 "X"
#define PRIX64 __PRI64_PREFIX "X"
#define PRIX8 "X"
#define PRIXFAST16 __PRIPTR_PREFIX "X"
#define PRIXFAST32 __PRIPTR_PREFIX "X"
#define PRIXFAST64 __PRI64_PREFIX "X"
#define PRIXFAST8 "X"
#define PRIXLEAST16 "X"
#define PRIXLEAST32 "X"
#define PRIXLEAST64 __PRI64_PREFIX "X"
#define PRIXLEAST8 "X"
#define PRIXMAX __PRI64_PREFIX "X"
#define PRIXPTR __PRIPTR_PREFIX "X"
#define PRId16 "d"
#define PRId32 "d"
#define PRId64 __PRI64_PREFIX "d"
#define PRId8 "d"
#define PRIdFAST16 __PRIPTR_PREFIX "d"
#define PRIdFAST32 __PRIPTR_PREFIX "d"
#define PRIdFAST64 __PRI64_PREFIX "d"
#define PRIdFAST8 "d"
#define PRIdLEAST16 "d"
#define PRIdLEAST32 "d"
#define PRIdLEAST64 __PRI64_PREFIX "d"
#define PRIdLEAST8 "d"
#define PRIdMAX __PRI64_PREFIX "d"
#define PRIdPTR __PRIPTR_PREFIX "d"
#define PRIi16 "i"
#define PRIi32 "i"
#define PRIi64 __PRI64_PREFIX "i"
#define PRIi8 "i"
#define PRIiFAST16 __PRIPTR_PREFIX "i"
#define PRIiFAST32 __PRIPTR_PREFIX "i"
#define PRIiFAST64 __PRI64_PREFIX "i"
#define PRIiFAST8 "i"
#define PRIiLEAST16 "i"
#define PRIiLEAST32 "i"
#define PRIiLEAST64 __PRI64_PREFIX "i"
#define PRIiLEAST8 "i"
#define PRIiMAX __PRI64_PREFIX "i"
#define PRIiPTR __PRIPTR_PREFIX "i"
#define PRIo16 "o"
#define PRIo32 "o"
#define PRIo64 __PRI64_PREFIX "o"
#define PRIo8 "o"
#define PRIoFAST16 __PRIPTR_PREFIX "o"
#define PRIoFAST32 __PRIPTR_PREFIX "o"
#define PRIoFAST64 __PRI64_PREFIX "o"
#define PRIoFAST8 "o"
#define PRIoLEAST16 "o"
#define PRIoLEAST32 "o"
#define PRIoLEAST64 __PRI64_PREFIX "o"
#define PRIoLEAST8 "o"
#define PRIoMAX __PRI64_PREFIX "o"
#define PRIoPTR __PRIPTR_PREFIX "o"
#define PRIu16 "u"
#define PRIu32 "u"
#define PRIu64 __PRI64_PREFIX "u"
#define PRIu8 "u"
#define PRIuFAST16 __PRIPTR_PREFIX "u"
#define PRIuFAST32 __PRIPTR_PREFIX "u"
#define PRIuFAST64 __PRI64_PREFIX "u"
#define PRIuFAST8 "u"
#define PRIuLEAST16 "u"
#define PRIuLEAST32 "u"
#define PRIuLEAST64 __PRI64_PREFIX "u"
#define PRIuLEAST8 "u"
#define PRIuMAX __PRI64_PREFIX "u"
#define PRIuPTR __PRIPTR_PREFIX "u"
#define PRIx16 "x"
#define PRIx32 "x"
#define PRIx64 __PRI64_PREFIX "x"
#define PRIx8 "x"
#define PRIxFAST16 __PRIPTR_PREFIX "x"
#define PRIxFAST32 __PRIPTR_PREFIX "x"
#define PRIxFAST64 __PRI64_PREFIX "x"
#define PRIxFAST8 "x"
#define PRIxLEAST16 "x"
#define PRIxLEAST32 "x"
#define PRIxLEAST64 __PRI64_PREFIX "x"
#define PRIxLEAST8 "x"
#define PRIxMAX __PRI64_PREFIX "x"
#define PRIxPTR __PRIPTR_PREFIX "x"
#define PTHREAD_DESTRUCTOR_ITERATIONS _POSIX_THREAD_DESTRUCTOR_ITERATIONS
#define PTHREAD_KEYS_MAX 1024
#define PTHREAD_STACK_MIN 16384
#define PTR2LONG(P) (((char*)(P))-(char*)0)
#define PTRDIFF_MAX (9223372036854775807L)
#define PTRDIFF_MIN (-9223372036854775807L-1)
#define P_tmpdir "/tmp"
#define PortBecameInvalidNotification NSPortDidBecomeInvalidNotification
#define RAND_MAX 2147483647
#define RECREATE_AUTORELEASE_POOL(X) DESTROY(X); X = [NSAutoreleasePool new]
#define RELEASE(object)
#define RETAIN(object) (object)
#define RE_DUP_MAX (0x7fff)
#define RTSIG_MAX 32
#define R_OK 4
#define SA_INTERRUPT 0x20000000
#define SA_NOCLDSTOP 1
#define SA_NOCLDWAIT 2
#define SA_NODEFER 0x40000000
#define SA_NOMASK SA_NODEFER
#define SA_ONESHOT SA_RESETHAND
#define SA_ONSTACK 0x08000000
#define SA_RESETHAND 0x80000000
#define SA_RESTART 0x10000000
#define SA_SIGINFO 4
#define SA_STACK SA_ONSTACK
#define SCHAR_MAX __SCHAR_MAX__
#define SCHAR_MIN (-__SCHAR_MAX__-1)
#define SCM_RIGHTS SCM_RIGHTS
#define SCM_TIMESTAMP SO_TIMESTAMP
#define SCM_TIMESTAMPING SO_TIMESTAMPING
#define SCM_TIMESTAMPING_OPT_STATS 54
#define SCM_TIMESTAMPING_PKTINFO 58
#define SCM_TIMESTAMPNS SO_TIMESTAMPNS
#define SCM_WIFI_STATUS SO_WIFI_STATUS
#define SCNd16 "hd"
#define SCNd32 "d"
#define SCNd64 __PRI64_PREFIX "d"
#define SCNd8 "hhd"
#define SCNdFAST16 __PRIPTR_PREFIX "d"
#define SCNdFAST32 __PRIPTR_PREFIX "d"
#define SCNdFAST64 __PRI64_PREFIX "d"
#define SCNdFAST8 "hhd"
#define SCNdLEAST16 "hd"
#define SCNdLEAST32 "d"
#define SCNdLEAST64 __PRI64_PREFIX "d"
#define SCNdLEAST8 "hhd"
#define SCNdMAX __PRI64_PREFIX "d"
#define SCNdPTR __PRIPTR_PREFIX "d"
#define SCNi16 "hi"
#define SCNi32 "i"
#define SCNi64 __PRI64_PREFIX "i"
#define SCNi8 "hhi"
#define SCNiFAST16 __PRIPTR_PREFIX "i"
#define SCNiFAST32 __PRIPTR_PREFIX "i"
#define SCNiFAST64 __PRI64_PREFIX "i"
#define SCNiFAST8 "hhi"
#define SCNiLEAST16 "hi"
#define SCNiLEAST32 "i"
#define SCNiLEAST64 __PRI64_PREFIX "i"
#define SCNiLEAST8 "hhi"
#define SCNiMAX __PRI64_PREFIX "i"
#define SCNiPTR __PRIPTR_PREFIX "i"
#define SCNo16 "ho"
#define SCNo32 "o"
#define SCNo64 __PRI64_PREFIX "o"
#define SCNo8 "hho"
#define SCNoFAST16 __PRIPTR_PREFIX "o"
#define SCNoFAST32 __PRIPTR_PREFIX "o"
#define SCNoFAST64 __PRI64_PREFIX "o"
#define SCNoFAST8 "hho"
#define SCNoLEAST16 "ho"
#define SCNoLEAST32 "o"
#define SCNoLEAST64 __PRI64_PREFIX "o"
#define SCNoLEAST8 "hho"
#define SCNoMAX __PRI64_PREFIX "o"
#define SCNoPTR __PRIPTR_PREFIX "o"
#define SCNu16 "hu"
#define SCNu32 "u"
#define SCNu64 __PRI64_PREFIX "u"
#define SCNu8 "hhu"
#define SCNuFAST16 __PRIPTR_PREFIX "u"
#define SCNuFAST32 __PRIPTR_PREFIX "u"
#define SCNuFAST64 __PRI64_PREFIX "u"
#define SCNuFAST8 "hhu"
#define SCNuLEAST16 "hu"
#define SCNuLEAST32 "u"
#define SCNuLEAST64 __PRI64_PREFIX "u"
#define SCNuLEAST8 "hhu"
#define SCNuMAX __PRI64_PREFIX "u"
#define SCNuPTR __PRIPTR_PREFIX "u"
#define SCNx16 "hx"
#define SCNx32 "x"
#define SCNx64 __PRI64_PREFIX "x"
#define SCNx8 "hhx"
#define SCNxFAST16 __PRIPTR_PREFIX "x"
#define SCNxFAST32 __PRIPTR_PREFIX "x"
#define SCNxFAST64 __PRI64_PREFIX "x"
#define SCNxFAST8 "hhx"
#define SCNxLEAST16 "hx"
#define SCNxLEAST32 "x"
#define SCNxLEAST64 __PRI64_PREFIX "x"
#define SCNxLEAST8 "hhx"
#define SCNxMAX __PRI64_PREFIX "x"
#define SCNxPTR __PRIPTR_PREFIX "x"
#define SEEK_CUR 1
#define SEEK_END 2
#define SEEK_SET 0
#define SEGV_ACCERR SEGV_ACCERR
#define SEGV_BNDERR SEGV_BNDERR
#define SEGV_MAPERR SEGV_MAPERR
#define SEGV_PKUERR SEGV_PKUERR
#define SEM_VALUE_MAX (2147483647)
#define SHRT_MAX __SHRT_MAX__
#define SHRT_MIN (-__SHRT_MAX__ -1)
#define SHUT_RD SHUT_RD
#define SHUT_RDWR SHUT_RDWR
#define SHUT_WR SHUT_WR
#define SIGABRT 6
#define SIGALRM 14
#define SIGBUS 7
#define SIGCHLD 17
#define SIGCLD SIGCHLD
#define SIGCONT 18
#define SIGEV_NONE SIGEV_NONE
#define SIGEV_SIGNAL SIGEV_SIGNAL
#define SIGEV_THREAD SIGEV_THREAD
#define SIGEV_THREAD_ID SIGEV_THREAD_ID
#define SIGFPE 8
#define SIGHUP 1
#define SIGILL 4
#define SIGINT 2
#define SIGIO SIGPOLL
#define SIGIOT SIGABRT
#define SIGKILL 9
#define SIGPIPE 13
#define SIGPOLL 29
#define SIGPROF 27
#define SIGPWR 30
#define SIGQUIT 3
#define SIGRTMAX (__libc_current_sigrtmax ())
#define SIGRTMIN (__libc_current_sigrtmin ())
#define SIGSEGV 11
#define SIGSTKFLT 16
#define SIGSTKSZ 8192
#define SIGSTOP 19
#define SIGSYS 31
#define SIGTERM 15
#define SIGTRAP 5
#define SIGTSTP 20
#define SIGTTIN 21
#define SIGTTOU 22
#define SIGURG 23
#define SIGUSR1 10
#define SIGUSR2 12
#define SIGVTALRM 26
#define SIGWINCH 28
#define SIGXCPU 24
#define SIGXFSZ 25
#define SIG_ATOMIC_MAX (2147483647)
#define SIG_ATOMIC_MIN (-2147483647-1)
#define SIG_BLOCK 0
#define SIG_DFL ((__sighandler_t) 0)
#define SIG_ERR ((__sighandler_t) -1)
#define SIG_IGN ((__sighandler_t) 1)
#define SIG_SETMASK 2
#define SIG_UNBLOCK 1
#define SIOCATMARK 0x8905
#define SIOCGPGRP 0x8904
#define SIOCGSTAMP 0x8906
#define SIOCGSTAMPNS 0x8907
#define SIOCSPGRP 0x8902
#define SIZE_MAX (18446744073709551615UL)
#define SI_ASYNCIO SI_ASYNCIO
#define SI_ASYNCNL SI_ASYNCNL
#define SI_KERNEL SI_KERNEL
#define SI_MESGQ SI_MESGQ
#define SI_QUEUE SI_QUEUE
#define SI_SIGIO SI_SIGIO
#define SI_TIMER SI_TIMER
#define SI_TKILL SI_TKILL
#define SI_USER SI_USER
#define SOCKET int
#define SOCK_CLOEXEC SOCK_CLOEXEC
#define SOCK_DCCP SOCK_DCCP
#define SOCK_DGRAM SOCK_DGRAM
#define SOCK_NONBLOCK SOCK_NONBLOCK
#define SOCK_PACKET SOCK_PACKET
#define SOCK_RAW SOCK_RAW
#define SOCK_RDM SOCK_RDM
#define SOCK_SEQPACKET SOCK_SEQPACKET
#define SOCK_STREAM SOCK_STREAM
#define SOL_AAL 265
#define SOL_ALG 279
#define SOL_ATM 264
#define SOL_BLUETOOTH 274
#define SOL_CAIF 278
#define SOL_DCCP 269
#define SOL_DECNET 261
#define SOL_IRDA 266
#define SOL_IUCV 277
#define SOL_KCM 281
#define SOL_LLC 268
#define SOL_NETBEUI 267
#define SOL_NETLINK 270
#define SOL_NFC 280
#define SOL_PACKET 263
#define SOL_PNPIPE 275
#define SOL_PPPOL2TP 273
#define SOL_RAW 255
#define SOL_RDS 276
#define SOL_RXRPC 272
#define SOL_SOCKET 1
#define SOL_TIPC 271
#define SOL_TLS 282
#define SOL_X25 262
#define SOMAXCONN 128
#define SO_ACCEPTCONN 30
#define SO_ATTACH_BPF 50
#define SO_ATTACH_FILTER 26
#define SO_ATTACH_REUSEPORT_CBPF 51
#define SO_ATTACH_REUSEPORT_EBPF 52
#define SO_BINDTODEVICE 25
#define SO_BPF_EXTENSIONS 48
#define SO_BROADCAST 6
#define SO_BSDCOMPAT 14
#define SO_BUSY_POLL 46
#define SO_CNX_ADVICE 53
#define SO_COOKIE 57
#define SO_DEBUG 1
#define SO_DETACH_BPF SO_DETACH_FILTER
#define SO_DETACH_FILTER 27
#define SO_DOMAIN 39
#define SO_DONTROUTE 5
#define SO_ERROR 4
#define SO_GET_FILTER SO_ATTACH_FILTER
#define SO_INCOMING_CPU 49
#define SO_INCOMING_NAPI_ID 56
#define SO_KEEPALIVE 9
#define SO_LINGER 13
#define SO_LOCK_FILTER 44
#define SO_MARK 36
#define SO_MAX_PACING_RATE 47
#define SO_MEMINFO 55
#define SO_NOFCS 43
#define SO_NO_CHECK 11
#define SO_OOBINLINE 10
#define SO_PASSCRED 16
#define SO_PASSSEC 34
#define SO_PEEK_OFF 42
#define SO_PEERCRED 17
#define SO_PEERGROUPS 59
#define SO_PEERNAME 28
#define SO_PEERSEC 31
#define SO_PRIORITY 12
#define SO_PROTOCOL 38
#define SO_RCVBUF 8
#define SO_RCVBUFFORCE 33
#define SO_RCVLOWAT 18
#define SO_RCVTIMEO 20
#define SO_REUSEADDR 2
#define SO_REUSEPORT 15
#define SO_RXQ_OVFL 40
#define SO_SECURITY_AUTHENTICATION 22
#define SO_SECURITY_ENCRYPTION_NETWORK 24
#define SO_SECURITY_ENCRYPTION_TRANSPORT 23
#define SO_SELECT_ERR_QUEUE 45
#define SO_SNDBUF 7
#define SO_SNDBUFFORCE 32
#define SO_SNDLOWAT 19
#define SO_SNDTIMEO 21
#define SO_TIMESTAMP 29
#define SO_TIMESTAMPING 37
#define SO_TIMESTAMPNS 35
#define SO_TYPE 3
#define SO_WIFI_STATUS 41
#define SO_ZEROCOPY 60
#define SSIZE_MAX LONG_MAX
#define SS_DISABLE SS_DISABLE
#define SS_ONSTACK SS_ONSTACK
#define STDERR_FILENO 2
#define STDIN_FILENO 0
#define STDOUT_FILENO 1
#define STRINGIFY(s) XSTRINGIFY(s)
#define S_IFBLK __S_IFBLK
#define S_IFCHR __S_IFCHR
#define S_IFDIR __S_IFDIR
#define S_IFIFO __S_IFIFO
#define S_IFLNK __S_IFLNK
#define S_IFMT __S_IFMT
#define S_IFREG __S_IFREG
#define S_IFSOCK __S_IFSOCK
#define S_IRGRP (S_IRUSR >> 3)
#define S_IROTH (S_IRGRP >> 3)
#define S_IRUSR __S_IREAD
#define S_IRWXG (S_IRWXU >> 3)
#define S_IRWXO (S_IRWXG >> 3)
#define S_IRWXU (__S_IREAD|__S_IWRITE|__S_IEXEC)
#define S_ISGID __S_ISGID
#define S_ISUID __S_ISUID
#define S_ISVTX __S_ISVTX
#define S_IWGRP (S_IWUSR >> 3)
#define S_IWOTH (S_IWGRP >> 3)
#define S_IWUSR __S_IWRITE
#define S_IXGRP (S_IXUSR >> 3)
#define S_IXOTH (S_IXGRP >> 3)
#define S_IXUSR __S_IEXEC
#define TEST_AUTORELEASE(object) (object)
#define TEST_RELEASE(object)
#define TEST_RETAIN(object) (object)
#define TIMER_ABSTIME 1
#define TIME_UTC 1
#define TMP_MAX 238328
#define TTY_NAME_MAX 32
#define UCHAR_MAX (__SCHAR_MAX__*2 +1)
#define UINT16_C(c) c
#define UINT16_MAX (65535)
#define UINT32_C(c) c ## U
#define UINT32_MAX (4294967295U)
#define UINT64_C(c) c ## UL
#define UINT64_MAX (__UINT64_C(18446744073709551615))
#define UINT8_C(c) c
#define UINT8_MAX (255)
#define UINTMAX_C(c) c ## UL
#define UINTMAX_MAX (__UINT64_C(18446744073709551615))
#define UINTPTR_MAX (18446744073709551615UL)
#define UINT_FAST16_MAX (18446744073709551615UL)
#define UINT_FAST32_MAX (18446744073709551615UL)
#define UINT_FAST64_MAX (__UINT64_C(18446744073709551615))
#define UINT_FAST8_MAX (255)
#define UINT_LEAST16_MAX (65535)
#define UINT_LEAST32_MAX (4294967295U)
#define UINT_LEAST64_MAX (__UINT64_C(18446744073709551615))
#define UINT_LEAST8_MAX (255)
#define UINT_MAX (__INT_MAX__ *2U +1U)
#define ULLONG_MAX (__LONG_LONG_MAX__*2ULL+1ULL)
#define ULONG_MAX (__LONG_MAX__ *2UL+1UL)
#define UNAVAILABLE_ATTRIBUTE __attribute__((unavailable))
#define USEC_PER_SEC 1000000ull
#define USER_NATIVE_OBJC_EXCEPTIONS 1
#define USE_GMP 0
#define USE_ZLIB 1
#define USHRT_MAX (__SHRT_MAX__ *2 +1)
#define UTF32Char uint32_t
#define UTIME_NOW ((1l << 30) - 1l)
#define UTIME_OMIT ((1l << 30) - 2l)
#define VASPRINTF_LENGTH(VASPF_CALL) strlen((VASPF_CALL))
#define VSPRINTF_LENGTH(VSPF_CALL) strlen((VSPF_CALL))
#define WCHAR_MAX __WCHAR_MAX
#define WCHAR_MIN __WCHAR_MIN
#define WCONTINUED 8
#define WEXITED 4
#define WEXITSTATUS(status) __WEXITSTATUS (status)
#define WIFCONTINUED(status) __WIFCONTINUED (status)
#define WIFEXITED(status) __WIFEXITED (status)
#define WIFSIGNALED(status) __WIFSIGNALED (status)
#define WIFSTOPPED(status) __WIFSTOPPED (status)
#define WINT_MAX (4294967295u)
#define WINT_MIN (0u)
#define WNOHANG 1
#define WNOWAIT 0x01000000
#define WSTOPPED 2
#define WSTOPSIG(status) __WSTOPSIG (status)
#define WTERMSIG(status) __WTERMSIG (status)
#define WUNTRACED 2
#define W_OK 2
#define XATTR_LIST_MAX 65536
#define XATTR_NAME_MAX 255
#define XATTR_SIZE_MAX 65536
#define XSTRINGIFY(s) #s
#define X_OK 1
#define YES ((BOOL)1)
#define _(X) [GS_LOCALISATION_BUNDLE localizedStringForKey: (X) value: @"" table: nil]
#define _ALLOCA_H 1
#define _ASM_GENERIC_ERRNO_BASE_H
#define _ASM_GENERIC_ERRNO_H
#define _ASSERT_H 1
#define _ASSERT_H_DECLS
#define _ATFILE_SOURCE 1
#define _BITS_BYTESWAP_H 1
#define _BITS_ERRNO_H 1
#define _BITS_FLOATN_COMMON_H
#define _BITS_FLOATN_H
#define _BITS_G_CONFIG_H 1
#define _BITS_LIBIO_H 1
#define _BITS_LIBM_SIMD_DECL_STUBS_H 1
#define _BITS_LOCALE_H 1
#define _BITS_POSIX1_LIM_H 1
#define _BITS_POSIX2_LIM_H 1
#define _BITS_POSIX_OPT_H 1
#define _BITS_PTHREADTYPES_ARCH_H 1
#define _BITS_PTHREADTYPES_COMMON_H 1
#define _BITS_SETJMP_H 1
#define _BITS_SIGCONTEXT_H 1
#define _BITS_SIGEVENT_CONSTS_H 1
#define _BITS_SIGINFO_ARCH_H 1
#define _BITS_SIGINFO_CONSTS_H 1
#define _BITS_SIGNUM_GENERIC_H 1
#define _BITS_SIGNUM_H 1
#define _BITS_SIGSTACK_H 1
#define _BITS_SIGTHREAD_H 1
#define _BITS_SOCKADDR_H 1
#define _BITS_SS_FLAGS_H 1
#define _BITS_STAT_H 1
#define _BITS_STDINT_INTN_H 1
#define _BITS_STDINT_UINTN_H 1
#define _BITS_STDIO_LIM_H 1
#define _BITS_SYSMACROS_H 1
#define _BITS_TIME_H 1
#define _BITS_TYPESIZES_H 1
#define _BITS_TYPES_H 1
#define _BITS_TYPES_LOCALE_T_H 1
#define _BITS_TYPES___LOCALE_T_H 1
#define _BITS_UINTN_IDENTITY_H 1
#define _BITS_WCHAR_H 1
#define _CS_GNU_LIBC_VERSION _CS_GNU_LIBC_VERSION
#define _CS_GNU_LIBPTHREAD_VERSION _CS_GNU_LIBPTHREAD_VERSION
#define _CS_LFS64_CFLAGS _CS_LFS64_CFLAGS
#define _CS_LFS64_LDFLAGS _CS_LFS64_LDFLAGS
#define _CS_LFS64_LIBS _CS_LFS64_LIBS
#define _CS_LFS64_LINTFLAGS _CS_LFS64_LINTFLAGS
#define _CS_LFS_CFLAGS _CS_LFS_CFLAGS
#define _CS_LFS_LDFLAGS _CS_LFS_LDFLAGS
#define _CS_LFS_LIBS _CS_LFS_LIBS
#define _CS_LFS_LINTFLAGS _CS_LFS_LINTFLAGS
#define _CS_PATH _CS_PATH
#define _CS_POSIX_V5_WIDTH_RESTRICTED_ENVS _CS_V5_WIDTH_RESTRICTED_ENVS
#define _CS_POSIX_V6_ILP32_OFF32_CFLAGS _CS_POSIX_V6_ILP32_OFF32_CFLAGS
#define _CS_POSIX_V6_ILP32_OFF32_LDFLAGS _CS_POSIX_V6_ILP32_OFF32_LDFLAGS
#define _CS_POSIX_V6_ILP32_OFF32_LIBS _CS_POSIX_V6_ILP32_OFF32_LIBS
#define _CS_POSIX_V6_ILP32_OFF32_LINTFLAGS _CS_POSIX_V6_ILP32_OFF32_LINTFLAGS
#define _CS_POSIX_V6_ILP32_OFFBIG_CFLAGS _CS_POSIX_V6_ILP32_OFFBIG_CFLAGS
#define _CS_POSIX_V6_ILP32_OFFBIG_LDFLAGS _CS_POSIX_V6_ILP32_OFFBIG_LDFLAGS
#define _CS_POSIX_V6_ILP32_OFFBIG_LIBS _CS_POSIX_V6_ILP32_OFFBIG_LIBS
#define _CS_POSIX_V6_ILP32_OFFBIG_LINTFLAGS _CS_POSIX_V6_ILP32_OFFBIG_LINTFLAGS
#define _CS_POSIX_V6_LP64_OFF64_CFLAGS _CS_POSIX_V6_LP64_OFF64_CFLAGS
#define _CS_POSIX_V6_LP64_OFF64_LDFLAGS _CS_POSIX_V6_LP64_OFF64_LDFLAGS
#define _CS_POSIX_V6_LP64_OFF64_LIBS _CS_POSIX_V6_LP64_OFF64_LIBS
#define _CS_POSIX_V6_LP64_OFF64_LINTFLAGS _CS_POSIX_V6_LP64_OFF64_LINTFLAGS
#define _CS_POSIX_V6_LPBIG_OFFBIG_CFLAGS _CS_POSIX_V6_LPBIG_OFFBIG_CFLAGS
#define _CS_POSIX_V6_LPBIG_OFFBIG_LDFLAGS _CS_POSIX_V6_LPBIG_OFFBIG_LDFLAGS
#define _CS_POSIX_V6_LPBIG_OFFBIG_LIBS _CS_POSIX_V6_LPBIG_OFFBIG_LIBS
#define _CS_POSIX_V6_LPBIG_OFFBIG_LINTFLAGS _CS_POSIX_V6_LPBIG_OFFBIG_LINTFLAGS
#define _CS_POSIX_V6_WIDTH_RESTRICTED_ENVS _CS_V6_WIDTH_RESTRICTED_ENVS
#define _CS_POSIX_V7_ILP32_OFF32_CFLAGS _CS_POSIX_V7_ILP32_OFF32_CFLAGS
#define _CS_POSIX_V7_ILP32_OFF32_LDFLAGS _CS_POSIX_V7_ILP32_OFF32_LDFLAGS
#define _CS_POSIX_V7_ILP32_OFF32_LIBS _CS_POSIX_V7_ILP32_OFF32_LIBS
#define _CS_POSIX_V7_ILP32_OFF32_LINTFLAGS _CS_POSIX_V7_ILP32_OFF32_LINTFLAGS
#define _CS_POSIX_V7_ILP32_OFFBIG_CFLAGS _CS_POSIX_V7_ILP32_OFFBIG_CFLAGS
#define _CS_POSIX_V7_ILP32_OFFBIG_LDFLAGS _CS_POSIX_V7_ILP32_OFFBIG_LDFLAGS
#define _CS_POSIX_V7_ILP32_OFFBIG_LIBS _CS_POSIX_V7_ILP32_OFFBIG_LIBS
#define _CS_POSIX_V7_ILP32_OFFBIG_LINTFLAGS _CS_POSIX_V7_ILP32_OFFBIG_LINTFLAGS
#define _CS_POSIX_V7_LP64_OFF64_CFLAGS _CS_POSIX_V7_LP64_OFF64_CFLAGS
#define _CS_POSIX_V7_LP64_OFF64_LDFLAGS _CS_POSIX_V7_LP64_OFF64_LDFLAGS
#define _CS_POSIX_V7_LP64_OFF64_LIBS _CS_POSIX_V7_LP64_OFF64_LIBS
#define _CS_POSIX_V7_LP64_OFF64_LINTFLAGS _CS_POSIX_V7_LP64_OFF64_LINTFLAGS
#define _CS_POSIX_V7_LPBIG_OFFBIG_CFLAGS _CS_POSIX_V7_LPBIG_OFFBIG_CFLAGS
#define _CS_POSIX_V7_LPBIG_OFFBIG_LDFLAGS _CS_POSIX_V7_LPBIG_OFFBIG_LDFLAGS
#define _CS_POSIX_V7_LPBIG_OFFBIG_LIBS _CS_POSIX_V7_LPBIG_OFFBIG_LIBS
#define _CS_POSIX_V7_LPBIG_OFFBIG_LINTFLAGS _CS_POSIX_V7_LPBIG_OFFBIG_LINTFLAGS
#define _CS_POSIX_V7_WIDTH_RESTRICTED_ENVS _CS_V7_WIDTH_RESTRICTED_ENVS
#define _CS_V5_WIDTH_RESTRICTED_ENVS _CS_V5_WIDTH_RESTRICTED_ENVS
#define _CS_V6_ENV _CS_V6_ENV
#define _CS_V6_WIDTH_RESTRICTED_ENVS _CS_V6_WIDTH_RESTRICTED_ENVS
#define _CS_V7_ENV _CS_V7_ENV
#define _CS_V7_WIDTH_RESTRICTED_ENVS _CS_V7_WIDTH_RESTRICTED_ENVS
#define _CS_XBS5_ILP32_OFF32_CFLAGS _CS_XBS5_ILP32_OFF32_CFLAGS
#define _CS_XBS5_ILP32_OFF32_LDFLAGS _CS_XBS5_ILP32_OFF32_LDFLAGS
#define _CS_XBS5_ILP32_OFF32_LIBS _CS_XBS5_ILP32_OFF32_LIBS
#define _CS_XBS5_ILP32_OFF32_LINTFLAGS _CS_XBS5_ILP32_OFF32_LINTFLAGS
#define _CS_XBS5_ILP32_OFFBIG_CFLAGS _CS_XBS5_ILP32_OFFBIG_CFLAGS
#define _CS_XBS5_ILP32_OFFBIG_LDFLAGS _CS_XBS5_ILP32_OFFBIG_LDFLAGS
#define _CS_XBS5_ILP32_OFFBIG_LIBS _CS_XBS5_ILP32_OFFBIG_LIBS
#define _CS_XBS5_ILP32_OFFBIG_LINTFLAGS _CS_XBS5_ILP32_OFFBIG_LINTFLAGS
#define _CS_XBS5_LP64_OFF64_CFLAGS _CS_XBS5_LP64_OFF64_CFLAGS
#define _CS_XBS5_LP64_OFF64_LDFLAGS _CS_XBS5_LP64_OFF64_LDFLAGS
#define _CS_XBS5_LP64_OFF64_LIBS _CS_XBS5_LP64_OFF64_LIBS
#define _CS_XBS5_LP64_OFF64_LINTFLAGS _CS_XBS5_LP64_OFF64_LINTFLAGS
#define _CS_XBS5_LPBIG_OFFBIG_CFLAGS _CS_XBS5_LPBIG_OFFBIG_CFLAGS
#define _CS_XBS5_LPBIG_OFFBIG_LDFLAGS _CS_XBS5_LPBIG_OFFBIG_LDFLAGS
#define _CS_XBS5_LPBIG_OFFBIG_LIBS _CS_XBS5_LPBIG_OFFBIG_LIBS
#define _CS_XBS5_LPBIG_OFFBIG_LINTFLAGS _CS_XBS5_LPBIG_OFFBIG_LINTFLAGS
#define _CTYPE_H 1
#define _C_ARY_B '['
#define _C_ARY_E ']'
#define _C_ATOM '%'
#define _C_BFLD 'b'
#define _C_BOOL 'B'
#define _C_BYCOPY 'O'
#define _C_BYREF 'R'
#define _C_CHARPTR '*'
#define _C_CHR 'c'
#define _C_CLASS '#'
#define _C_COMPLEX 'j'
#define _C_CONST 'r'
#define _C_DBL 'd'
#define _C_FLT 'f'
#define _C_GCINVISIBLE '!'
#define _C_ID '@'
#define _C_IN 'n'
#define _C_INOUT 'N'
#define _C_INT 'i'
#define _C_LNG 'l'
#define _C_LNG_LNG 'q'
#define _C_ONEWAY 'V'
#define _C_OUT 'o'
#define _C_PTR '^'
#define _C_SEL ':'
#define _C_SHT 's'
#define _C_STRUCT_B '{'
#define _C_STRUCT_E '}'
#define _C_UCHR 'C'
#define _C_UINT 'I'
#define _C_ULNG 'L'
#define _C_ULNG_LNG 'Q'
#define _C_UNDEF '?'
#define _C_UNION_B '('
#define _C_UNION_E ')'
#define _C_USHT 'S'
#define _C_VECTOR '!'
#define _C_VOID 'v'
#define _DEFAULT_SOURCE 1
#define _DPSOperators_h_INCLUDE
#define _ENDIAN_H 1
#define _ERRNO_H 1
#define _EXTERN_INLINE __extern_inline
#define _FCNTL_H 1
#define _FEATURES_H 1
#define _F_BYCOPY 0x04
#define _F_BYREF 0x08
#define _F_CONST 0x01
#define _F_GCINVISIBLE 0x20
#define _F_IN 0x01
#define _F_INOUT 0x03
#define _F_ONEWAY 0x10
#define _F_OUT 0x02
#define _GCC_LIMITS_H_
#define _GETOPT_CORE_H 1
#define _GETOPT_POSIX_H 1
#define _GNUstep_H_AppKit
#define _GNUstep_H_COCOA
#define _GNUstep_H_GSAnimator_
#define _GNUstep_H_GSLayoutManager
#define _GNUstep_H_GSSoundSink
#define _GNUstep_H_GSSoundSource
#define _GNUstep_H_NSAccessibility
#define _GNUstep_H_NSAccessibilityConstants
#define _GNUstep_H_NSActionCell
#define _GNUstep_H_NSAffineTransform
#define _GNUstep_H_NSAlert
#define _GNUstep_H_NSAnimationContext_
#define _GNUstep_H_NSAnimation_
#define _GNUstep_H_NSApplication
#define _GNUstep_H_NSArrayController
#define _GNUstep_H_NSAttributedString
#define _GNUstep_H_NSBitmapImageRep
#define _GNUstep_H_NSBox
#define _GNUstep_H_NSBrowser
#define _GNUstep_H_NSBrowserCell
#define _GNUstep_H_NSButton
#define _GNUstep_H_NSButtonCell
#define _GNUstep_H_NSCachedImageRep
#define _GNUstep_H_NSCell
#define _GNUstep_H_NSClipView
#define _GNUstep_H_NSCollectionView
#define _GNUstep_H_NSCollectionViewItem
#define _GNUstep_H_NSColor
#define _GNUstep_H_NSColorList
#define _GNUstep_H_NSColorPanel
#define _GNUstep_H_NSColorPicker
#define _GNUstep_H_NSColorPicking
#define _GNUstep_H_NSColorSpace
#define _GNUstep_H_NSColorWell
#define _GNUstep_H_NSComboBox
#define _GNUstep_H_NSComboBoxCell
#define _GNUstep_H_NSControl
#define _GNUstep_H_NSController
#define _GNUstep_H_NSCursor
#define _GNUstep_H_NSCustomImageRep
#define _GNUstep_H_NSDataLink
#define _GNUstep_H_NSDataLinkManager
#define _GNUstep_H_NSDataLinkPanel
#define _GNUstep_H_NSDocument
#define _GNUstep_H_NSDocumentController
#define _GNUstep_H_NSDragging
#define _GNUstep_H_NSDrawer
#define _GNUstep_H_NSEPSImageRep
#define _GNUstep_H_NSEvent
#define _GNUstep_H_NSFileWrapper
#define _GNUstep_H_NSFileWrapper_Extensions
#define _GNUstep_H_NSFont
#define _GNUstep_H_NSFontDescriptor
#define _GNUstep_H_NSFontManager
#define _GNUstep_H_NSFontPanel
#define _GNUstep_H_NSForm
#define _GNUstep_H_NSFormCell
#define _GNUstep_H_NSGestureRecognizer
#define _GNUstep_H_NSGlyphGenerator
#define _GNUstep_H_NSGradient
#define _GNUstep_H_NSHelpPanel
#define _GNUstep_H_NSImage
#define _GNUstep_H_NSImageCell
#define _GNUstep_H_NSImageRep
#define _GNUstep_H_NSImageView
#define _GNUstep_H_NSInputManager
#define _GNUstep_H_NSInputServer
#define _GNUstep_H_NSInterfaceStyle
#define _GNUstep_H_NSKeyValueBinding
#define _GNUstep_H_NSLayoutManager
#define _GNUstep_H_NSLevelIndicator
#define _GNUstep_H_NSLevelIndicatorCell
#define _GNUstep_H_NSMatrix
#define _GNUstep_H_NSMenu
#define _GNUstep_H_NSMenuItem
#define _GNUstep_H_NSMenuItemCell
#define _GNUstep_H_NSMenuView
#define _GNUstep_H_NSMovie
#define _GNUstep_H_NSMovieView
#define _GNUstep_H_NSNib
#define _GNUstep_H_NSNibLoading
#define _GNUstep_H_NSObjectController
#define _GNUstep_H_NSOpenPanel
#define _GNUstep_H_NSOutlineView
#define _GNUstep_H_NSPageLayout
#define _GNUstep_H_NSPanel
#define _GNUstep_H_NSParagraphStyle
#define _GNUstep_H_NSPasteboard
#define _GNUstep_H_NSPasteboardItem
#define _GNUstep_H_NSPopUpButton
#define _GNUstep_H_NSPopUpButtonCell
#define _GNUstep_H_NSPopover
#define _GNUstep_H_NSPrintInfo
#define _GNUstep_H_NSPrintOperation
#define _GNUstep_H_NSPrintPanel
#define _GNUstep_H_NSPrinter
#define _GNUstep_H_NSProgressIndicator
#define _GNUstep_H_NSResponder
#define _GNUstep_H_NSRulerMarker
#define _GNUstep_H_NSRulerView
#define _GNUstep_H_NSRunningApplication
#define _GNUstep_H_NSSavePanel
#define _GNUstep_H_NSScreen
#define _GNUstep_H_NSScrollView
#define _GNUstep_H_NSScroller
#define _GNUstep_H_NSSearchField
#define _GNUstep_H_NSSearchFieldCell
#define _GNUstep_H_NSSecureTextField
#define _GNUstep_H_NSSegmentedCell
#define _GNUstep_H_NSSegmentedControl
#define _GNUstep_H_NSSelection
#define _GNUstep_H_NSShadow
#define _GNUstep_H_NSSlider
#define _GNUstep_H_NSSliderCell
#define _GNUstep_H_NSSound
#define _GNUstep_H_NSSpeechSynthesizer
#define _GNUstep_H_NSSpellChecker
#define _GNUstep_H_NSSpellProtocol
#define _GNUstep_H_NSSpellServer
#define _GNUstep_H_NSSplitView
#define _GNUstep_H_NSStatusBar
#define _GNUstep_H_NSStatusItem
#define _GNUstep_H_NSStepper
#define _GNUstep_H_NSStepperCell
#define _GNUstep_H_NSStringDrawing
#define _GNUstep_H_NSTabView
#define _GNUstep_H_NSTabViewItem
#define _GNUstep_H_NSTableColumn
#define _GNUstep_H_NSTableHeaderCell
#define _GNUstep_H_NSTableHeaderView
#define _GNUstep_H_NSTableView
#define _GNUstep_H_NSText
#define _GNUstep_H_NSTextAlternatives
#define _GNUstep_H_NSTextAttachment
#define _GNUstep_H_NSTextContainer
#define _GNUstep_H_NSTextField
#define _GNUstep_H_NSTextFieldCell
#define _GNUstep_H_NSTextList
#define _GNUstep_H_NSTextStorage
#define _GNUstep_H_NSTextTable
#define _GNUstep_H_NSTextView
#define _GNUstep_H_NSTokenField
#define _GNUstep_H_NSTokenFieldCell
#define _GNUstep_H_NSToolbar
#define _GNUstep_H_NSToolbarItem
#define _GNUstep_H_NSToolbarItemGroup
#define _GNUstep_H_NSTrackingArea
#define _GNUstep_H_NSTreeController
#define _GNUstep_H_NSTreeNode
#define _GNUstep_H_NSUserDefaultsController
#define _GNUstep_H_NSUserInterfaceItemIdentification
#define _GNUstep_H_NSUserInterfaceLayout
#define _GNUstep_H_NSUserInterfaceValidation
#define _GNUstep_H_NSView
#define _GNUstep_H_NSViewController
#define _GNUstep_H_NSWindow
#define _GNUstep_H_NSWindowController
#define _GNUstep_H_NSWorkspace
#define _GSC_ARY_B 0x15
#define _GSC_BOOL 0x0d
#define _GSC_CHARPTR 0x14
#define _GSC_CHR 0x01
#define _GSC_CID 0x17
#define _GSC_CLASS 0x11
#define _GSC_DBL 0x0c
#define _GSC_FLT 0x0b
#define _GSC_I128 0x60
#define _GSC_I16 0x00
#define _GSC_I32 0x20
#define _GSC_I64 0x40
#define _GSC_ID 0x10
#define _GSC_INT 0x05
#define _GSC_LNG 0x07
#define _GSC_LNG_LNG 0x09
#define _GSC_MASK 0x1f
#define _GSC_MAYX 0x10
#define _GSC_NONE 0x00
#define _GSC_PTR 0x13
#define _GSC_SEL 0x12
#define _GSC_SHT 0x03
#define _GSC_SIZE 0x60
#define _GSC_STRUCT_B 0x16
#define _GSC_S_INT _GSC_I32
#define _GSC_S_LNG _GSC_I64
#define _GSC_S_LNG_LNG _GSC_I64
#define _GSC_S_SHT _GSC_I16
#define _GSC_UCHR 0x02
#define _GSC_UINT 0x06
#define _GSC_ULNG 0x08
#define _GSC_ULNG_LNG 0x0a
#define _GSC_USHT 0x04
#define _GSC_XREF 0x80
#define _GSC_X_0 0x00
#define _GSC_X_1 0x20
#define _GSC_X_2 0x40
#define _GSC_X_4 0x60
#define _GSMethodTable_h_INCLUDE
#define _GS_ANON_ENUM(ty) enum : ty
#define _GS_GET_ENUM_MACRO(_first, _second, NAME, ...) NAME
#define _GS_NAMED_ENUM(ty, name) enum name : ty name; enum name : ty
#define _G_BUFSIZ 8192
#define _G_HAVE_MMAP 1
#define _G_HAVE_MREMAP 1
#define _G_HAVE_ST_BLKSIZE defined (_STATBUF_ST_BLKSIZE)
#define _G_IO_IO_FILE_VERSION 0x20001
#define _G_va_list __gnuc_va_list
#define _INTTYPES_H 1
#define _IOFBF 0
#define _IOLBF 1
#define _IONBF 2
#define _IOS_APPEND 8
#define _IOS_ATEND 4
#define _IOS_BIN 128
#define _IOS_INPUT 1
#define _IOS_NOCREATE 32
#define _IOS_NOREPLACE 64
#define _IOS_OUTPUT 2
#define _IOS_TRUNC 16
#define _IO_BAD_SEEN 0x4000
#define _IO_BE(expr, res) __builtin_expect ((expr), res)
#define _IO_BOOLALPHA 0200000
#define _IO_BUFSIZ _G_BUFSIZ
#define _IO_CURRENTLY_PUTTING 0x800
#define _IO_DEC 020
#define _IO_DELETE_DONT_CLOSE 0x40
#define _IO_DONT_CLOSE 0100000
#define _IO_EOF_SEEN 0x10
#define _IO_ERR_SEEN 0x20
#define _IO_FIXED 010000
#define _IO_FLAGS2_MMAP 1
#define _IO_FLAGS2_NOTCANCEL 2
#define _IO_FLAGS2_USER_WBUF 8
#define _IO_HAVE_ST_BLKSIZE _G_HAVE_ST_BLKSIZE
#define _IO_HEX 0100
#define _IO_INTERNAL 010
#define _IO_IN_BACKUP 0x100
#define _IO_IS_APPENDING 0x1000
#define _IO_IS_FILEBUF 0x2000
#define _IO_LEFT 02
#define _IO_LINE_BUF 0x200
#define _IO_LINKED 0x80
#define _IO_MAGIC 0xFBAD0000
#define _IO_MAGIC_MASK 0xFFFF0000
#define _IO_NO_READS 4
#define _IO_NO_WRITES 8
#define _IO_OCT 040
#define _IO_PENDING_OUTPUT_COUNT(_fp) ((_fp)->_IO_write_ptr - (_fp)->_IO_write_base)
#define _IO_RIGHT 04
#define _IO_SCIENTIFIC 04000
#define _IO_SHOWBASE 0200
#define _IO_SHOWPOINT 0400
#define _IO_SHOWPOS 02000
#define _IO_SKIPWS 01
#define _IO_STDIO 040000
#define _IO_TIED_PUT_GET 0x400
#define _IO_UNBUFFERED 2
#define _IO_UNIFIED_JUMPTABLES 1
#define _IO_UNITBUF 020000
#define _IO_UPPERCASE 01000
#define _IO_USER_BUF 1
#define _IO_USER_LOCK 0x8000
#define _IO_cleanup_region_end(_Doit)
#define _IO_cleanup_region_start(_fct, _fp)
#define _IO_feof_unlocked(__fp) (((__fp)->_flags & _IO_EOF_SEEN) != 0)
#define _IO_ferror_unlocked(__fp) (((__fp)->_flags & _IO_ERR_SEEN) != 0)
#define _IO_file_flags _flags
#define _IO_flockfile(_fp)
#define _IO_fpos64_t _G_fpos64_t
#define _IO_fpos_t _G_fpos_t
#define _IO_ftrylockfile(_fp)
#define _IO_funlockfile(_fp)
#define _IO_getc_unlocked(_fp) (_IO_BE ((_fp)->_IO_read_ptr >= (_fp)->_IO_read_end, 0) ? __uflow (_fp) : *(unsigned char *) (_fp)->_IO_read_ptr++)
#define _IO_iconv_t _G_iconv_t
#define _IO_need_lock(_fp) (((_fp)->_flags2 & _IO_FLAGS2_NEED_LOCK) != 0)
#define _IO_off64_t __off64_t
#define _IO_off_t __off_t
#define _IO_peekc(_fp) _IO_peekc_unlocked (_fp)
#define _IO_peekc_unlocked(_fp) (_IO_BE ((_fp)->_IO_read_ptr >= (_fp)->_IO_read_end, 0) && __underflow (_fp) == EOF ? EOF : *(unsigned char *) (_fp)->_IO_read_ptr)
#define _IO_pid_t __pid_t
#define _IO_putc_unlocked(_ch, _fp) (_IO_BE ((_fp)->_IO_write_ptr >= (_fp)->_IO_write_end, 0) ? __overflow (_fp, (unsigned char) (_ch)) : (unsigned char) (*(_fp)->_IO_write_ptr++ = (_ch)))
#define _IO_size_t size_t
#define _IO_ssize_t __ssize_t
#define _IO_stderr ((_IO_FILE*)(&_IO_2_1_stderr_))
#define _IO_stdin ((_IO_FILE*)(&_IO_2_1_stdin_))
#define _IO_stdout ((_IO_FILE*)(&_IO_2_1_stdout_))
#define _IO_uid_t __uid_t
#define _IO_va_list __gnuc_va_list
#define _IO_wint_t wint_t
#define _ISbit(bit) ((bit) < 8 ? ((1 << (bit)) << 8) : ((1 << (bit)) >> 8))
#define _LFS64_ASYNCHRONOUS_IO 1
#define _LFS64_LARGEFILE 1
#define _LFS64_STDIO 1
#define _LFS_ASYNCHRONOUS_IO 1
#define _LFS_LARGEFILE 1
#define _LIBC_LIMITS_H_ 1
#define _LINUX_LIMITS_H
#define _LINUX_PARAM_H
#define _LOCALE_H 1
#define _LP64 1
#define _MATH_H 1
#define _MKNOD_VER_LINUX 0
#define _NATIVE_OBJC_EXCEPTIONS 1
#define _NONFRAGILE_ABI 1
#define _NSAppleEventDescriptor_h_GNUSTEP_BASE_INCLUDE
#define _NSAppleEventManager_h_GNUSTEP_BASE_INCLUDE
#define _NSAppleScript_h_GNUSTEP_BASE_INCLUDE
#define _NSBackgroundActivityScheduler_h_GNUSTEP_BASE_INCLUDE
#define _NSDateIntervalFormatter_h_GNUSTEP_BASE_INCLUDE
#define _NSDateInterval_h_GNUSTEP_BASE_INCLUDE
#define _NSDictionary_h_GNUSTEP_BASE_INCLUDE
#define _NSEnergyFormatter_h_GNUSTEP_BASE_INCLUDE
#define _NSGarbageCollector_h_GNUSTEP_BASE_INCLUDE
#define _NSGraphicsContext_h_INCLUDE
#define _NSHFSFileTypes_h_GNUSTEP_BASE_INCLUDE
#define _NSIG (__SIGRTMAX + 1)
#define _NSISO8601DateFormatter_h_GNUSTEP_BASE_INCLUDE
#define _NSIndexPath_h_GNUSTEP_BASE_INCLUDE
#define _NSIndexSet_h_GNUSTEP_BASE_INCLUDE
#define _NSLengthFormatter_h_GNUSTEP_BASE_INCLUDE
#define _NSLinguisticTagger_h_GNUSTEP_BASE_INCLUDE
#define _NSMeasurementFormatter_h_GNUSTEP_BASE_INCLUDE
#define _NSMeasurement_h_GNUSTEP_BASE_INCLUDE
#define _NSMetadataAttributes_h_GNUSTEP_BASE_INCLUDE
#define _NSNibDeclarations_H_
#define _NSNumberFormatter_h_GNUSTEP_BASE_INCLUDE
#define _NSObjectScripting_h_GNUSTEP_BASE_INCLUDE
#define _NSOpenGLView_h
#define _NSOpenGL_h_INCLUDE
#define _NSOrderedSet_h_GNUSTEP_BASE_INCLUDE
#define _NSOrthography_h_GNUSTEP_BASE_INCLUDE
#define _NSProgress_h_GNUSTEP_BASE_INCLUDE
#define _NSRegularExpression_h_GNUSTEP_BASE_INCLUDE
#define _NSScriptClassDescription_h_GNUSTEP_BASE_INCLUDE
#define _NSScriptCoercionHandler_h_GNUSTEP_BASE_INCLUDE
#define _NSScriptCommandDescription_h_GNUSTEP_BASE_INCLUDE
#define _NSScriptCommand_h_GNUSTEP_BASE_INCLUDE
#define _NSScriptExecutionContext_h_GNUSTEP_BASE_INCLUDE
#define _NSScriptKeyValueCoding_h_GNUSTEP_BASE_INCLUDE
#define _NSScriptObjectSpecifiers_h_GNUSTEP_BASE_INCLUDE
#define _NSScriptStandardSuiteCommands_h_GNUSTEP_BASE_INCLUDE
#define _NSScriptSuiteRegistry_h_GNUSTEP_BASE_INCLUDE
#define _NSSet_h_GNUSTEP_BASE_INCLUDE
#define _NSUbiquitousKeyValueStore_h_GNUSTEP_BASE_INCLUDE
#define _NSUnit_h_GNUSTEP_BASE_INCLUDE
#define _NSUserActivity_h_GNUSTEP_BASE_INCLUDE
#define _OBJC_MESSAGE_H_
#define _OBJC_NULL_PTR ((void*)0)
#define _OLD_STDIO_MAGIC 0xFABC0000
#define _PC_2_SYMLINKS _PC_2_SYMLINKS
#define _PC_ALLOC_SIZE_MIN _PC_ALLOC_SIZE_MIN
#define _PC_ASYNC_IO _PC_ASYNC_IO
#define _PC_CHOWN_RESTRICTED _PC_CHOWN_RESTRICTED
#define _PC_FILESIZEBITS _PC_FILESIZEBITS
#define _PC_LINK_MAX _PC_LINK_MAX
#define _PC_MAX_CANON _PC_MAX_CANON
#define _PC_MAX_INPUT _PC_MAX_INPUT
#define _PC_NAME_MAX _PC_NAME_MAX
#define _PC_NO_TRUNC _PC_NO_TRUNC
#define _PC_PATH_MAX _PC_PATH_MAX
#define _PC_PIPE_BUF _PC_PIPE_BUF
#define _PC_PRIO_IO _PC_PRIO_IO
#define _PC_REC_INCR_XFER_SIZE _PC_REC_INCR_XFER_SIZE
#define _PC_REC_MAX_XFER_SIZE _PC_REC_MAX_XFER_SIZE
#define _PC_REC_MIN_XFER_SIZE _PC_REC_MIN_XFER_SIZE
#define _PC_REC_XFER_ALIGN _PC_REC_XFER_ALIGN
#define _PC_SOCK_MAXBUF _PC_SOCK_MAXBUF
#define _PC_SYMLINK_MAX _PC_SYMLINK_MAX
#define _PC_SYNC_IO _PC_SYNC_IO
#define _PC_VDISABLE _PC_VDISABLE
#define _POSIX2_BC_BASE_MAX 99
#define _POSIX2_BC_DIM_MAX 2048
#define _POSIX2_BC_SCALE_MAX 99
#define _POSIX2_BC_STRING_MAX 1000
#define _POSIX2_CHARCLASS_NAME_MAX 14
#define _POSIX2_CHAR_TERM 200809L
#define _POSIX2_COLL_WEIGHTS_MAX 2
#define _POSIX2_C_BIND __POSIX2_THIS_VERSION
#define _POSIX2_C_DEV __POSIX2_THIS_VERSION
#define _POSIX2_C_VERSION __POSIX2_THIS_VERSION
#define _POSIX2_EXPR_NEST_MAX 32
#define _POSIX2_LINE_MAX 2048
#define _POSIX2_LOCALEDEF __POSIX2_THIS_VERSION
#define _POSIX2_RE_DUP_MAX 255
#define _POSIX2_SW_DEV __POSIX2_THIS_VERSION
#define _POSIX2_VERSION __POSIX2_THIS_VERSION
#define _POSIX_ADVISORY_INFO 200809L
#define _POSIX_AIO_LISTIO_MAX 2
#define _POSIX_AIO_MAX 1
#define _POSIX_ARG_MAX 4096
#define _POSIX_ASYNCHRONOUS_IO 200809L
#define _POSIX_ASYNC_IO 1
#define _POSIX_BARRIERS 200809L
#define _POSIX_CHILD_MAX 25
#define _POSIX_CHOWN_RESTRICTED 0
#define _POSIX_CLOCKRES_MIN 20000000
#define _POSIX_CLOCK_SELECTION 200809L
#define _POSIX_CPUTIME 0
#define _POSIX_C_SOURCE 200809L
#define _POSIX_DELAYTIMER_MAX 32
#define _POSIX_FSYNC 200809L
#define _POSIX_HOST_NAME_MAX 255
#define _POSIX_IPV6 200809L
#define _POSIX_JOB_CONTROL 1
#define _POSIX_LINK_MAX 8
#define _POSIX_LOGIN_NAME_MAX 9
#define _POSIX_MAPPED_FILES 200809L
#define _POSIX_MAX_CANON 255
#define _POSIX_MAX_INPUT 255
#define _POSIX_MEMLOCK 200809L
#define _POSIX_MEMLOCK_RANGE 200809L
#define _POSIX_MEMORY_PROTECTION 200809L
#define _POSIX_MESSAGE_PASSING 200809L
#define _POSIX_MONOTONIC_CLOCK 0
#define _POSIX_MQ_OPEN_MAX 8
#define _POSIX_MQ_PRIO_MAX 32
#define _POSIX_NAME_MAX 14
#define _POSIX_NGROUPS_MAX 8
#define _POSIX_NO_TRUNC 1
#define _POSIX_OPEN_MAX 20
#define _POSIX_PATH_MAX 256
#define _POSIX_PIPE_BUF 512
#define _POSIX_PRIORITIZED_IO 200809L
#define _POSIX_PRIORITY_SCHEDULING 200809L
#define _POSIX_RAW_SOCKETS 200809L
#define _POSIX_READER_WRITER_LOCKS 200809L
#define _POSIX_REALTIME_SIGNALS 200809L
#define _POSIX_REENTRANT_FUNCTIONS 1
#define _POSIX_REGEXP 1
#define _POSIX_RE_DUP_MAX 255
#define _POSIX_RTSIG_MAX 8
#define _POSIX_SAVED_IDS 1
#define _POSIX_SEMAPHORES 200809L
#define _POSIX_SEM_NSEMS_MAX 256
#define _POSIX_SEM_VALUE_MAX 32767
#define _POSIX_SHARED_MEMORY_OBJECTS 200809L
#define _POSIX_SHELL 1
#define _POSIX_SIGQUEUE_MAX 32
#define _POSIX_SOURCE 1
#define _POSIX_SPAWN 200809L
#define _POSIX_SPIN_LOCKS 200809L
#define _POSIX_SPORADIC_SERVER -1
#define _POSIX_SSIZE_MAX 32767
#define _POSIX_STREAM_MAX 8
#define _POSIX_SYMLINK_MAX 255
#define _POSIX_SYMLOOP_MAX 8
#define _POSIX_SYNCHRONIZED_IO 200809L
#define _POSIX_THREADS 200809L
#define _POSIX_THREAD_ATTR_STACKADDR 200809L
#define _POSIX_THREAD_ATTR_STACKSIZE 200809L
#define _POSIX_THREAD_CPUTIME 0
#define _POSIX_THREAD_DESTRUCTOR_ITERATIONS 4
#define _POSIX_THREAD_KEYS_MAX 128
#define _POSIX_THREAD_PRIORITY_SCHEDULING 200809L
#define _POSIX_THREAD_PRIO_INHERIT 200809L
#define _POSIX_THREAD_PRIO_PROTECT 200809L
#define _POSIX_THREAD_PROCESS_SHARED 200809L
#define _POSIX_THREAD_ROBUST_PRIO_INHERIT 200809L
#define _POSIX_THREAD_ROBUST_PRIO_PROTECT -1
#define _POSIX_THREAD_SAFE_FUNCTIONS 200809L
#define _POSIX_THREAD_SPORADIC_SERVER -1
#define _POSIX_THREAD_THREADS_MAX 64
#define _POSIX_TIMEOUTS 200809L
#define _POSIX_TIMERS 200809L
#define _POSIX_TIMER_MAX 32
#define _POSIX_TRACE -1
#define _POSIX_TRACE_EVENT_FILTER -1
#define _POSIX_TRACE_INHERIT -1
#define _POSIX_TRACE_LOG -1
#define _POSIX_TTY_NAME_MAX 9
#define _POSIX_TYPED_MEMORY_OBJECTS -1
#define _POSIX_TZNAME_MAX 6
#define _POSIX_V6_LP64_OFF64 1
#define _POSIX_V6_LPBIG_OFFBIG -1
#define _POSIX_V7_LP64_OFF64 1
#define _POSIX_V7_LPBIG_OFFBIG -1
#define _POSIX_VDISABLE '\0'
#define _POSIX_VERSION 200809L
#define _PSOperators_h_INCLUDE
#define _PTRDIFF_T
#define _REENTRANT 1
#define _SC_2_CHAR_TERM _SC_2_CHAR_TERM
#define _SC_2_C_BIND _SC_2_C_BIND
#define _SC_2_C_DEV _SC_2_C_DEV
#define _SC_2_C_VERSION _SC_2_C_VERSION
#define _SC_2_FORT_DEV _SC_2_FORT_DEV
#define _SC_2_FORT_RUN _SC_2_FORT_RUN
#define _SC_2_LOCALEDEF _SC_2_LOCALEDEF
#define _SC_2_PBS _SC_2_PBS
#define _SC_2_PBS_ACCOUNTING _SC_2_PBS_ACCOUNTING
#define _SC_2_PBS_CHECKPOINT _SC_2_PBS_CHECKPOINT
#define _SC_2_PBS_LOCATE _SC_2_PBS_LOCATE
#define _SC_2_PBS_MESSAGE _SC_2_PBS_MESSAGE
#define _SC_2_PBS_TRACK _SC_2_PBS_TRACK
#define _SC_2_SW_DEV _SC_2_SW_DEV
#define _SC_2_UPE _SC_2_UPE
#define _SC_2_VERSION _SC_2_VERSION
#define _SC_ADVISORY_INFO _SC_ADVISORY_INFO
#define _SC_AIO_LISTIO_MAX _SC_AIO_LISTIO_MAX
#define _SC_AIO_MAX _SC_AIO_MAX
#define _SC_AIO_PRIO_DELTA_MAX _SC_AIO_PRIO_DELTA_MAX
#define _SC_ARG_MAX _SC_ARG_MAX
#define _SC_ASYNCHRONOUS_IO _SC_ASYNCHRONOUS_IO
#define _SC_ATEXIT_MAX _SC_ATEXIT_MAX
#define _SC_AVPHYS_PAGES _SC_AVPHYS_PAGES
#define _SC_BARRIERS _SC_BARRIERS
#define _SC_BASE _SC_BASE
#define _SC_BC_BASE_MAX _SC_BC_BASE_MAX
#define _SC_BC_DIM_MAX _SC_BC_DIM_MAX
#define _SC_BC_SCALE_MAX _SC_BC_SCALE_MAX
#define _SC_BC_STRING_MAX _SC_BC_STRING_MAX
#define _SC_CHARCLASS_NAME_MAX _SC_CHARCLASS_NAME_MAX
#define _SC_CHAR_BIT _SC_CHAR_BIT
#define _SC_CHAR_MAX _SC_CHAR_MAX
#define _SC_CHAR_MIN _SC_CHAR_MIN
#define _SC_CHILD_MAX _SC_CHILD_MAX
#define _SC_CLK_TCK _SC_CLK_TCK
#define _SC_CLOCK_SELECTION _SC_CLOCK_SELECTION
#define _SC_COLL_WEIGHTS_MAX _SC_COLL_WEIGHTS_MAX
#define _SC_CPUTIME _SC_CPUTIME
#define _SC_C_LANG_SUPPORT _SC_C_LANG_SUPPORT
#define _SC_C_LANG_SUPPORT_R _SC_C_LANG_SUPPORT_R
#define _SC_DELAYTIMER_MAX _SC_DELAYTIMER_MAX
#define _SC_DEVICE_IO _SC_DEVICE_IO
#define _SC_DEVICE_SPECIFIC _SC_DEVICE_SPECIFIC
#define _SC_DEVICE_SPECIFIC_R _SC_DEVICE_SPECIFIC_R
#define _SC_EQUIV_CLASS_MAX _SC_EQUIV_CLASS_MAX
#define _SC_EXPR_NEST_MAX _SC_EXPR_NEST_MAX
#define _SC_FD_MGMT _SC_FD_MGMT
#define _SC_FIFO _SC_FIFO
#define _SC_FILE_ATTRIBUTES _SC_FILE_ATTRIBUTES
#define _SC_FILE_LOCKING _SC_FILE_LOCKING
#define _SC_FILE_SYSTEM _SC_FILE_SYSTEM
#define _SC_FSYNC _SC_FSYNC
#define _SC_GETGR_R_SIZE_MAX _SC_GETGR_R_SIZE_MAX
#define _SC_GETPW_R_SIZE_MAX _SC_GETPW_R_SIZE_MAX
#define _SC_HOST_NAME_MAX _SC_HOST_NAME_MAX
#define _SC_INT_MAX _SC_INT_MAX
#define _SC_INT_MIN _SC_INT_MIN
#define _SC_IOV_MAX _SC_IOV_MAX
#define _SC_IPV6 _SC_IPV6
#define _SC_JOB_CONTROL _SC_JOB_CONTROL
#define _SC_LEVEL1_DCACHE_ASSOC _SC_LEVEL1_DCACHE_ASSOC
#define _SC_LEVEL1_DCACHE_LINESIZE _SC_LEVEL1_DCACHE_LINESIZE
#define _SC_LEVEL1_DCACHE_SIZE _SC_LEVEL1_DCACHE_SIZE
#define _SC_LEVEL1_ICACHE_ASSOC _SC_LEVEL1_ICACHE_ASSOC
#define _SC_LEVEL1_ICACHE_LINESIZE _SC_LEVEL1_ICACHE_LINESIZE
#define _SC_LEVEL1_ICACHE_SIZE _SC_LEVEL1_ICACHE_SIZE
#define _SC_LEVEL2_CACHE_ASSOC _SC_LEVEL2_CACHE_ASSOC
#define _SC_LEVEL2_CACHE_LINESIZE _SC_LEVEL2_CACHE_LINESIZE
#define _SC_LEVEL2_CACHE_SIZE _SC_LEVEL2_CACHE_SIZE
#define _SC_LEVEL3_CACHE_ASSOC _SC_LEVEL3_CACHE_ASSOC
#define _SC_LEVEL3_CACHE_LINESIZE _SC_LEVEL3_CACHE_LINESIZE
#define _SC_LEVEL3_CACHE_SIZE _SC_LEVEL3_CACHE_SIZE
#define _SC_LEVEL4_CACHE_ASSOC _SC_LEVEL4_CACHE_ASSOC
#define _SC_LEVEL4_CACHE_LINESIZE _SC_LEVEL4_CACHE_LINESIZE
#define _SC_LEVEL4_CACHE_SIZE _SC_LEVEL4_CACHE_SIZE
#define _SC_LINE_MAX _SC_LINE_MAX
#define _SC_LOGIN_NAME_MAX _SC_LOGIN_NAME_MAX
#define _SC_LONG_BIT _SC_LONG_BIT
#define _SC_MAPPED_FILES _SC_MAPPED_FILES
#define _SC_MB_LEN_MAX _SC_MB_LEN_MAX
#define _SC_MEMLOCK _SC_MEMLOCK
#define _SC_MEMLOCK_RANGE _SC_MEMLOCK_RANGE
#define _SC_MEMORY_PROTECTION _SC_MEMORY_PROTECTION
#define _SC_MESSAGE_PASSING _SC_MESSAGE_PASSING
#define _SC_MONOTONIC_CLOCK _SC_MONOTONIC_CLOCK
#define _SC_MQ_OPEN_MAX _SC_MQ_OPEN_MAX
#define _SC_MQ_PRIO_MAX _SC_MQ_PRIO_MAX
#define _SC_MULTI_PROCESS _SC_MULTI_PROCESS
#define _SC_NETWORKING _SC_NETWORKING
#define _SC_NGROUPS_MAX _SC_NGROUPS_MAX
#define _SC_NL_ARGMAX _SC_NL_ARGMAX
#define _SC_NL_LANGMAX _SC_NL_LANGMAX
#define _SC_NL_MSGMAX _SC_NL_MSGMAX
#define _SC_NL_NMAX _SC_NL_NMAX
#define _SC_NL_SETMAX _SC_NL_SETMAX
#define _SC_NL_TEXTMAX _SC_NL_TEXTMAX
#define _SC_NPROCESSORS_CONF _SC_NPROCESSORS_CONF
#define _SC_NPROCESSORS_ONLN _SC_NPROCESSORS_ONLN
#define _SC_NZERO _SC_NZERO
#define _SC_OPEN_MAX _SC_OPEN_MAX
#define _SC_PAGESIZE _SC_PAGESIZE
#define _SC_PAGE_SIZE _SC_PAGESIZE
#define _SC_PASS_MAX _SC_PASS_MAX
#define _SC_PHYS_PAGES _SC_PHYS_PAGES
#define _SC_PII _SC_PII
#define _SC_PII_INTERNET _SC_PII_INTERNET
#define _SC_PII_INTERNET_DGRAM _SC_PII_INTERNET_DGRAM
#define _SC_PII_INTERNET_STREAM _SC_PII_INTERNET_STREAM
#define _SC_PII_OSI _SC_PII_OSI
#define _SC_PII_OSI_CLTS _SC_PII_OSI_CLTS
#define _SC_PII_OSI_COTS _SC_PII_OSI_COTS
#define _SC_PII_OSI_M _SC_PII_OSI_M
#define _SC_PII_SOCKET _SC_PII_SOCKET
#define _SC_PII_XTI _SC_PII_XTI
#define _SC_PIPE _SC_PIPE
#define _SC_POLL _SC_POLL
#define _SC_PRIORITIZED_IO _SC_PRIORITIZED_IO
#define _SC_PRIORITY_SCHEDULING _SC_PRIORITY_SCHEDULING
#define _SC_RAW_SOCKETS _SC_RAW_SOCKETS
#define _SC_READER_WRITER_LOCKS _SC_READER_WRITER_LOCKS
#define _SC_REALTIME_SIGNALS _SC_REALTIME_SIGNALS
#define _SC_REGEXP _SC_REGEXP
#define _SC_REGEX_VERSION _SC_REGEX_VERSION
#define _SC_RE_DUP_MAX _SC_RE_DUP_MAX
#define _SC_RTSIG_MAX _SC_RTSIG_MAX
#define _SC_SAVED_IDS _SC_SAVED_IDS
#define _SC_SCHAR_MAX _SC_SCHAR_MAX
#define _SC_SCHAR_MIN _SC_SCHAR_MIN
#define _SC_SELECT _SC_SELECT
#define _SC_SEMAPHORES _SC_SEMAPHORES
#define _SC_SEM_NSEMS_MAX _SC_SEM_NSEMS_MAX
#define _SC_SEM_VALUE_MAX _SC_SEM_VALUE_MAX
#define _SC_SHARED_MEMORY_OBJECTS _SC_SHARED_MEMORY_OBJECTS
#define _SC_SHELL _SC_SHELL
#define _SC_SHRT_MAX _SC_SHRT_MAX
#define _SC_SHRT_MIN _SC_SHRT_MIN
#define _SC_SIGNALS _SC_SIGNALS
#define _SC_SIGQUEUE_MAX _SC_SIGQUEUE_MAX
#define _SC_SINGLE_PROCESS _SC_SINGLE_PROCESS
#define _SC_SPAWN _SC_SPAWN
#define _SC_SPIN_LOCKS _SC_SPIN_LOCKS
#define _SC_SPORADIC_SERVER _SC_SPORADIC_SERVER
#define _SC_SSIZE_MAX _SC_SSIZE_MAX
#define _SC_SS_REPL_MAX _SC_SS_REPL_MAX
#define _SC_STREAMS _SC_STREAMS
#define _SC_STREAM_MAX _SC_STREAM_MAX
#define _SC_SYMLOOP_MAX _SC_SYMLOOP_MAX
#define _SC_SYNCHRONIZED_IO _SC_SYNCHRONIZED_IO
#define _SC_SYSTEM_DATABASE _SC_SYSTEM_DATABASE
#define _SC_SYSTEM_DATABASE_R _SC_SYSTEM_DATABASE_R
#define _SC_THREADS _SC_THREADS
#define _SC_THREAD_ATTR_STACKADDR _SC_THREAD_ATTR_STACKADDR
#define _SC_THREAD_ATTR_STACKSIZE _SC_THREAD_ATTR_STACKSIZE
#define _SC_THREAD_CPUTIME _SC_THREAD_CPUTIME
#define _SC_THREAD_DESTRUCTOR_ITERATIONS _SC_THREAD_DESTRUCTOR_ITERATIONS
#define _SC_THREAD_KEYS_MAX _SC_THREAD_KEYS_MAX
#define _SC_THREAD_PRIORITY_SCHEDULING _SC_THREAD_PRIORITY_SCHEDULING
#define _SC_THREAD_PRIO_INHERIT _SC_THREAD_PRIO_INHERIT
#define _SC_THREAD_PRIO_PROTECT _SC_THREAD_PRIO_PROTECT
#define _SC_THREAD_PROCESS_SHARED _SC_THREAD_PROCESS_SHARED
#define _SC_THREAD_ROBUST_PRIO_INHERIT _SC_THREAD_ROBUST_PRIO_INHERIT
#define _SC_THREAD_ROBUST_PRIO_PROTECT _SC_THREAD_ROBUST_PRIO_PROTECT
#define _SC_THREAD_SAFE_FUNCTIONS _SC_THREAD_SAFE_FUNCTIONS
#define _SC_THREAD_SPORADIC_SERVER _SC_THREAD_SPORADIC_SERVER
#define _SC_THREAD_STACK_MIN _SC_THREAD_STACK_MIN
#define _SC_THREAD_THREADS_MAX _SC_THREAD_THREADS_MAX
#define _SC_TIMEOUTS _SC_TIMEOUTS
#define _SC_TIMERS _SC_TIMERS
#define _SC_TIMER_MAX _SC_TIMER_MAX
#define _SC_TRACE _SC_TRACE
#define _SC_TRACE_EVENT_FILTER _SC_TRACE_EVENT_FILTER
#define _SC_TRACE_EVENT_NAME_MAX _SC_TRACE_EVENT_NAME_MAX
#define _SC_TRACE_INHERIT _SC_TRACE_INHERIT
#define _SC_TRACE_LOG _SC_TRACE_LOG
#define _SC_TRACE_NAME_MAX _SC_TRACE_NAME_MAX
#define _SC_TRACE_SYS_MAX _SC_TRACE_SYS_MAX
#define _SC_TRACE_USER_EVENT_MAX _SC_TRACE_USER_EVENT_MAX
#define _SC_TTY_NAME_MAX _SC_TTY_NAME_MAX
#define _SC_TYPED_MEMORY_OBJECTS _SC_TYPED_MEMORY_OBJECTS
#define _SC_TZNAME_MAX _SC_TZNAME_MAX
#define _SC_T_IOV_MAX _SC_T_IOV_MAX
#define _SC_UCHAR_MAX _SC_UCHAR_MAX
#define _SC_UINT_MAX _SC_UINT_MAX
#define _SC_UIO_MAXIOV _SC_UIO_MAXIOV
#define _SC_ULONG_MAX _SC_ULONG_MAX
#define _SC_USER_GROUPS _SC_USER_GROUPS
#define _SC_USER_GROUPS_R _SC_USER_GROUPS_R
#define _SC_USHRT_MAX _SC_USHRT_MAX
#define _SC_V6_ILP32_OFF32 _SC_V6_ILP32_OFF32
#define _SC_V6_ILP32_OFFBIG _SC_V6_ILP32_OFFBIG
#define _SC_V6_LP64_OFF64 _SC_V6_LP64_OFF64
#define _SC_V6_LPBIG_OFFBIG _SC_V6_LPBIG_OFFBIG
#define _SC_V7_ILP32_OFF32 _SC_V7_ILP32_OFF32
#define _SC_V7_ILP32_OFFBIG _SC_V7_ILP32_OFFBIG
#define _SC_V7_LP64_OFF64 _SC_V7_LP64_OFF64
#define _SC_V7_LPBIG_OFFBIG _SC_V7_LPBIG_OFFBIG
#define _SC_VERSION _SC_VERSION
#define _SC_WORD_BIT _SC_WORD_BIT
#define _SC_XBS5_ILP32_OFF32 _SC_XBS5_ILP32_OFF32
#define _SC_XBS5_ILP32_OFFBIG _SC_XBS5_ILP32_OFFBIG
#define _SC_XBS5_LP64_OFF64 _SC_XBS5_LP64_OFF64
#define _SC_XBS5_LPBIG_OFFBIG _SC_XBS5_LPBIG_OFFBIG
#define _SC_XOPEN_CRYPT _SC_XOPEN_CRYPT
#define _SC_XOPEN_ENH_I18N _SC_XOPEN_ENH_I18N
#define _SC_XOPEN_LEGACY _SC_XOPEN_LEGACY
#define _SC_XOPEN_REALTIME _SC_XOPEN_REALTIME
#define _SC_XOPEN_REALTIME_THREADS _SC_XOPEN_REALTIME_THREADS
#define _SC_XOPEN_SHM _SC_XOPEN_SHM
#define _SC_XOPEN_STREAMS _SC_XOPEN_STREAMS
#define _SC_XOPEN_UNIX _SC_XOPEN_UNIX
#define _SC_XOPEN_VERSION _SC_XOPEN_VERSION
#define _SC_XOPEN_XCU_VERSION _SC_XOPEN_XCU_VERSION
#define _SC_XOPEN_XPG2 _SC_XOPEN_XPG2
#define _SC_XOPEN_XPG3 _SC_XOPEN_XPG3
#define _SC_XOPEN_XPG4 _SC_XOPEN_XPG4
#define _SETJMP_H 1
#define _SIGNAL_H
#define _SIGSET_NWORDS (1024 / (8 * sizeof (unsigned long int)))
#define _SIZE_T
#define _SS_PADSIZE (_SS_SIZE - __SOCKADDR_COMMON_SIZE - sizeof (__ss_aligntype))
#define _SS_SIZE 128
#define _STATBUF_ST_BLKSIZE
#define _STATBUF_ST_NSEC
#define _STATBUF_ST_RDEV
#define _STAT_VER _STAT_VER_LINUX
#define _STAT_VER_KERNEL 0
#define _STAT_VER_LINUX 1
#define _STDC_PREDEF_H 1
#define _STDINT_H 1
#define _STDIO_H 1
#define _STDIO_USES_IOSTREAM
#define _STDLIB_H 1
#define _STRINGS_H 1
#define _STRING_H 1
#define _SYS_CDEFS_H 1
#define _SYS_PARAM_H 1
#define _SYS_SELECT_H 1
#define _SYS_SOCKET_H 1
#define _SYS_SYSMACROS_H 1
#define _SYS_SYSMACROS_H_OUTER 1
#define _SYS_TYPES_H 1
#define _SYS_UCONTEXT_H 1
#define _THREAD_SHARED_TYPES_H 1
#define _TIME_H 1
#define _UNISTD_H 1
#define _VA_LIST
#define _VA_LIST_DEFINED
#define _WCHAR_T
#define _XBS5_LP64_OFF64 1
#define _XBS5_LPBIG_OFFBIG -1
#define _XOPEN_CRYPT 1
#define _XOPEN_ENH_I18N 1
#define _XOPEN_LEGACY 1
#define _XOPEN_REALTIME 1
#define _XOPEN_REALTIME_THREADS 1
#define _XOPEN_SHM 1
#define _XOPEN_UNIX 1
#define _XOPEN_VERSION 700
#define _XOPEN_XCU_VERSION 4
#define _XOPEN_XPG2 1
#define _XOPEN_XPG3 1
#define _XOPEN_XPG4 1
#define __(X) X
#define __ASMNAME(cname) __ASMNAME2 (__USER_LABEL_PREFIX__, cname)
#define __ASMNAME2(prefix, cname) __STRING (prefix) cname
#define __ASM_GENERIC_PARAM_H
#define __ASM_GENERIC_SOCKET_H
#define __ASM_GENERIC_SOCKIOS_H
#define __ASSERT_FUNCTION __extension__ __PRETTY_FUNCTION__
#define __ASSERT_VOID_CAST (void)
#define __ATOMIC_ACQUIRE 2
#define __ATOMIC_ACQ_REL 4
#define __ATOMIC_CONSUME 1
#define __ATOMIC_RELAXED 0
#define __ATOMIC_RELEASE 3
#define __ATOMIC_SEQ_CST 5
#define __AppKitDefines_INCLUDE
#define __BEGIN_DECLS
#define __BIGGEST_ALIGNMENT__ 16
#define __BIG_ENDIAN 4321
#define __BITS_SOCKET_H
#define __BIT_TYPES_DEFINED__ 1
#define __BLKCNT64_T_TYPE __SQUAD_TYPE
#define __BLKCNT_T_TYPE __SYSCALL_SLONG_TYPE
#define __BLKSIZE_T_TYPE __SYSCALL_SLONG_TYPE
#define __BLOCKS__ 1
#define __BYTE_ORDER __LITTLE_ENDIAN
#define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__
#define __CFLOAT32 _Complex float
#define __CFLOAT32X _Complex double
#define __CFLOAT64 _Complex double
#define __CFLOAT64X _Complex long double
#define __CHAR16_TYPE__ unsigned short
#define __CHAR32_TYPE__ unsigned int
#define __CHAR_BIT__ 8
#define __CLANG_ATOMIC_BOOL_LOCK_FREE 2
#define __CLANG_ATOMIC_CHAR16_T_LOCK_FREE 2
#define __CLANG_ATOMIC_CHAR32_T_LOCK_FREE 2
#define __CLANG_ATOMIC_CHAR_LOCK_FREE 2
#define __CLANG_ATOMIC_INT_LOCK_FREE 2
#define __CLANG_ATOMIC_LLONG_LOCK_FREE 2
#define __CLANG_ATOMIC_LONG_LOCK_FREE 2
#define __CLANG_ATOMIC_POINTER_LOCK_FREE 2
#define __CLANG_ATOMIC_SHORT_LOCK_FREE 2
#define __CLANG_ATOMIC_WCHAR_T_LOCK_FREE 2
#define __CLANG_CUDA_APPROX_TRANSCENDENTALS__ 1
#define __CLANG_FLOAT_H
#define __CLANG_INTTYPES_H
#define __CLANG_LIMITS_H
#define __CLANG_MAX_ALIGN_T_DEFINED
#define __CLANG_STDINT_H
#define __CLOCKID_T_TYPE __S32_TYPE
#define __CLOCK_T_TYPE __SYSCALL_SLONG_TYPE
#define __COMPAR_FN_T
#define __CONCAT(x, y) x ## y
#define __CONSTANT_CFSTRINGS__ 1
#define __CONST_SOCKADDR_ARG const struct sockaddr *
#define __CPU_MASK_TYPE __SYSCALL_ULONG_TYPE
#define __DADDR_T_TYPE __S32_TYPE
#define __DBL_DECIMAL_DIG__ 17
#define __DBL_DENORM_MIN__ 4.9406564584124654e-324
#define __DBL_DIG__ 15
#define __DBL_EPSILON__ 2.2204460492503131e-16
#define __DBL_HAS_DENORM__ 1
#define __DBL_HAS_INFINITY__ 1
#define __DBL_HAS_QUIET_NAN__ 1
#define __DBL_MANT_DIG__ 53
#define __DBL_MAX_10_EXP__ 308
#define __DBL_MAX_EXP__ 1024
#define __DBL_MAX__ 1.7976931348623157e+308
#define __DBL_MIN_10_EXP__ (-307)
#define __DBL_MIN_EXP__ (-1021)
#define __DBL_MIN__ 2.2250738585072014e-308
#define __DECIMAL_DIG__ __LDBL_DECIMAL_DIG__
#define __DECL_SIMD_cos
#define __DECL_SIMD_cosf
#define __DECL_SIMD_cosf128
#define __DECL_SIMD_cosf128x
#define __DECL_SIMD_cosf16
#define __DECL_SIMD_cosf32
#define __DECL_SIMD_cosf32x
#define __DECL_SIMD_cosf64
#define __DECL_SIMD_cosf64x
#define __DECL_SIMD_cosl
#define __DECL_SIMD_exp
#define __DECL_SIMD_expf
#define __DECL_SIMD_expf128
#define __DECL_SIMD_expf128x
#define __DECL_SIMD_expf16
#define __DECL_SIMD_expf32
#define __DECL_SIMD_expf32x
#define __DECL_SIMD_expf64
#define __DECL_SIMD_expf64x
#define __DECL_SIMD_expl
#define __DECL_SIMD_log
#define __DECL_SIMD_logf
#define __DECL_SIMD_logf128
#define __DECL_SIMD_logf128x
#define __DECL_SIMD_logf16
#define __DECL_SIMD_logf32
#define __DECL_SIMD_logf32x
#define __DECL_SIMD_logf64
#define __DECL_SIMD_logf64x
#define __DECL_SIMD_logl
#define __DECL_SIMD_pow
#define __DECL_SIMD_powf
#define __DECL_SIMD_powf128
#define __DECL_SIMD_powf128x
#define __DECL_SIMD_powf16
#define __DECL_SIMD_powf32
#define __DECL_SIMD_powf32x
#define __DECL_SIMD_powf64
#define __DECL_SIMD_powf64x
#define __DECL_SIMD_powl
#define __DECL_SIMD_sin
#define __DECL_SIMD_sincos
#define __DECL_SIMD_sincosf
#define __DECL_SIMD_sincosf128
#define __DECL_SIMD_sincosf128x
#define __DECL_SIMD_sincosf16
#define __DECL_SIMD_sincosf32
#define __DECL_SIMD_sincosf32x
#define __DECL_SIMD_sincosf64
#define __DECL_SIMD_sincosf64x
#define __DECL_SIMD_sincosl
#define __DECL_SIMD_sinf
#define __DECL_SIMD_sinf128
#define __DECL_SIMD_sinf128x
#define __DECL_SIMD_sinf16
#define __DECL_SIMD_sinf32
#define __DECL_SIMD_sinf32x
#define __DECL_SIMD_sinf64
#define __DECL_SIMD_sinf64x
#define __DECL_SIMD_sinl
#define __DEV_T_TYPE __UQUAD_TYPE
#define __DISPATCH_BASE__
#define __DISPATCH_BLOCK__
#define __DISPATCH_DATA__
#define __DISPATCH_GROUP__
#define __DISPATCH_IO__
#define __DISPATCH_OBJECT__
#define __DISPATCH_ONCE__
#define __DISPATCH_PUBLIC__
#define __DISPATCH_QUEUE__
#define __DISPATCH_SEMAPHORE__
#define __DISPATCH_SOURCE__
#define __DISPATCH_TIME__
#define __ELF__ 1
#define __END_DECLS
#define __ENUM_IDTYPE_T 1
#define __EXCEPTIONS 1
#define __FAST_MATH__ 1
#define __FDS_BITS(set) ((set)->__fds_bits)
#define __FD_CLR(d, set) ((void) (__FDS_BITS (set)[__FD_ELT (d)] &= ~__FD_MASK (d)))
#define __FD_ELT(d) ((d) / __NFDBITS)
#define __FD_ISSET(d, set) ((__FDS_BITS (set)[__FD_ELT (d)] & __FD_MASK (d)) != 0)
#define __FD_MASK(d) ((__fd_mask) (1UL << ((d) % __NFDBITS)))
#define __FD_SET(d, set) ((void) (__FDS_BITS (set)[__FD_ELT (d)] |= __FD_MASK (d)))
#define __FD_SETSIZE 1024
#define __FD_ZERO(fdsp) do { int __d0, __d1; __asm__ __volatile__ ("cld; rep; " __FD_ZERO_STOS : "=c" (__d0), "=D" (__d1) : "a" (0), "0" (sizeof (fd_set) / sizeof (__fd_mask)), "1" (&__FDS_BITS (fdsp)[0]) : "memory"); } while (0)
#define __FD_ZERO_STOS "stosq"
#define __FILE_defined 1
#define __FINITE_MATH_ONLY__ 1
#define __FLOAT128__ 1
#define __FLOAT_WORD_ORDER __BYTE_ORDER
#define __FLT_DECIMAL_DIG__ 9
#define __FLT_DENORM_MIN__ 1.40129846e-45F
#define __FLT_DIG__ 6
#define __FLT_EPSILON__ 1.19209290e-7F
#define __FLT_EVAL_METHOD__ 0
#define __FLT_HAS_DENORM__ 1
#define __FLT_HAS_INFINITY__ 1
#define __FLT_HAS_QUIET_NAN__ 1
#define __FLT_MANT_DIG__ 24
#define __FLT_MAX_10_EXP__ 38
#define __FLT_MAX_EXP__ 128
#define __FLT_MAX__ 3.40282347e+38F
#define __FLT_MIN_10_EXP__ (-37)
#define __FLT_MIN_EXP__ (-125)
#define __FLT_MIN__ 1.17549435e-38F
#define __FLT_RADIX__ 2
#define __FP_LOGB0_IS_MIN 1
#define __FP_LOGBNAN_IS_MIN 1
#define __FSBLKCNT64_T_TYPE __UQUAD_TYPE
#define __FSBLKCNT_T_TYPE __SYSCALL_ULONG_TYPE
#define __FSFILCNT64_T_TYPE __UQUAD_TYPE
#define __FSFILCNT_T_TYPE __SYSCALL_ULONG_TYPE
#define __FSID_T_TYPE struct { int __val[2]; }
#define __FSWORD_T_TYPE __SYSCALL_SLONG_TYPE
#define __FXSR__ 1
#define __F_GETOWN 9
#define __F_GETOWN_EX 16
#define __F_GETSIG 11
#define __F_SETOWN 8
#define __F_SETOWN_EX 15
#define __F_SETSIG 10
#define __FoundationErrors_h_GNUSTEP_BASE_INCLUDE
#define __Foundation_h_GNUSTEP_BASE_INCLUDE
#define __GCC_ASM_FLAG_OUTPUTS__ 1
#define __GCC_ATOMIC_BOOL_LOCK_FREE 2
#define __GCC_ATOMIC_CHAR16_T_LOCK_FREE 2
#define __GCC_ATOMIC_CHAR32_T_LOCK_FREE 2
#define __GCC_ATOMIC_CHAR_LOCK_FREE 2
#define __GCC_ATOMIC_INT_LOCK_FREE 2
#define __GCC_ATOMIC_LLONG_LOCK_FREE 2
#define __GCC_ATOMIC_LONG_LOCK_FREE 2
#define __GCC_ATOMIC_POINTER_LOCK_FREE 2
#define __GCC_ATOMIC_SHORT_LOCK_FREE 2
#define __GCC_ATOMIC_TEST_AND_SET_TRUEVAL 1
#define __GCC_ATOMIC_WCHAR_T_LOCK_FREE 2
#define __GCC_HAVE_SYNC_COMPARE_AND_SWAP_1 1
#define __GCC_HAVE_SYNC_COMPARE_AND_SWAP_2 1
#define __GCC_HAVE_SYNC_COMPARE_AND_SWAP_4 1
#define __GCC_HAVE_SYNC_COMPARE_AND_SWAP_8 1
#define __GID_T_TYPE __U32_TYPE
#define __GLIBC_FLT_EVAL_METHOD __FLT_EVAL_METHOD__
#define __GLIBC_MINOR__ 27
#define __GLIBC_PREREQ(maj, min) ((__GLIBC__ << 16) + __GLIBC_MINOR__ >= ((maj) << 16) + (min))
#define __GLIBC_USE(F) __GLIBC_USE_ ## F
#define __GLIBC_USE_DEPRECATED_GETS 0
#define __GLIBC_USE_IEC_60559_BFP_EXT 0
#define __GLIBC_USE_IEC_60559_FUNCS_EXT 0
#define __GLIBC_USE_IEC_60559_TYPES_EXT 0
#define __GLIBC_USE_LIB_EXT2 0
#define __GLIBC__ 2
#define __GNUC_MINOR__ 2
#define __GNUC_PATCHLEVEL__ 1
#define __GNUC_PREREQ(maj, min) ((__GNUC__ << 16) + __GNUC_MINOR__ >= ((maj) << 16) + (min))
#define __GNUC_STDC_INLINE__ 1
#define __GNUC_VA_LIST 1
#define __GNUC__ 4
#define __GNUSTEP_GNUSTEP_H_INCLUDED_
#define __GNUSTEP_GSVERSIONMACROS_H_INCLUDED_
#define __GNUSTEP_LIBOBJC_RUNTIME_DEPRECATED_INCLUDED__
#define __GNUSTEP_RUNTIME__
#define __GNU_LIBRARY__ 6
#define __GNUstep_H_NSHelpManager
#define __GNUstep_NSSharingService
#define __GSBlocks_h_GNUSTEP_BASE_INCLUDE
#define __GSObjCRuntime_h_GNUSTEP_BASE_INCLUDE
#define __GXX_ABI_VERSION 1002
#define __HAVE_COLUMN
#define __HAVE_DISTINCT_FLOAT128 0
#define __HAVE_DISTINCT_FLOAT128X __HAVE_FLOAT128X
#define __HAVE_DISTINCT_FLOAT16 __HAVE_FLOAT16
#define __HAVE_DISTINCT_FLOAT32 0
#define __HAVE_DISTINCT_FLOAT32X 0
#define __HAVE_DISTINCT_FLOAT64 0
#define __HAVE_DISTINCT_FLOAT64X 0
#define __HAVE_FLOAT128 0
#define __HAVE_FLOAT128X 0
#define __HAVE_FLOAT16 0
#define __HAVE_FLOAT32 1
#define __HAVE_FLOAT32X 1
#define __HAVE_FLOAT64 1
#define __HAVE_FLOAT64X 1
#define __HAVE_FLOAT64X_LONG_DOUBLE 1
#define __HAVE_FLOATN_NOT_TYPEDEF 0
#define __HAVE_GENERIC_SELECTION 1
#define __ID_T_TYPE __U32_TYPE
#define __ILP32_OFF32_CFLAGS "-m32"
#define __ILP32_OFF32_LDFLAGS "-m32"
#define __ILP32_OFFBIG_CFLAGS "-m32 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64"
#define __ILP32_OFFBIG_LDFLAGS "-m32"
#define __INO64_T_TYPE __UQUAD_TYPE
#define __INO_T_MATCHES_INO64_T 1
#define __INO_T_TYPE __SYSCALL_ULONG_TYPE
#define __INT16_C_SUFFIX__
#define __INT16_FMTd__ "hd"
#define __INT16_FMTi__ "hi"
#define __INT16_MAX__ 32767
#define __INT16_TYPE__ short
#define __INT32_C_SUFFIX__
#define __INT32_FMTd__ "d"
#define __INT32_FMTi__ "i"
#define __INT32_MAX__ 2147483647
#define __INT32_TYPE__ int
#define __INT64_C(c) c ## L
#define __INT64_C_SUFFIX__ L
#define __INT64_FMTd__ "ld"
#define __INT64_FMTi__ "li"
#define __INT64_MAX__ 9223372036854775807L
#define __INT64_TYPE__ long int
#define __INT8_C_SUFFIX__
#define __INT8_FMTd__ "hhd"
#define __INT8_FMTi__ "hhi"
#define __INT8_MAX__ 127
#define __INT8_TYPE__ signed char
#define __INTMAX_C_SUFFIX__ L
#define __INTMAX_FMTd__ "ld"
#define __INTMAX_FMTi__ "li"
#define __INTMAX_MAX__ 9223372036854775807L
#define __INTMAX_TYPE__ long int
#define __INTMAX_WIDTH__ 64
#define __INTPTR_FMTd__ "ld"
#define __INTPTR_FMTi__ "li"
#define __INTPTR_MAX__ 9223372036854775807L
#define __INTPTR_TYPE__ long int
#define __INTPTR_WIDTH__ 64
#define __INT_FAST16_FMTd__ "hd"
#define __INT_FAST16_FMTi__ "hi"
#define __INT_FAST16_MAX__ 32767
#define __INT_FAST16_TYPE__ short
#define __INT_FAST32_FMTd__ "d"
#define __INT_FAST32_FMTi__ "i"
#define __INT_FAST32_MAX__ 2147483647
#define __INT_FAST32_TYPE__ int
#define __INT_FAST64_FMTd__ "ld"
#define __INT_FAST64_FMTi__ "li"
#define __INT_FAST64_MAX__ 9223372036854775807L
#define __INT_FAST64_TYPE__ long int
#define __INT_FAST8_FMTd__ "hhd"
#define __INT_FAST8_FMTi__ "hhi"
#define __INT_FAST8_MAX__ 127
#define __INT_FAST8_TYPE__ signed char
#define __INT_LEAST16_FMTd__ "hd"
#define __INT_LEAST16_FMTi__ "hi"
#define __INT_LEAST16_MAX__ 32767
#define __INT_LEAST16_TYPE__ short
#define __INT_LEAST32_FMTd__ "d"
#define __INT_LEAST32_FMTi__ "i"
#define __INT_LEAST32_MAX__ 2147483647
#define __INT_LEAST32_TYPE__ int
#define __INT_LEAST64_FMTd__ "ld"
#define __INT_LEAST64_FMTi__ "li"
#define __INT_LEAST64_MAX__ 9223372036854775807L
#define __INT_LEAST64_TYPE__ long int
#define __INT_LEAST8_FMTd__ "hhd"
#define __INT_LEAST8_FMTi__ "hhi"
#define __INT_LEAST8_MAX__ 127
#define __INT_LEAST8_TYPE__ signed char
#define __INT_MAX__ 2147483647
#define __KERNEL_STRICT_NAMES
#define __KEY_T_TYPE __S32_TYPE
#define __LC_ADDRESS 9
#define __LC_ALL 6
#define __LC_COLLATE 3
#define __LC_CTYPE 0
#define __LC_IDENTIFICATION 12
#define __LC_MEASUREMENT 11
#define __LC_MESSAGES 5
#define __LC_MONETARY 4
#define __LC_NAME 8
#define __LC_NUMERIC 1
#define __LC_PAPER 7
#define __LC_TELEPHONE 10
#define __LC_TIME 2
#define __LDBL_DECIMAL_DIG__ 21
#define __LDBL_DENORM_MIN__ 3.64519953188247460253e-4951L
#define __LDBL_DIG__ 18
#define __LDBL_EPSILON__ 1.08420217248550443401e-19L
#define __LDBL_HAS_DENORM__ 1
#define __LDBL_HAS_INFINITY__ 1
#define __LDBL_HAS_QUIET_NAN__ 1
#define __LDBL_MANT_DIG__ 64
#define __LDBL_MAX_10_EXP__ 4932
#define __LDBL_MAX_EXP__ 16384
#define __LDBL_MAX__ 1.18973149535723176502e+4932L
#define __LDBL_MIN_10_EXP__ (-4931)
#define __LDBL_MIN_EXP__ (-16381)
#define __LDBL_MIN__ 3.36210314311209350626e-4932L
#define __LDBL_REDIR(name, proto) name proto
#define __LDBL_REDIR1(name, proto, alias) name proto
#define __LDBL_REDIR1_NTH(name, proto, alias) name proto __THROW
#define __LDBL_REDIR_DECL(name)
#define __LDBL_REDIR_NTH(name, proto) name proto __THROW
#define __LEAF
#define __LEAF_ATTR
#define __LIBOBJC_ENCODING_H_INCLUDED__
#define __LIBOBJC_RUNTIME_H_INCLUDED__
#define __LITTLE_ENDIAN 1234
#define __LITTLE_ENDIAN__ 1
#define __LOCK_ALIGNMENT
#define __LONG_LONG_MAX__ 9223372036854775807LL
#define __LONG_LONG_PAIR(HI, LO) LO, HI
#define __LONG_MAX__ 9223372036854775807L
#define __LP64_OFF64_CFLAGS "-m64"
#define __LP64_OFF64_LDFLAGS "-m64"
#define __LP64__ 1
#define __MATHCALLX(function, suffix, args, attrib) __MATHDECLX (_Mdouble_,function,suffix, args, attrib)
#define __MATHCALL_VEC(function, suffix, args) __SIMD_DECL (__MATH_PRECNAME (function, suffix)) __MATHCALL (function, suffix, args)
#define __MATHDECLX(type, function, suffix, args, attrib) __MATHDECL_1(type, function,suffix, args) __attribute__ (attrib); __MATHDECL_1(type, __CONCAT(__,function),suffix, args) __attribute__ (attrib)
#define __MATHDECL_VEC(type, function, suffix, args) __SIMD_DECL (__MATH_PRECNAME (function, suffix)) __MATHDECL(type, function,suffix, args)
#define __MATH_DECLARE_LDOUBLE 1
#define __MATH_INLINE __extern_always_inline
#define __MATH_TG(TG_ARG, FUNC, ARGS) (sizeof (TG_ARG) == sizeof (float) ? FUNC ## f ARGS : sizeof (TG_ARG) == sizeof (double) ? FUNC ARGS : FUNC ## l ARGS)
#define __MMX__ 1
#define __MODE_T_TYPE __U32_TYPE
#define __NFDBITS (8 * (int) sizeof (__fd_mask))
#define __NGREG 23
#define __NLINK_T_TYPE __SYSCALL_ULONG_TYPE
#define __NO_MATH_INLINES 1
#define __NSAffineTransform_h_GNUSTEP_BASE_INCLUDE
#define __NSArchiver_h_GNUSTEP_BASE_INCLUDE
#define __NSArray_h_GNUSTEP_BASE_INCLUDE
#define __NSAttributedString_h_GNUSTEP_BASE_INCLUDE
#define __NSAutoreleasePool_h_GNUSTEP_BASE_INCLUDE
#define __NSBundle_h_GNUSTEP_BASE_INCLUDE
#define __NSByteOrder_h_GNUSTEP_BASE_INCLUDE
#define __NSCache_h_GNUSTEP_BASE_INCLUDE
#define __NSCalendarDate_h_GNUSTEP_BASE_INCLUDE
#define __NSCalendar_h_GNUSTEP_BASE_INCLUDE
#define __NSCharacterSet_h_GNUSTEP_BASE_INCLUDE
#define __NSClassDescription_h_GNUSTEP_BASE_INCLUDE
#define __NSCoder_h_GNUSTEP_BASE_INCLUDE
#define __NSComparisonPredicate_h_GNUSTEP_BASE_INCLUDE
#define __NSCompoundPredicate_h_GNUSTEP_BASE_INCLUDE
#define __NSConnection_h_GNUSTEP_BASE_INCLUDE
#define __NSData_h_GNUSTEP_BASE_INCLUDE
#define __NSDateFormatter_h_GNUSTEP_BASE_INCLUDE
#define __NSDate_h_GNUSTEP_BASE_INCLUDE
#define __NSDebug_h_GNUSTEP_BASE_INCLUDE
#define __NSDecimalNumber_h_GNUSTEP_BASE_INCLUDE
#define __NSDecimal_h_GNUSTEP_BASE_INCLUDE
#define __NSDistantObject_h_GNUSTEP_BASE_INCLUDE
#define __NSDistributedLock_h_GNUSTEP_BASE_INCLUDE
#define __NSDistributedNotificationCenter_h_GNUSTEP_BASE_INCLUDE
#define __NSEnumerator_h_GNUSTEP_BASE_INCLUDE
#define __NSError_h_GNUSTEP_BASE_INCLUDE
#define __NSException_h_GNUSTEP_BASE_INCLUDE
#define __NSExpression_h_GNUSTEP_BASE_INCLUDE
#define __NSFileCoordinator_h_GNUSTEP_BASE_INCLUDE
#define __NSFileHandle_h_GNUSTEP_BASE_INCLUDE
#define __NSFileManager_h_GNUSTEP_BASE_INCLUDE
#define __NSFilePresenter_h_GNUSTEP_BASE_INCLUDE
#define __NSFileVersion_h_GNUSTEP_BASE_INCLUDE
#define __NSFormatter_h_GNUSTEP_BASE_INCLUDE
#define __NSGeometry_h_GNUSTEP_BASE_INCLUDE
#define __NSGraphics_h__
#define __NSHTTPCookieStorage_h_GNUSTEP_BASE_INCLUDE
#define __NSHTTPCookie_h_GNUSTEP_BASE_INCLUDE
#define __NSHashTable_h_GNUSTEP_BASE_INCLUDE 1
#define __NSHost_h_GNUSTEP_BASE_INCLUDE
#define __NSInvocationOperation_h_GNUSTEP_BASE_INCLUDE
#define __NSInvocation_h_GNUSTEP_BASE_INCLUDE
#define __NSKeyValueCoding_h_GNUSTEP_BASE_INCLUDE
#define __NSKeyValueObserving_h_GNUSTEP_BASE_INCLUDE
#define __NSKeyedArchiver_h_GNUSTEP_BASE_INCLUDE
#define __NSLocale_h_GNUSTEP_BASE_INCLUDE
#define __NSLock_h_GNUSTEP_BASE_INCLUDE
#define __NSMapTable_h_GNUSTEP_BASE_INCLUDE 1
#define __NSMetadata_h_GNUSTEP_BASE_INCLUDE
#define __NSMethodSignature_h_GNUSTEP_BASE_INCLUDE
#define __NSNetServices_h_GNUSTEP_BASE_INCLUDE
#define __NSNotificationQueue_h_GNUSTEP_BASE_INCLUDE
#define __NSNotification_h_GNUSTEP_BASE_INCLUDE
#define __NSNull_h_GNUSTEP_BASE_INCLUDE
#define __NSObjCRuntime_h_GNUSTEP_BASE_INCLUDE
#define __NSObject_h_GNUSTEP_BASE_INCLUDE
#define __NSOperation_h_GNUSTEP_BASE_INCLUDE
#define __NSPathUtilities_h_GNUSTEP_BASE_INCLUDE
#define __NSPersonNameComponentsFormatter_h_GNUSTEP_BASE_INCLUDE
#define __NSPersonNameComponents_h_GNUSTEP_BASE_INCLUDE
#define __NSPointerArray_h_GNUSTEP_BASE_INCLUDE
#define __NSPointerFunctions_h_GNUSTEP_BASE_INCLUDE
#define __NSPortCoder_h_GNUSTEP_BASE_INCLUDE
#define __NSPortMessage_h_GNUSTEP_BASE_INCLUDE
#define __NSPortNameServer_h_GNUSTEP_BASE_INCLUDE
#define __NSPort_h_GNUSTEP_BASE_INCLUDE
#define __NSPredicate_h_GNUSTEP_BASE_INCLUDE
#define __NSProcessInfo_h_GNUSTEP_BASE_INCLUDE
#define __NSPropertyList_h_GNUSTEP_BASE_INCLUDE
#define __NSProtocolChecker_h_GNUSTEP_BASE_INCLUDE
#define __NSProxy_h_GNUSTEP_BASE_INCLUDE
#define __NSRange_h_GNUSTEP_BASE_INCLUDE
#define __NSRunLoop_h_GNUSTEP_BASE_INCLUDE
#define __NSScanner_h_GNUSTEP_BASE_INCLUDE
#define __NSScriptWhoseTests_h_GNUSTEP_BASE_INCLUDE
#define __NSSerialization_h_GNUSTEP_BASE_INCLUDE
#define __NSSortDescriptor_h_GNUSTEP_BASE_INCLUDE
#define __NSStream_h_GNUSTEP_BASE_INCLUDE
#define __NSString_h_GNUSTEP_BASE_INCLUDE
#define __NSTask_h_GNUSTEP_BASE_INCLUDE
#define __NSThread_h_GNUSTEP_BASE_INCLUDE
#define __NSTimeZone_h_GNUSTEP_BASE_INCLUDE
#define __NSTimer_h_GNUSTEP_BASE_INCLUDE
#define __NSURLAuthenticationChallenge_h_GNUSTEP_BASE_INCLUDE
#define __NSURLCache_h_GNUSTEP_BASE_INCLUDE
#define __NSURLConnection_h_GNUSTEP_BASE_INCLUDE
#define __NSURLCredentialStorage_h_GNUSTEP_BASE_INCLUDE
#define __NSURLCredential_h_GNUSTEP_BASE_INCLUDE
#define __NSURLDownload_h_GNUSTEP_BASE_INCLUDE
#define __NSURLError_h_GNUSTEP_BASE_INCLUDE
#define __NSURLHandle_h_GNUSTEP_BASE_INCLUDE
#define __NSURLProtectionSpace_h_GNUSTEP_BASE_INCLUDE
#define __NSURLProtocol_h_GNUSTEP_BASE_INCLUDE
#define __NSURLRequest_h_GNUSTEP_BASE_INCLUDE
#define __NSURLResponse_h_GNUSTEP_BASE_INCLUDE
#define __NSURLSession_h_GNUSTEP_BASE_INCLUDE
#define __NSURL_h_GNUSTEP_BASE_INCLUDE
#define __NSUUID_h_GNUSTEP_BASE_INCLUDE
#define __NSUndoManager_h_OBJECTS_INCLUDE
#define __NSUserDefaults_h_OBJECTS_INCLUDE
#define __NSUserNotification_h_INCLUDE
#define __NSValueTransformer_h_GNUSTEP_BASE_INCLUDE
#define __NSValue_h_GNUSTEP_BASE_INCLUDE
#define __NSXMLDTDNode_h_GNUSTEP_BASE_INCLUDE
#define __NSXMLDTD_h_GNUSTEP_BASE_INCLUDE
#define __NSXMLDocument_h_GNUSTEP_BASE_INCLUDE
#define __NSXMLElement_h_GNUSTEP_BASE_INCLUDE
#define __NSXMLNodeOptions_h_GNUSTEP_BASE_INCLUDE
#define __NSXMLNode_h_GNUSTEP_BASE_INCLUDE
#define __NSXMLParser_h_GNUSTEP_BASE_INCLUDE
#define __NSZone_h_GNUSTEP_BASE_INCLUDE
#define __NTH(fct) __attribute__ ((__nothrow__ __LEAF)) fct
#define __NTHNL(fct) __attribute__ ((__nothrow__)) fct
#define __OBJC2__ 1
#define __OBJC_BOOL_IS_BOOL 0
#define __OBJC_GNUSTEP_RUNTIME_ABI__ 20
#define __OBJC_SLOT_H_INCLUDED__
#define __OBJC__ 1
#define __OFF64_T_TYPE __SQUAD_TYPE
#define __OFF_T_MATCHES_OFF64_T 1
#define __OFF_T_TYPE __SYSCALL_SLONG_TYPE
#define __ONCE_ALIGNMENT
#define __OPENCL_MEMORY_SCOPE_ALL_SVM_DEVICES 3
#define __OPENCL_MEMORY_SCOPE_DEVICE 2
#define __OPENCL_MEMORY_SCOPE_SUB_GROUP 4
#define __OPENCL_MEMORY_SCOPE_WORK_GROUP 1
#define __OPENCL_MEMORY_SCOPE_WORK_ITEM 0
#define __OPEN_NEEDS_MODE(oflag) (((oflag) & O_CREAT) != 0 || ((oflag) & __O_TMPFILE) == __O_TMPFILE)
#define __OPTIMIZE__ 1
#define __ORDER_BIG_ENDIAN__ 4321
#define __ORDER_LITTLE_ENDIAN__ 1234
#define __ORDER_PDP_ENDIAN__ 3412
#define __OS_CONCAT(x, y) x ## y
#define __OS_GENERIC_UNIX_BASE__
#define __OS_OBJECT__
#define __OS_STRINGIFY(s) #s
#define __O_CLOEXEC 02000000
#define __O_DIRECT 040000
#define __O_DIRECTORY 0200000
#define __O_DSYNC 010000
#define __O_LARGEFILE 0
#define __O_NOATIME 01000000
#define __O_NOFOLLOW 0400000
#define __O_PATH 010000000
#define __O_TMPFILE (020000000 | __O_DIRECTORY)
#define __P(args) args
#define __PBXBUILDER_NSDATA_MOSCOW_H__
#define __PBXBUILDER_NSFILEMANAGER_MOSCOW_H__
#define __PBXBUILDER_NSMUTABLEARRAY_MOSCOW_H__
#define __PBXBUILDER_NSREGULAREXPRESSION_MOSCOW_H__
#define __PBXBUILDER_NSSCANNER_MOSCOW_H__
#define __PBXBUILDER_NSSTRING_MOSCOW_H__
#define __PBXBUILDER_PBXBUILDPHASE_H__
#define __PBXBUILDER_PBXFRAMEWORKSBUILDPHASE_H__
#define __PBXBUILDER_PBXITEM_H__
#define __PBXBUILDER_PGBOOL_H__
#define __PBXBUILDER_PGCMDLINE_H__
#define __PBXBUILDER_PGEXECUTE_H__
#define __PBXBUILDER_TOOLS_H__
#define __PDP_ENDIAN 3412
#define __PIC__ 2
#define __PID_T_TYPE __S32_TYPE
#define __PMT(args) args
#define __POINTER_WIDTH__ 64
#define __POSIX2_THIS_VERSION 200809L
#define __POSIX_FADV_DONTNEED 4
#define __POSIX_FADV_NOREUSE 5
#define __PRAGMA_REDEFINE_EXTNAME 1
#define __PRI64_PREFIX "l"
#define __PRIPTR_PREFIX "l"
#define __PTHREAD_COMPAT_PADDING_END
#define __PTHREAD_COMPAT_PADDING_MID
#define __PTHREAD_MUTEX_HAVE_PREV 1
#define __PTHREAD_MUTEX_LOCK_ELISION 1
#define __PTHREAD_MUTEX_NUSERS_AFTER_KIND 0
#define __PTHREAD_MUTEX_USE_UNION 0
#define __PTHREAD_RWLOCK_ELISION_EXTRA 0, { 0, 0, 0, 0, 0, 0, 0 }
#define __PTHREAD_RWLOCK_INT_FLAGS_SHARED 1
#define __PTHREAD_SPINS 0, 0
#define __PTHREAD_SPINS_DATA short __spins; short __elision
#define __PTRDIFF_FMTd__ "ld"
#define __PTRDIFF_FMTi__ "li"
#define __PTRDIFF_MAX__ 9223372036854775807L
#define __PTRDIFF_TYPE__ long int
#define __PTRDIFF_WIDTH__ 64
#define __REDIRECT(name, proto, alias) name proto __asm__ (__ASMNAME (#alias))
#define __REDIRECT_LDBL(name, proto, alias) __REDIRECT (name, proto, alias)
#define __REDIRECT_NTH(name, proto, alias) name proto __asm__ (__ASMNAME (#alias)) __THROW
#define __REDIRECT_NTHNL(name, proto, alias) name proto __asm__ (__ASMNAME (#alias)) __THROWNL
#define __REDIRECT_NTH_LDBL(name, proto, alias) __REDIRECT_NTH (name, proto, alias)
#define __REGISTER_PREFIX__
#define __RLIM64_T_TYPE __UQUAD_TYPE
#define __RLIM_T_MATCHES_RLIM64_T 1
#define __RLIM_T_TYPE __SYSCALL_ULONG_TYPE
#define __S16_TYPE short int
#define __S32_TYPE int
#define __S64_TYPE long int
#define __SCHAR_MAX__ 127
#define __SEG_FS 1
#define __SEG_GS 1
#define __SHRT_MAX__ 32767
#define __SIGEV_MAX_SIZE 64
#define __SIGEV_PAD_SIZE ((__SIGEV_MAX_SIZE / sizeof (int)) - 4)
#define __SIGRTMAX 64
#define __SIGRTMIN 32
#define __SIG_ATOMIC_MAX__ 2147483647
#define __SIG_ATOMIC_WIDTH__ 32
#define __SIMD_DECL(function) __CONCAT (__DECL_SIMD_, function)
#define __SIZEOF_DOUBLE__ 8
#define __SIZEOF_FLOAT128__ 16
#define __SIZEOF_FLOAT__ 4
#define __SIZEOF_INT128__ 16
#define __SIZEOF_INT__ 4
#define __SIZEOF_LONG_DOUBLE__ 16
#define __SIZEOF_LONG_LONG__ 8
#define __SIZEOF_LONG__ 8
#define __SIZEOF_POINTER__ 8
#define __SIZEOF_PTHREAD_ATTR_T 56
#define __SIZEOF_PTHREAD_BARRIERATTR_T 4
#define __SIZEOF_PTHREAD_BARRIER_T 32
#define __SIZEOF_PTHREAD_CONDATTR_T 4
#define __SIZEOF_PTHREAD_COND_T 48
#define __SIZEOF_PTHREAD_MUTEXATTR_T 4
#define __SIZEOF_PTHREAD_MUTEX_T 40
#define __SIZEOF_PTHREAD_RWLOCKATTR_T 8
#define __SIZEOF_PTHREAD_RWLOCK_T 56
#define __SIZEOF_PTRDIFF_T__ 8
#define __SIZEOF_SHORT__ 2
#define __SIZEOF_SIZE_T__ 8
#define __SIZEOF_WCHAR_T__ 4
#define __SIZEOF_WINT_T__ 4
#define __SIZE_FMTX__ "lX"
#define __SIZE_FMTo__ "lo"
#define __SIZE_FMTu__ "lu"
#define __SIZE_FMTx__ "lx"
#define __SIZE_MAX__ 18446744073709551615UL
#define __SIZE_TYPE__ long unsigned int
#define __SIZE_WIDTH__ 64
#define __SI_ALIGNMENT
#define __SI_ASYNCIO_AFTER_SIGIO 1
#define __SI_BAND_TYPE long int
#define __SI_CLOCK_T __clock_t
#define __SI_ERRNO_THEN_CODE 1
#define __SI_HAVE_SIGSYS 1
#define __SI_MAX_SIZE 128
#define __SI_PAD_SIZE ((__SI_MAX_SIZE / sizeof (int)) - 4)
#define __SI_SIGFAULT_ADDL
#define __SLONG32_TYPE int
#define __SLONGWORD_TYPE long int
#define __SOCKADDR_ARG struct sockaddr *__restrict
#define __SOCKADDR_COMMON(sa_prefix) sa_family_t sa_prefix##family
#define __SOCKADDR_COMMON_SIZE (sizeof (unsigned short int))
#define __SQUAD_TYPE long int
#define __SSE2_MATH__ 1
#define __SSE2__ 1
#define __SSE_MATH__ 1
#define __SSE__ 1
#define __SSIZE_T_TYPE __SWORD_TYPE
#define __STDARG_H
#define __STDBOOL_H
#define __STDC_CONSTANT_MACROS 1
#define __STDC_HOSTED__ 1
#define __STDC_IEC_559_COMPLEX__ 1
#define __STDC_IEC_559__ 1
#define __STDC_ISO_10646__ 201706L
#define __STDC_LIMIT_MACROS 1
#define __STDC_NO_THREADS__ 1
#define __STDC_UTF_16__ 1
#define __STDC_UTF_32__ 1
#define __STDC_VERSION__ 201112L
#define __STDC__ 1
#define __STDDEF_H
#define __STRING(x) #x
#define __SUSECONDS_T_TYPE __SYSCALL_SLONG_TYPE
#define __SWORD_TYPE long int
#define __SYSCALL_SLONG_TYPE __SLONGWORD_TYPE
#define __SYSCALL_ULONG_TYPE __ULONGWORD_TYPE
#define __SYSCALL_WORDSIZE 64
#define __SYSMACROS_DM(symbol) __SYSMACROS_DM1 (In the GNU C Library, #symbol is defined\n by <sys/sysmacros.h>. For historical compatibility, it is\n currently defined by <sys/types.h> as well, but we plan to\n remove this soon. To use #symbol, include <sys/sysmacros.h>\n directly. If you did not intend to use a system-defined macro\n #symbol, you should undefine it after including <sys/types.h>.)
#define __SYSMACROS_DM1(...) __glibc_macro_warning (#__VA_ARGS__)
#define __S_IEXEC 0100
#define __S_IFBLK 0060000
#define __S_IFCHR 0020000
#define __S_IFDIR 0040000
#define __S_IFIFO 0010000
#define __S_IFLNK 0120000
#define __S_IFMT 0170000
#define __S_IFREG 0100000
#define __S_IFSOCK 0140000
#define __S_IREAD 0400
#define __S_ISGID 02000
#define __S_ISUID 04000
#define __S_ISVTX 01000
#define __S_IWRITE 0200
#define __S_TYPEISMQ(buf) ((buf)->st_mode - (buf)->st_mode)
#define __S_TYPEISSEM(buf) ((buf)->st_mode - (buf)->st_mode)
#define __S_TYPEISSHM(buf) ((buf)->st_mode - (buf)->st_mode)
#define __THROW __attribute__ ((__nothrow__ __LEAF))
#define __THROWNL __attribute__ ((__nothrow__))
#define __TIMER_T_TYPE void *
#define __TIME_T_TYPE __SYSCALL_SLONG_TYPE
#define __U16_TYPE unsigned short int
#define __U32_TYPE unsigned int
#define __U64_TYPE unsigned long int
#define __UID_T_TYPE __U32_TYPE
#define __UINT16_C_SUFFIX__
#define __UINT16_FMTX__ "hX"
#define __UINT16_FMTo__ "ho"
#define __UINT16_FMTu__ "hu"
#define __UINT16_FMTx__ "hx"
#define __UINT16_MAX__ 65535
#define __UINT16_TYPE__ unsigned short
#define __UINT32_C_SUFFIX__ U
#define __UINT32_FMTX__ "X"
#define __UINT32_FMTo__ "o"
#define __UINT32_FMTu__ "u"
#define __UINT32_FMTx__ "x"
#define __UINT32_MAX__ 4294967295U
#define __UINT32_TYPE__ unsigned int
#define __UINT64_C(c) c ## UL
#define __UINT64_C_SUFFIX__ UL
#define __UINT64_FMTX__ "lX"
#define __UINT64_FMTo__ "lo"
#define __UINT64_FMTu__ "lu"
#define __UINT64_FMTx__ "lx"
#define __UINT64_MAX__ 18446744073709551615UL
#define __UINT64_TYPE__ long unsigned int
#define __UINT8_C_SUFFIX__
#define __UINT8_FMTX__ "hhX"
#define __UINT8_FMTo__ "hho"
#define __UINT8_FMTu__ "hhu"
#define __UINT8_FMTx__ "hhx"
#define __UINT8_MAX__ 255
#define __UINT8_TYPE__ unsigned char
#define __UINTMAX_C_SUFFIX__ UL
#define __UINTMAX_FMTX__ "lX"
#define __UINTMAX_FMTo__ "lo"
#define __UINTMAX_FMTu__ "lu"
#define __UINTMAX_FMTx__ "lx"
#define __UINTMAX_MAX__ 18446744073709551615UL
#define __UINTMAX_TYPE__ long unsigned int
#define __UINTMAX_WIDTH__ 64
#define __UINTPTR_FMTX__ "lX"
#define __UINTPTR_FMTo__ "lo"
#define __UINTPTR_FMTu__ "lu"
#define __UINTPTR_FMTx__ "lx"
#define __UINTPTR_MAX__ 18446744073709551615UL
#define __UINTPTR_TYPE__ long unsigned int
#define __UINTPTR_WIDTH__ 64
#define __UINT_FAST16_FMTX__ "hX"
#define __UINT_FAST16_FMTo__ "ho"
#define __UINT_FAST16_FMTu__ "hu"
#define __UINT_FAST16_FMTx__ "hx"
#define __UINT_FAST16_MAX__ 65535
#define __UINT_FAST16_TYPE__ unsigned short
#define __UINT_FAST32_FMTX__ "X"
#define __UINT_FAST32_FMTo__ "o"
#define __UINT_FAST32_FMTu__ "u"
#define __UINT_FAST32_FMTx__ "x"
#define __UINT_FAST32_MAX__ 4294967295U
#define __UINT_FAST32_TYPE__ unsigned int
#define __UINT_FAST64_FMTX__ "lX"
#define __UINT_FAST64_FMTo__ "lo"
#define __UINT_FAST64_FMTu__ "lu"
#define __UINT_FAST64_FMTx__ "lx"
#define __UINT_FAST64_MAX__ 18446744073709551615UL
#define __UINT_FAST64_TYPE__ long unsigned int
#define __UINT_FAST8_FMTX__ "hhX"
#define __UINT_FAST8_FMTo__ "hho"
#define __UINT_FAST8_FMTu__ "hhu"
#define __UINT_FAST8_FMTx__ "hhx"
#define __UINT_FAST8_MAX__ 255
#define __UINT_FAST8_TYPE__ unsigned char
#define __UINT_LEAST16_FMTX__ "hX"
#define __UINT_LEAST16_FMTo__ "ho"
#define __UINT_LEAST16_FMTu__ "hu"
#define __UINT_LEAST16_FMTx__ "hx"
#define __UINT_LEAST16_MAX__ 65535
#define __UINT_LEAST16_TYPE__ unsigned short
#define __UINT_LEAST32_FMTX__ "X"
#define __UINT_LEAST32_FMTo__ "o"
#define __UINT_LEAST32_FMTu__ "u"
#define __UINT_LEAST32_FMTx__ "x"
#define __UINT_LEAST32_MAX__ 4294967295U
#define __UINT_LEAST32_TYPE__ unsigned int
#define __UINT_LEAST64_FMTX__ "lX"
#define __UINT_LEAST64_FMTo__ "lo"
#define __UINT_LEAST64_FMTu__ "lu"
#define __UINT_LEAST64_FMTx__ "lx"
#define __UINT_LEAST64_MAX__ 18446744073709551615UL
#define __UINT_LEAST64_TYPE__ long unsigned int
#define __UINT_LEAST8_FMTX__ "hhX"
#define __UINT_LEAST8_FMTo__ "hho"
#define __UINT_LEAST8_FMTu__ "hhu"
#define __UINT_LEAST8_FMTx__ "hhx"
#define __UINT_LEAST8_MAX__ 255
#define __UINT_LEAST8_TYPE__ unsigned char
#define __ULONG32_TYPE unsigned int
#define __ULONGWORD_TYPE unsigned long int
#define __UQUAD_TYPE unsigned long int
#define __USECONDS_T_TYPE __U32_TYPE
#define __USER_LABEL_PREFIX__
#define __USE_ATFILE 1
#define __USE_EXTERN_INLINES 1
#define __USE_FORTIFY_LEVEL 0
#define __USE_ISOC11 1
#define __USE_ISOC95 1
#define __USE_ISOC99 1
#define __USE_MISC 1
#define __USE_POSIX 1
#define __USE_POSIX199309 1
#define __USE_POSIX199506 1
#define __USE_POSIX2 1
#define __USE_POSIX_IMPLICITLY 1
#define __USE_XOPEN2K 1
#define __USE_XOPEN2K8 1
#define __UWORD_TYPE unsigned long int
#define __VERSION__ "Clang 9.0.0 (tags/RELEASE_900/final)"
#define __WALL 0x40000000
#define __WCHAR_MAX __WCHAR_MAX__
#define __WCHAR_MAX__ 2147483647
#define __WCHAR_MIN (-__WCHAR_MAX - 1)
#define __WCHAR_TYPE__ int
#define __WCHAR_WIDTH__ 32
#define __WCLONE 0x80000000
#define __WCOREDUMP(status) ((status) & __WCOREFLAG)
#define __WCOREFLAG 0x80
#define __WEXITSTATUS(status) (((status) & 0xff00) >> 8)
#define __WIFCONTINUED(status) ((status) == __W_CONTINUED)
#define __WIFEXITED(status) (__WTERMSIG(status) == 0)
#define __WIFSIGNALED(status) (((signed char) (((status) & 0x7f) + 1) >> 1) > 0)
#define __WIFSTOPPED(status) (((status) & 0xff) == 0x7f)
#define __WINT_MAX__ 4294967295U
#define __WINT_TYPE__ unsigned int
#define __WINT_UNSIGNED__ 1
#define __WINT_WIDTH__ 32
#define __WNOTHREAD 0x20000000
#define __WORDSIZE 64
#define __WORDSIZE_TIME64_COMPAT32 1
#define __WSTOPSIG(status) __WEXITSTATUS(status)
#define __WTERMSIG(status) ((status) & 0x7f)
#define __W_CONTINUED 0xffff
#define __W_EXITCODE(ret, sig) ((ret) << 8 | (sig))
#define __W_STOPCODE(sig) ((sig) << 8 | 0x7f)
#define ____FILE_defined 1
#define ____gwchar_t_defined 1
#define ____mbstate_t_defined 1
#define ____sigset_t_defined
#define ____sigval_t_defined
#define __always_inline __inline __attribute__ ((__always_inline__))
#define __amd64 1
#define __amd64__ 1
#define __attribute_alloc_size__(params)
#define __attribute_artificial__
#define __attribute_const__ __attribute__ ((__const__))
#define __attribute_deprecated__ __attribute__ ((__deprecated__))
#define __attribute_deprecated_msg__(msg) __attribute__ ((__deprecated__ (msg)))
#define __attribute_format_arg__(x) __attribute__ ((__format_arg__ (x)))
#define __attribute_format_strfmon__(a, b) __attribute__ ((__format__ (__strfmon__, a, b)))
#define __attribute_malloc__ __attribute__ ((__malloc__))
#define __attribute_noinline__ __attribute__ ((__noinline__))
#define __attribute_nonstring__
#define __attribute_pure__ __attribute__ ((__pure__))
#define __attribute_used__ __attribute__ ((__used__))
#define __attribute_warn_unused_result__ __attribute__ ((__warn_unused_result__))
#define __autoreleasing __attribute__((objc_ownership(autoreleasing)))
#define __blkcnt_t_defined
#define __blksize_t_defined
#define __block __attribute__((__blocks__(byref)))
#define __bool_true_false_are_defined 1
#define __bos(ptr) __builtin_object_size (ptr, __USE_FORTIFY_LEVEL > 1)
#define __bos0(ptr) __builtin_object_size (ptr, 0)
#define __bswap_16(x) (__extension__ ({ unsigned short int __v, __x = (unsigned short int) (x); if (__builtin_constant_p (__x)) __v = __bswap_constant_16 (__x); else __asm__ ("rorw $8, %w0" : "=r" (__v) : "0" (__x) : "cc"); __v; }))
#define __bswap_32(x) (__extension__ ({ unsigned int __v, __x = (x); if (__builtin_constant_p (__x)) __v = __bswap_constant_32 (__x); else __asm__ ("bswap %0" : "=r" (__v) : "0" (__x)); __v; }))
#define __bswap_64(x) (__extension__ ({ __uint64_t __v, __x = (x); if (__builtin_constant_p (__x)) __v = __bswap_constant_64 (__x); else __asm__ ("bswap %q0" : "=r" (__v) : "0" (__x)); __v; }))
#define __bswap_constant_16(x) ((unsigned short int) ((((x) >> 8) & 0xff) | (((x) & 0xff) << 8)))
#define __bswap_constant_32(x) ((((x) & 0xff000000) >> 24) | (((x) & 0x00ff0000) >> 8) | (((x) & 0x0000ff00) << 8) | (((x) & 0x000000ff) << 24))
#define __bswap_constant_64(x) (__extension__ ((((x) & 0xff00000000000000ull) >> 56) | (((x) & 0x00ff000000000000ull) >> 40) | (((x) & 0x0000ff0000000000ull) >> 24) | (((x) & 0x000000ff00000000ull) >> 8) | (((x) & 0x00000000ff000000ull) << 8) | (((x) & 0x0000000000ff0000ull) << 24) | (((x) & 0x000000000000ff00ull) << 40) | (((x) & 0x00000000000000ffull) << 56)))
#define __builtin_huge_valf32() (__builtin_huge_valf ())
#define __builtin_huge_valf32x() (__builtin_huge_val ())
#define __builtin_huge_valf64() (__builtin_huge_val ())
#define __builtin_huge_valf64x() (__builtin_huge_vall ())
#define __builtin_inff32() (__builtin_inff ())
#define __builtin_inff32x() (__builtin_inf ())
#define __builtin_inff64() (__builtin_inf ())
#define __builtin_inff64x() (__builtin_infl ())
#define __builtin_nanf32(x) (__builtin_nanf (x))
#define __builtin_nanf32x(x) (__builtin_nan (x))
#define __builtin_nanf64(x) (__builtin_nan (x))
#define __builtin_nanf64x(x) (__builtin_nanl (x))
#define __builtin_nansf32(x) (__builtin_nansf (x))
#define __builtin_nansf32x(x) (__builtin_nans (x))
#define __builtin_nansf64(x) (__builtin_nans (x))
#define __builtin_nansf64x(x) (__builtin_nansl (x))
#define __clang__ 1
#define __clang_major__ 9
#define __clang_minor__ 0
#define __clang_patchlevel__ 0
#define __clang_version__ "9.0.0 (tags/RELEASE_900/final)"
#define __clock_t_defined 1
#define __clockid_t_defined 1
#define __code_model_small_ 1
#define __daddr_t_defined
#define __dev_t_defined
#define __errordecl(name, msg) extern void name (void)
#define __exctype(name) extern int name (int) __THROW
#define __exctype_l(name) extern int name (int, locale_t) __THROW
#define __extern_always_inline extern __always_inline __attribute__ ((__gnu_inline__))
#define __extern_inline extern __inline __attribute__ ((__gnu_inline__))
#define __f32(x) x##f
#define __f32x(x) x
#define __f64(x) x
#define __f64x(x) x##l
#define __flexarr []
#define __fortify_function __extern_always_inline __attribute_artificial__
#define __fsblkcnt_t_defined
#define __fsfilcnt_t_defined
#define __gid_t_defined
#define __glibc_c99_flexarr_available 1
#define __glibc_clang_has_extension(ext) __has_extension (ext)
#define __glibc_clang_prereq(maj, min) ((__clang_major__ << 16) + __clang_minor__ >= ((maj) << 16) + (min))
#define __glibc_likely(cond) __builtin_expect ((cond), 1)
#define __glibc_macro_warning(message) __glibc_macro_warning1 (GCC warning message)
#define __glibc_macro_warning1(message) _Pragma (#message)
#define __glibc_unlikely(cond) __builtin_expect ((cond), 0)
#define __gnu_linux__ 1
#define __have_pthread_attr_t 1
#define __id_t_defined
#define __ino_t_defined
#define __intptr_t_defined
#define __iovec_defined 1
#define __isalnum_l(c, l) __isctype_l((c), _ISalnum, (l))
#define __isalpha_l(c, l) __isctype_l((c), _ISalpha, (l))
#define __isascii(c) (((c) & ~0x7f) == 0)
#define __isascii_l(c, l) ((l), __isascii (c))
#define __isblank_l(c, l) __isctype_l((c), _ISblank, (l))
#define __iscntrl_l(c, l) __isctype_l((c), _IScntrl, (l))
#define __isctype(c, type) ((*__ctype_b_loc ())[(int) (c)] & (unsigned short int) type)
#define __isctype_l(c, type, locale) ((locale)->__ctype_b[(int) (c)] & (unsigned short int) type)
#define __isdigit_l(c, l) __isctype_l((c), _ISdigit, (l))
#define __isgraph_l(c, l) __isctype_l((c), _ISgraph, (l))
#define __isleap(year) ((year) % 4 == 0 && ((year) % 100 != 0 || (year) % 400 == 0))
#define __islower_l(c, l) __isctype_l((c), _ISlower, (l))
#define __isprint_l(c, l) __isctype_l((c), _ISprint, (l))
#define __ispunct_l(c, l) __isctype_l((c), _ISpunct, (l))
#define __isspace_l(c, l) __isctype_l((c), _ISspace, (l))
#define __isupper_l(c, l) __isctype_l((c), _ISupper, (l))
#define __isxdigit_l(c, l) __isctype_l((c), _ISxdigit, (l))
#define __itimerspec_defined 1
#define __k8 1
#define __k8__ 1
#define __key_t_defined
#define __ldiv_t_defined 1
#define __linux 1
#define __linux__ 1
#define __lldiv_t_defined 1
#define __llvm__ 1
#define __mode_t_defined
#define __need___va_list
#define __nlink_t_defined
#define __nonnull(params) __attribute__ ((__nonnull__ params))
#define __objc_INCLUDE_GNU
#define __objc_api_INCLUDE_GNU
#define __off_t_defined
#define __osockaddr_defined 1
#define __pic__ 2
#define __pid_t_defined
#define __ptr_t void *
#define __restrict_arr __restrict
#define __seg_fs __attribute__((address_space(257)))
#define __seg_gs __attribute__((address_space(256)))
#define __sig_atomic_t_defined 1
#define __sigevent_t_defined 1
#define __siginfo_t_defined 1
#define __sigset_t_defined 1
#define __sigstack_defined 1
#define __sigval_t_defined
#define __socklen_t_defined
#define __ss_aligntype unsigned long int
#define __ssize_t_defined
#define __stack_t_defined 1
#define __strong __attribute__((objc_ownership(strong)))
#define __struct_tm_defined 1
#define __stub___compat_bdflush
#define __stub_chflags
#define __stub_fattach
#define __stub_fchflags
#define __stub_fdetach
#define __stub_getmsg
#define __stub_gtty
#define __stub_lchmod
#define __stub_putmsg
#define __stub_revoke
#define __stub_setlogin
#define __stub_sigreturn
#define __stub_sstk
#define __stub_stty
#define __suseconds_t_defined
#define __time_t_defined 1
#define __timer_t_defined 1
#define __timespec_defined 1
#define __timeval_defined 1
#define __toascii(c) ((c) & 0x7f)
#define __toascii_l(c, l) ((l), __toascii (c))
#define __tobody(c, f, a, args) (__extension__ ({ int __res; if (sizeof (c) > 1) { if (__builtin_constant_p (c)) { int __c = (c); __res = __c < -128 || __c > 255 ? __c : (a)[__c]; } else __res = f args; } else __res = (a)[(int) (c)]; __res; }))
#define __tolower_l(c, locale) __tobody (c, __tolower_l, (locale)->__ctype_tolower, (c, locale))
#define __toupper_l(c, locale) __tobody (c, __toupper_l, (locale)->__ctype_toupper, (c, locale))
#define __tune_k8__ 1
#define __u_char_defined
#define __u_intN_t(N, MODE) typedef unsigned int u_int##N##_t __attribute__ ((__mode__ (MODE)))
#define __uid_t_defined
#define __unix 1
#define __unix__ 1
#define __unsafe_unretained __attribute__((objc_ownership(none)))
#define __useconds_t_defined
#define __va_copy(d, s) __builtin_va_copy(d,s)
#define __warnattr(msg)
#define __warndecl(name, msg) extern void name (void)
#define __weak __attribute__((objc_ownership(weak)))
#define __wur
#define __x86_64 1
#define __x86_64__ 1
#define _autorepeat _cell.subclass_bool_one
#define _becomesKeyOnlyIfNeeded _f.subclass_bool_one
#define _browsercell_is_leaf _cell.subclass_bool_one
#define _browsercell_is_loaded _cell.subclass_bool_two
#define _buttoncell_is_transparent _cell.subclass_bool_one
#define _formcell_auto_title_width _cell.subclass_bool_one
#define _formcell_placeholder_is_attributed_string _cell.subclass_bool_two
#define _image_dims_when_disabled _cell.subclass_bool_two
#define _isFloatingPanel _f.subclass_bool_two
#define _mouse_inside _cell.subclass_bool_four
#define _shows_border_only_while_mouse_inside _cell.subclass_bool_three
#define _textfieldcell_draws_background _cell.subclass_bool_one
#define _textfieldcell_placeholder_is_attributed_string _cell.subclass_bool_three
#define _tolower(c) ((int) (*__ctype_tolower_loc ())[(int) (c)])
#define _toupper(c) ((int) (*__ctype_toupper_loc ())[(int) (c)])
#define _valueWraps _cell.subclass_bool_two
#define _worksWhenModal _f.subclass_bool_three
#define alloca(size) __builtin_alloca (size)
#define assert(expr) ((void) sizeof ((expr) ? 1 : 0), __extension__ ({ if (expr) ; else __assert_fail (#expr, __FILE__, __LINE__, __ASSERT_FUNCTION); }))
#define be16toh(x) __bswap_16 (x)
#define be32toh(x) __bswap_32 (x)
#define be64toh(x) __bswap_64 (x)
#define bool _Bool
#define clrbit(a, i) ((a)[(i)/NBBY] &= ~(1<<((i)%NBBY)))
#define dispatch_assert_queue_barrier_debug(q) dispatch_assert_queue_barrier(q)
#define dispatch_assert_queue_debug(q) dispatch_assert_queue(q)
#define dispatch_assert_queue_not_debug(q) dispatch_assert_queue_not(q)
#define dispatch_cancel(object) _Generic((object), dispatch_block_t:dispatch_block_cancel, dispatch_source_t:dispatch_source_cancel )((object))
#define dispatch_compiler_barrier() __asm__ __volatile__("" ::: "memory")
#define dispatch_data_empty DISPATCH_GLOBAL_OBJECT(dispatch_data_t, _dispatch_data_empty)
#define dispatch_notify(object, queue, notification_block) _Generic((object), dispatch_block_t:dispatch_block_notify, dispatch_group_t:dispatch_group_notify )((object),(queue), (notification_block))
#define dispatch_once _dispatch_once
#define dispatch_once_f _dispatch_once_f
#define dispatch_testcancel(object) _Generic((object), dispatch_block_t:dispatch_block_testcancel, dispatch_source_t:dispatch_source_testcancel )((object))
#define dispatch_wait(object, timeout) _Generic((object), dispatch_block_t:dispatch_block_wait, dispatch_group_t:dispatch_group_wait, dispatch_semaphore_t:dispatch_semaphore_wait )((object),(timeout))
#define errno (*__errno_location ())
#define false 0
#define fpclassify(x) __MATH_TG ((x), __fpclassify, (x))
#define fread_unlocked(ptr, size, n, stream) (__extension__ ((__builtin_constant_p (size) && __builtin_constant_p (n) && (size_t) (size) * (size_t) (n) <= 8 && (size_t) (size) != 0) ? ({ char *__ptr = (char *) (ptr); FILE *__stream = (stream); size_t __cnt; for (__cnt = (size_t) (size) * (size_t) (n); __cnt > 0; --__cnt) { int __c = _IO_getc_unlocked (__stream); if (__c == EOF) break; *__ptr++ = __c; } ((size_t) (size) * (size_t) (n) - __cnt) / (size_t) (size); }) : (((__builtin_constant_p (size) && (size_t) (size) == 0) || (__builtin_constant_p (n) && (size_t) (n) == 0)) ? ((void) (ptr), (void) (stream), (void) (size), (void) (n), (size_t) 0) : fread_unlocked (ptr, size, n, stream))))
#define fwrite_unlocked(ptr, size, n, stream) (__extension__ ((__builtin_constant_p (size) && __builtin_constant_p (n) && (size_t) (size) * (size_t) (n) <= 8 && (size_t) (size) != 0) ? ({ const char *__ptr = (const char *) (ptr); FILE *__stream = (stream); size_t __cnt; for (__cnt = (size_t) (size) * (size_t) (n); __cnt > 0; --__cnt) if (_IO_putc_unlocked (*__ptr++, __stream) == EOF) break; ((size_t) (size) * (size_t) (n) - __cnt) / (size_t) (size); }) : (((__builtin_constant_p (size) && (size_t) (size) == 0) || (__builtin_constant_p (n) && (size_t) (n) == 0)) ? ((void) (ptr), (void) (stream), (void) (size), (void) (n), (size_t) 0) : fwrite_unlocked (ptr, size, n, stream))))
#define getc(_fp) _IO_getc (_fp)
#define howmany(x, y) (((x) + ((y) - 1)) / (y))
#define htobe16(x) __bswap_16 (x)
#define htobe32(x) __bswap_32 (x)
#define htobe64(x) __bswap_64 (x)
#define htole16(x) __uint16_identity (x)
#define htole32(x) __uint32_identity (x)
#define htole64(x) __uint64_identity (x)
#define included_GSConfig_h
#define init_autorelease_thread_vars(TV) memset (TV, 0, sizeof (__typeof__ (*TV)))
#define isalnum(c) __isctype((c), _ISalnum)
#define isalnum_l(c, l) __isalnum_l ((c), (l))
#define isalpha(c) __isctype((c), _ISalpha)
#define isalpha_l(c, l) __isalpha_l ((c), (l))
#define isascii(c) __isascii (c)
#define isascii_l(c, l) __isascii_l ((c), (l))
#define isblank(c) __isctype((c), _ISblank)
#define isblank_l(c, l) __isblank_l ((c), (l))
#define isclr(a, i) (((a)[(i)/NBBY] & (1<<((i)%NBBY))) == 0)
#define iscntrl(c) __isctype((c), _IScntrl)
#define iscntrl_l(c, l) __iscntrl_l ((c), (l))
#define isdigit(c) __isctype((c), _ISdigit)
#define isdigit_l(c, l) __isdigit_l ((c), (l))
#define isfinite(x) __MATH_TG ((x), __finite, (x))
#define isgraph(c) __isctype((c), _ISgraph)
#define isgraph_l(c, l) __isgraph_l ((c), (l))
#define isgreater(x, y) __builtin_isgreater(x, y)
#define isgreaterequal(x, y) __builtin_isgreaterequal(x, y)
#define isinf(x) __MATH_TG ((x), __isinf, (x))
#define isless(x, y) __builtin_isless(x, y)
#define islessequal(x, y) __builtin_islessequal(x, y)
#define islessgreater(x, y) __builtin_islessgreater(x, y)
#define islower(c) __isctype((c), _ISlower)
#define islower_l(c, l) __islower_l ((c), (l))
#define isnan(x) __MATH_TG ((x), __isnan, (x))
#define isnormal(x) (fpclassify (x) == FP_NORMAL)
#define isprint(c) __isctype((c), _ISprint)
#define isprint_l(c, l) __isprint_l ((c), (l))
#define ispunct(c) __isctype((c), _ISpunct)
#define ispunct_l(c, l) __ispunct_l ((c), (l))
#define isset(a, i) ((a)[(i)/NBBY] & (1<<((i)%NBBY)))
#define isspace(c) __isctype((c), _ISspace)
#define isspace_l(c, l) __isspace_l ((c), (l))
#define isunordered(x, y) __builtin_isunordered(x, y)
#define isupper(c) __isctype((c), _ISupper)
#define isupper_l(c, l) __isupper_l ((c), (l))
#define isxdigit(c) __isctype((c), _ISxdigit)
#define isxdigit_l(c, l) __isxdigit_l ((c), (l))
#define le16toh(x) __uint16_identity (x)
#define le32toh(x) __uint32_identity (x)
#define le64toh(x) __uint64_identity (x)
#define linux 1
#define major(dev) gnu_dev_major (dev)
#define makedev(maj, min) gnu_dev_makedev (maj, min)
#define mandalorian(l, t, e) ({ [l lock]; t v; @try { v = (e); } @finally { [l unlock]; } v = v; })
#define math_errhandling 0
#define minor(dev) gnu_dev_minor (dev)
#define nil ((id)_OBJC_NULL_PTR)
#define offsetof(t, d) __builtin_offsetof(t, d)
#define os_likely(x) OS_EXPECT(!!(x), 1)
#define os_unlikely(x) OS_EXPECT(!!(x), 0)
#define powerof2(x) ((((x) - 1) & (x)) == 0)
#define putc(_ch, _fp) _IO_putc (_ch, _fp)
#define roundup(x, y) (__builtin_constant_p (y) && powerof2 (y) ? (((x) + (y) - 1) & ~((y) - 1)) : ((((x) + ((y) - 1)) / (y)) * (y)))
#define sa_handler __sigaction_handler.sa_handler
#define sa_sigaction __sigaction_handler.sa_sigaction
#define setbit(a, i) ((a)[(i)/NBBY] |= 1<<((i)%NBBY))
#define setjmp(env) _setjmp (env)
#define setpptr(p, e) ({ if(p) (*(p)) = (e); })
#define si_addr _sifields._sigfault.si_addr
#define si_addr_lsb _sifields._sigfault.si_addr_lsb
#define si_arch _sifields._sigsys._arch
#define si_band _sifields._sigpoll.si_band
#define si_call_addr _sifields._sigsys._call_addr
#define si_fd _sifields._sigpoll.si_fd
#define si_int _sifields._rt.si_sigval.sival_int
#define si_lower _sifields._sigfault._bounds._addr_bnd._lower
#define si_overrun _sifields._timer.si_overrun
#define si_pid _sifields._kill.si_pid
#define si_pkey _sifields._sigfault._bounds._pkey
#define si_ptr _sifields._rt.si_sigval.sival_ptr
#define si_status _sifields._sigchld.si_status
#define si_stime _sifields._sigchld.si_stime
#define si_syscall _sifields._sigsys._syscall
#define si_timerid _sifields._timer.si_tid
#define si_uid _sifields._kill.si_uid
#define si_upper _sifields._sigfault._bounds._addr_bnd._upper
#define si_utime _sifields._sigchld.si_utime
#define si_value _sifields._rt.si_sigval
#define sigev_notify_attributes _sigev_un._sigev_thread._attribute
#define sigev_notify_function _sigev_un._sigev_thread._function
#define sigmask(sig) ((int)(1u << ((sig) - 1)))
#define signbit(x) __MATH_TG ((x), __builtin_signbit, (x))
#define sigsetjmp(env, savemask) __sigsetjmp (env, savemask)
#define st_atime st_atim.tv_sec
#define st_ctime st_ctim.tv_sec
#define st_mtime st_mtim.tv_sec
#define static_assert _Static_assert
#define stderr stderr
#define stdin stdin
#define stdout stdout
#define toascii(c) __toascii (c)
#define toascii_l(c, l) __toascii_l ((c), (l))
#define tolower(c) __tobody (c, tolower, *__ctype_tolower_loc (), (c))
#define tolower_l(c, locale) __tolower_l ((c), (locale))
#define toupper(c) __tobody (c, toupper, *__ctype_toupper_loc (), (c))
#define toupper_l(c, locale) __toupper_l ((c), (locale))
#define true 1
#define unix 1
#define uuid_t gsuuid_t
#define va_arg(ap, type) __builtin_va_arg(ap, type)
#define va_copy(dest, src) __builtin_va_copy(dest, src)
#define va_end(ap) __builtin_va_end(ap)
#define va_start(ap, param) __builtin_va_start(ap, param)
