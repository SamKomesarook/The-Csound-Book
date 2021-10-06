/* this file contains the actual definitions of */
/* the IIDs and CLSIDs */

/* link this file in with the server and any clients */


/* File created by MIDL compiler version 5.01.0164 */
/* at Sat Mar 13 21:44:25 1999
 */
/* Compiler settings for C:\mkg\Csound\AXCsound\AXCsound.idl:
    Os (OptLev=s), W1, Zp8, env=Win32, ms_ext, c_ext
    error checks: allocation ref bounds_check enum stub_data 
*/
//@@MIDL_FILE_HEADING(  )
#ifdef __cplusplus
extern "C"{
#endif 


#ifndef __IID_DEFINED__
#define __IID_DEFINED__

typedef struct _IID
{
    unsigned long x;
    unsigned short s1;
    unsigned short s2;
    unsigned char  c[8];
} IID;

#endif // __IID_DEFINED__

#ifndef CLSID_DEFINED
#define CLSID_DEFINED
typedef IID CLSID;
#endif // CLSID_DEFINED

const IID IID_IAXCsound = {0x018CD11C,0x20DE,0x11D2,{0x91,0x7D,0x00,0xA0,0xCC,0x30,0xC2,0x76}};


const IID LIBID_AXCSOUNDLib = {0x018CD10F,0x20DE,0x11D2,{0x91,0x7D,0x00,0xA0,0xCC,0x30,0xC2,0x76}};


const IID DIID__IAXCsoundEvents = {0x3DE31672,0xD1A4,0x11D2,{0xAC,0xCC,0x00,0x50,0x04,0x05,0x2B,0xF7}};


const CLSID CLSID_AXCsound = {0x018CD11D,0x20DE,0x11D2,{0x91,0x7D,0x00,0xA0,0xCC,0x30,0xC2,0x76}};


#ifdef __cplusplus
}
#endif

