/**
 *  J C S O U N D
 * <P>
 *  A Java native interface (JNI style) to "public-domain" Csound.
 *  Copyright (C) 1998 by Michael Gogins. All rights reserved.
 * <P>
 *  This software is licensed under the terms of the GNU General Public License.
 *  It is distributed without charge.
 */
#include "JCsound_Csound.h"
#include <Csound.h>

/**
 *	The actual instance of the Csound API.
 */
static Csound csound;

#ifdef __cplusplus
extern "C" 
{
#endif

extern void (*csLogCallback)(const char *message);

/**	
 *	Called by Csound to print all messages directly to the console of the 
 *	Java virtual machine; equivalent to System.err.println(String message).
 */
void JCsoundLogCallback(const char *message)
{
	fprintf(stderr, message);
}

#ifdef __cplusplus
};
#endif

/*
 * Class:     JCsound_Csound
 * Method:    setCommand
 * Signature: (Ljava/lang/String;)V
 */
JNIEXPORT void JNICALL Java_JCsound_Csound_setCommand(JNIEnv *jniEnv, jobject object, jstring string)
{
	csLogCallback = JCsoundLogCallback;
	const char *commandLine = jniEnv->GetStringUTFChars(string, 0);
	csound.command(commandLine);
	jniEnv->ReleaseStringUTFChars(string, commandLine);
}

/*
 * Class:     JCsound_Csound
 * Method:    run
 * Signature: ()V
 */
JNIEXPORT void JNICALL Java_JCsound_Csound_run(JNIEnv *jniEnv, jobject object)
{
	csound.play();
}

/*
 * Class:     JCsound_Csound
 * Method:    closeAfterRendering
 * Signature: ()V
 */
JNIEXPORT void JNICALL Java_JCsound_Csound_stop(JNIEnv *jniEnv, jobject object)
{
	csound.stop();
}

