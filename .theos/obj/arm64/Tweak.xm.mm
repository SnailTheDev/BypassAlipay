#line 1 "Tweak.xm"
#include "fishhook.h"



#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif




#line 4 "Tweak.xm"
FILE *fopen(const char *path, const char *mode);
__unused static FILE * (*_logos_orig$_ungrouped$fopen)(const char *path, const char *mode); __unused static FILE * _logos_function$_ungrouped$fopen(const char *path, const char *mode) {
	
	NSString *pathString = [NSString stringWithUTF8String:path];
	
	if ([pathString isEqualToString:@"/bin/ssh"]) {
		
		return NULL;
	}
	return _logos_orig$_ungrouped$fopen(path, mode);

}



static char* (*orig_strstr)(const char *__big, const char *__little);
char *my_strstr(const char *__big, const char *__little) {
	
	NSString *littleString = [NSString stringWithUTF8String:__little];	

	if ([littleString isEqualToString:@"MobileSubstrate"] || [littleString isEqualToString:@"Substrate"]) {
		
		return NULL;
	}
	return orig_strstr(__big, __little);
}

static __attribute__((constructor)) void _logosLocalCtor_5c1794ff(int __unused argc, char __unused **argv, char __unused **envp) {
	NSLog(@"----snail hook alipay-----");
	
	rebind_symbols((struct rebinding[1]){{"strstr", (void *)my_strstr, (void **)&orig_strstr}}, 1);
}
static __attribute__((constructor)) void _logosLocalInit() {
{ MSHookFunction((void *)fopen, (void *)&_logos_function$_ungrouped$fopen, (void **)&_logos_orig$_ungrouped$fopen);} }
#line 36 "Tweak.xm"
