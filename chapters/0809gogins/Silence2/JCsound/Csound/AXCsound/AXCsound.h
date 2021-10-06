/* this ALWAYS GENERATED file contains the definitions for the interfaces */


/* File created by MIDL compiler version 5.01.0164 */
/* at Sat Mar 13 21:44:25 1999
 */
/* Compiler settings for C:\mkg\Csound\AXCsound\AXCsound.idl:
    Os (OptLev=s), W1, Zp8, env=Win32, ms_ext, c_ext
    error checks: allocation ref bounds_check enum stub_data 
*/
//@@MIDL_FILE_HEADING(  )


/* verify that the <rpcndr.h> version is high enough to compile this file*/
#ifndef __REQUIRED_RPCNDR_H_VERSION__
#define __REQUIRED_RPCNDR_H_VERSION__ 440
#endif

#include "rpc.h"
#include "rpcndr.h"

#ifndef __RPCNDR_H_VERSION__
#error this stub requires an updated version of <rpcndr.h>
#endif // __RPCNDR_H_VERSION__

#ifndef COM_NO_WINDOWS_H
#include "windows.h"
#include "ole2.h"
#endif /*COM_NO_WINDOWS_H*/

#ifndef __AXCsound_h__
#define __AXCsound_h__

#ifdef __cplusplus
extern "C"{
#endif 

/* Forward Declarations */ 

#ifndef __IAXCsound_FWD_DEFINED__
#define __IAXCsound_FWD_DEFINED__
typedef interface IAXCsound IAXCsound;
#endif 	/* __IAXCsound_FWD_DEFINED__ */


#ifndef ___IAXCsoundEvents_FWD_DEFINED__
#define ___IAXCsoundEvents_FWD_DEFINED__
typedef interface _IAXCsoundEvents _IAXCsoundEvents;
#endif 	/* ___IAXCsoundEvents_FWD_DEFINED__ */


#ifndef __AXCsound_FWD_DEFINED__
#define __AXCsound_FWD_DEFINED__

#ifdef __cplusplus
typedef class AXCsound AXCsound;
#else
typedef struct AXCsound AXCsound;
#endif /* __cplusplus */

#endif 	/* __AXCsound_FWD_DEFINED__ */


/* header files for imported files */
#include "oaidl.h"
#include "ocidl.h"

void __RPC_FAR * __RPC_USER MIDL_user_allocate(size_t);
void __RPC_USER MIDL_user_free( void __RPC_FAR * ); 

#ifndef __IAXCsound_INTERFACE_DEFINED__
#define __IAXCsound_INTERFACE_DEFINED__

/* interface IAXCsound */
/* [unique][helpstring][dual][uuid][object] */ 


EXTERN_C const IID IID_IAXCsound;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("018CD11C-20DE-11D2-917D-00A0CC30C276")
    IAXCsound : public IDispatch
    {
    public:
        virtual /* [id][propput] */ HRESULT STDMETHODCALLTYPE put_AutoSize( 
            /* [in] */ VARIANT_BOOL vbool) = 0;
        
        virtual /* [id][propget] */ HRESULT STDMETHODCALLTYPE get_AutoSize( 
            /* [retval][out] */ VARIANT_BOOL __RPC_FAR *pbool) = 0;
        
        virtual /* [id][propput] */ HRESULT STDMETHODCALLTYPE put_Caption( 
            /* [in] */ BSTR strCaption) = 0;
        
        virtual /* [id][propget] */ HRESULT STDMETHODCALLTYPE get_Caption( 
            /* [retval][out] */ BSTR __RPC_FAR *pstrCaption) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE Play( void) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE Pause( void) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE Resume( void) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE Stop( void) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE Open( 
            BSTR Filename) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE Import( 
            BSTR Filename) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE Save( 
            BSTR Filename) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE Export( 
            BSTR Filename) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE OpenSound( void) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_Filename( 
            /* [retval][out] */ BSTR __RPC_FAR *pVal) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_Filename( 
            /* [in] */ BSTR newVal) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_Command( 
            /* [retval][out] */ BSTR __RPC_FAR *pVal) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_Command( 
            /* [in] */ BSTR newVal) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_OrcFilename( 
            /* [retval][out] */ BSTR __RPC_FAR *pVal) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_ScoFilename( 
            /* [retval][out] */ BSTR __RPC_FAR *pVal) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_MidiFilename( 
            /* [retval][out] */ BSTR __RPC_FAR *pVal) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_OutputSoundfileName( 
            /* [retval][out] */ BSTR __RPC_FAR *pVal) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_Score( 
            /* [retval][out] */ BSTR __RPC_FAR *pVal) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_Score( 
            /* [in] */ BSTR newVal) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_ScoreLine( 
            /* [in] */ long Index,
            /* [retval][out] */ BSTR __RPC_FAR *pVal) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_ScoreLine( 
            /* [in] */ long Index,
            /* [in] */ BSTR newVal) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE AddScoreLine( 
            BSTR Note) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE AddNote10( 
            double p1,
            double p2,
            double p3,
            double p4,
            double p5,
            double p6,
            double p7,
            double p8,
            double p9,
            double p10) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE AddNote9( 
            double p1,
            double p2,
            double p3,
            double p4,
            double p5,
            double p6,
            double p7,
            double p8,
            double p9) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE AddNote8( 
            double p1,
            double p2,
            double p3,
            double p4,
            double p5,
            double p6,
            double p7,
            double p8) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE AddNote7( 
            double p1,
            double p2,
            double p3,
            double p4,
            double p5,
            double p6,
            double p7) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE AddNote6( 
            double p1,
            double p2,
            double p3,
            double p4,
            double p5,
            double p6) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE AddNote5( 
            double p1,
            double p2,
            double p3,
            double p4,
            double p5) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE AddNote4( 
            double p1,
            double p2,
            double p3,
            double p4) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE AddNote3( 
            double p1,
            double p2,
            double p3) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_ScoreLineCount( 
            /* [retval][out] */ long __RPC_FAR *pVal) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_ScoreLineCount( 
            /* [in] */ long newVal) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_Orchestra( 
            /* [retval][out] */ BSTR __RPC_FAR *pVal) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_Orchestra( 
            /* [in] */ BSTR newVal) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE RemoveAll( void) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE RemoveCommand( void) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE RemoveOrchestra( void) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE RemoveScore( void) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE RemoveScoreExceptFunctions( void) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE UpdateView( void) = 0;
        
    };
    
#else 	/* C style interface */

    typedef struct IAXCsoundVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *QueryInterface )( 
            IAXCsound __RPC_FAR * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ void __RPC_FAR *__RPC_FAR *ppvObject);
        
        ULONG ( STDMETHODCALLTYPE __RPC_FAR *AddRef )( 
            IAXCsound __RPC_FAR * This);
        
        ULONG ( STDMETHODCALLTYPE __RPC_FAR *Release )( 
            IAXCsound __RPC_FAR * This);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetTypeInfoCount )( 
            IAXCsound __RPC_FAR * This,
            /* [out] */ UINT __RPC_FAR *pctinfo);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetTypeInfo )( 
            IAXCsound __RPC_FAR * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo __RPC_FAR *__RPC_FAR *ppTInfo);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetIDsOfNames )( 
            IAXCsound __RPC_FAR * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR __RPC_FAR *rgszNames,
            /* [in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID __RPC_FAR *rgDispId);
        
        /* [local] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *Invoke )( 
            IAXCsound __RPC_FAR * This,
            /* [in] */ DISPID dispIdMember,
            /* [in] */ REFIID riid,
            /* [in] */ LCID lcid,
            /* [in] */ WORD wFlags,
            /* [out][in] */ DISPPARAMS __RPC_FAR *pDispParams,
            /* [out] */ VARIANT __RPC_FAR *pVarResult,
            /* [out] */ EXCEPINFO __RPC_FAR *pExcepInfo,
            /* [out] */ UINT __RPC_FAR *puArgErr);
        
        /* [id][propput] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *put_AutoSize )( 
            IAXCsound __RPC_FAR * This,
            /* [in] */ VARIANT_BOOL vbool);
        
        /* [id][propget] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *get_AutoSize )( 
            IAXCsound __RPC_FAR * This,
            /* [retval][out] */ VARIANT_BOOL __RPC_FAR *pbool);
        
        /* [id][propput] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *put_Caption )( 
            IAXCsound __RPC_FAR * This,
            /* [in] */ BSTR strCaption);
        
        /* [id][propget] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *get_Caption )( 
            IAXCsound __RPC_FAR * This,
            /* [retval][out] */ BSTR __RPC_FAR *pstrCaption);
        
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *Play )( 
            IAXCsound __RPC_FAR * This);
        
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *Pause )( 
            IAXCsound __RPC_FAR * This);
        
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *Resume )( 
            IAXCsound __RPC_FAR * This);
        
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *Stop )( 
            IAXCsound __RPC_FAR * This);
        
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *Open )( 
            IAXCsound __RPC_FAR * This,
            BSTR Filename);
        
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *Import )( 
            IAXCsound __RPC_FAR * This,
            BSTR Filename);
        
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *Save )( 
            IAXCsound __RPC_FAR * This,
            BSTR Filename);
        
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *Export )( 
            IAXCsound __RPC_FAR * This,
            BSTR Filename);
        
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *OpenSound )( 
            IAXCsound __RPC_FAR * This);
        
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *get_Filename )( 
            IAXCsound __RPC_FAR * This,
            /* [retval][out] */ BSTR __RPC_FAR *pVal);
        
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *put_Filename )( 
            IAXCsound __RPC_FAR * This,
            /* [in] */ BSTR newVal);
        
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *get_Command )( 
            IAXCsound __RPC_FAR * This,
            /* [retval][out] */ BSTR __RPC_FAR *pVal);
        
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *put_Command )( 
            IAXCsound __RPC_FAR * This,
            /* [in] */ BSTR newVal);
        
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *get_OrcFilename )( 
            IAXCsound __RPC_FAR * This,
            /* [retval][out] */ BSTR __RPC_FAR *pVal);
        
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *get_ScoFilename )( 
            IAXCsound __RPC_FAR * This,
            /* [retval][out] */ BSTR __RPC_FAR *pVal);
        
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *get_MidiFilename )( 
            IAXCsound __RPC_FAR * This,
            /* [retval][out] */ BSTR __RPC_FAR *pVal);
        
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *get_OutputSoundfileName )( 
            IAXCsound __RPC_FAR * This,
            /* [retval][out] */ BSTR __RPC_FAR *pVal);
        
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *get_Score )( 
            IAXCsound __RPC_FAR * This,
            /* [retval][out] */ BSTR __RPC_FAR *pVal);
        
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *put_Score )( 
            IAXCsound __RPC_FAR * This,
            /* [in] */ BSTR newVal);
        
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *get_ScoreLine )( 
            IAXCsound __RPC_FAR * This,
            /* [in] */ long Index,
            /* [retval][out] */ BSTR __RPC_FAR *pVal);
        
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *put_ScoreLine )( 
            IAXCsound __RPC_FAR * This,
            /* [in] */ long Index,
            /* [in] */ BSTR newVal);
        
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *AddScoreLine )( 
            IAXCsound __RPC_FAR * This,
            BSTR Note);
        
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *AddNote10 )( 
            IAXCsound __RPC_FAR * This,
            double p1,
            double p2,
            double p3,
            double p4,
            double p5,
            double p6,
            double p7,
            double p8,
            double p9,
            double p10);
        
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *AddNote9 )( 
            IAXCsound __RPC_FAR * This,
            double p1,
            double p2,
            double p3,
            double p4,
            double p5,
            double p6,
            double p7,
            double p8,
            double p9);
        
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *AddNote8 )( 
            IAXCsound __RPC_FAR * This,
            double p1,
            double p2,
            double p3,
            double p4,
            double p5,
            double p6,
            double p7,
            double p8);
        
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *AddNote7 )( 
            IAXCsound __RPC_FAR * This,
            double p1,
            double p2,
            double p3,
            double p4,
            double p5,
            double p6,
            double p7);
        
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *AddNote6 )( 
            IAXCsound __RPC_FAR * This,
            double p1,
            double p2,
            double p3,
            double p4,
            double p5,
            double p6);
        
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *AddNote5 )( 
            IAXCsound __RPC_FAR * This,
            double p1,
            double p2,
            double p3,
            double p4,
            double p5);
        
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *AddNote4 )( 
            IAXCsound __RPC_FAR * This,
            double p1,
            double p2,
            double p3,
            double p4);
        
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *AddNote3 )( 
            IAXCsound __RPC_FAR * This,
            double p1,
            double p2,
            double p3);
        
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *get_ScoreLineCount )( 
            IAXCsound __RPC_FAR * This,
            /* [retval][out] */ long __RPC_FAR *pVal);
        
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *put_ScoreLineCount )( 
            IAXCsound __RPC_FAR * This,
            /* [in] */ long newVal);
        
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *get_Orchestra )( 
            IAXCsound __RPC_FAR * This,
            /* [retval][out] */ BSTR __RPC_FAR *pVal);
        
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *put_Orchestra )( 
            IAXCsound __RPC_FAR * This,
            /* [in] */ BSTR newVal);
        
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *RemoveAll )( 
            IAXCsound __RPC_FAR * This);
        
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *RemoveCommand )( 
            IAXCsound __RPC_FAR * This);
        
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *RemoveOrchestra )( 
            IAXCsound __RPC_FAR * This);
        
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *RemoveScore )( 
            IAXCsound __RPC_FAR * This);
        
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *RemoveScoreExceptFunctions )( 
            IAXCsound __RPC_FAR * This);
        
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *UpdateView )( 
            IAXCsound __RPC_FAR * This);
        
        END_INTERFACE
    } IAXCsoundVtbl;

    interface IAXCsound
    {
        CONST_VTBL struct IAXCsoundVtbl __RPC_FAR *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IAXCsound_QueryInterface(This,riid,ppvObject)	\
    (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)

#define IAXCsound_AddRef(This)	\
    (This)->lpVtbl -> AddRef(This)

#define IAXCsound_Release(This)	\
    (This)->lpVtbl -> Release(This)


#define IAXCsound_GetTypeInfoCount(This,pctinfo)	\
    (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo)

#define IAXCsound_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo)

#define IAXCsound_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)

#define IAXCsound_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)


#define IAXCsound_put_AutoSize(This,vbool)	\
    (This)->lpVtbl -> put_AutoSize(This,vbool)

#define IAXCsound_get_AutoSize(This,pbool)	\
    (This)->lpVtbl -> get_AutoSize(This,pbool)

#define IAXCsound_put_Caption(This,strCaption)	\
    (This)->lpVtbl -> put_Caption(This,strCaption)

#define IAXCsound_get_Caption(This,pstrCaption)	\
    (This)->lpVtbl -> get_Caption(This,pstrCaption)

#define IAXCsound_Play(This)	\
    (This)->lpVtbl -> Play(This)

#define IAXCsound_Pause(This)	\
    (This)->lpVtbl -> Pause(This)

#define IAXCsound_Resume(This)	\
    (This)->lpVtbl -> Resume(This)

#define IAXCsound_Stop(This)	\
    (This)->lpVtbl -> Stop(This)

#define IAXCsound_Open(This,Filename)	\
    (This)->lpVtbl -> Open(This,Filename)

#define IAXCsound_Import(This,Filename)	\
    (This)->lpVtbl -> Import(This,Filename)

#define IAXCsound_Save(This,Filename)	\
    (This)->lpVtbl -> Save(This,Filename)

#define IAXCsound_Export(This,Filename)	\
    (This)->lpVtbl -> Export(This,Filename)

#define IAXCsound_OpenSound(This)	\
    (This)->lpVtbl -> OpenSound(This)

#define IAXCsound_get_Filename(This,pVal)	\
    (This)->lpVtbl -> get_Filename(This,pVal)

#define IAXCsound_put_Filename(This,newVal)	\
    (This)->lpVtbl -> put_Filename(This,newVal)

#define IAXCsound_get_Command(This,pVal)	\
    (This)->lpVtbl -> get_Command(This,pVal)

#define IAXCsound_put_Command(This,newVal)	\
    (This)->lpVtbl -> put_Command(This,newVal)

#define IAXCsound_get_OrcFilename(This,pVal)	\
    (This)->lpVtbl -> get_OrcFilename(This,pVal)

#define IAXCsound_get_ScoFilename(This,pVal)	\
    (This)->lpVtbl -> get_ScoFilename(This,pVal)

#define IAXCsound_get_MidiFilename(This,pVal)	\
    (This)->lpVtbl -> get_MidiFilename(This,pVal)

#define IAXCsound_get_OutputSoundfileName(This,pVal)	\
    (This)->lpVtbl -> get_OutputSoundfileName(This,pVal)

#define IAXCsound_get_Score(This,pVal)	\
    (This)->lpVtbl -> get_Score(This,pVal)

#define IAXCsound_put_Score(This,newVal)	\
    (This)->lpVtbl -> put_Score(This,newVal)

#define IAXCsound_get_ScoreLine(This,Index,pVal)	\
    (This)->lpVtbl -> get_ScoreLine(This,Index,pVal)

#define IAXCsound_put_ScoreLine(This,Index,newVal)	\
    (This)->lpVtbl -> put_ScoreLine(This,Index,newVal)

#define IAXCsound_AddScoreLine(This,Note)	\
    (This)->lpVtbl -> AddScoreLine(This,Note)

#define IAXCsound_AddNote10(This,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10)	\
    (This)->lpVtbl -> AddNote10(This,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10)

#define IAXCsound_AddNote9(This,p1,p2,p3,p4,p5,p6,p7,p8,p9)	\
    (This)->lpVtbl -> AddNote9(This,p1,p2,p3,p4,p5,p6,p7,p8,p9)

#define IAXCsound_AddNote8(This,p1,p2,p3,p4,p5,p6,p7,p8)	\
    (This)->lpVtbl -> AddNote8(This,p1,p2,p3,p4,p5,p6,p7,p8)

#define IAXCsound_AddNote7(This,p1,p2,p3,p4,p5,p6,p7)	\
    (This)->lpVtbl -> AddNote7(This,p1,p2,p3,p4,p5,p6,p7)

#define IAXCsound_AddNote6(This,p1,p2,p3,p4,p5,p6)	\
    (This)->lpVtbl -> AddNote6(This,p1,p2,p3,p4,p5,p6)

#define IAXCsound_AddNote5(This,p1,p2,p3,p4,p5)	\
    (This)->lpVtbl -> AddNote5(This,p1,p2,p3,p4,p5)

#define IAXCsound_AddNote4(This,p1,p2,p3,p4)	\
    (This)->lpVtbl -> AddNote4(This,p1,p2,p3,p4)

#define IAXCsound_AddNote3(This,p1,p2,p3)	\
    (This)->lpVtbl -> AddNote3(This,p1,p2,p3)

#define IAXCsound_get_ScoreLineCount(This,pVal)	\
    (This)->lpVtbl -> get_ScoreLineCount(This,pVal)

#define IAXCsound_put_ScoreLineCount(This,newVal)	\
    (This)->lpVtbl -> put_ScoreLineCount(This,newVal)

#define IAXCsound_get_Orchestra(This,pVal)	\
    (This)->lpVtbl -> get_Orchestra(This,pVal)

#define IAXCsound_put_Orchestra(This,newVal)	\
    (This)->lpVtbl -> put_Orchestra(This,newVal)

#define IAXCsound_RemoveAll(This)	\
    (This)->lpVtbl -> RemoveAll(This)

#define IAXCsound_RemoveCommand(This)	\
    (This)->lpVtbl -> RemoveCommand(This)

#define IAXCsound_RemoveOrchestra(This)	\
    (This)->lpVtbl -> RemoveOrchestra(This)

#define IAXCsound_RemoveScore(This)	\
    (This)->lpVtbl -> RemoveScore(This)

#define IAXCsound_RemoveScoreExceptFunctions(This)	\
    (This)->lpVtbl -> RemoveScoreExceptFunctions(This)

#define IAXCsound_UpdateView(This)	\
    (This)->lpVtbl -> UpdateView(This)

#endif /* COBJMACROS */


#endif 	/* C style interface */



/* [id][propput] */ HRESULT STDMETHODCALLTYPE IAXCsound_put_AutoSize_Proxy( 
    IAXCsound __RPC_FAR * This,
    /* [in] */ VARIANT_BOOL vbool);


void __RPC_STUB IAXCsound_put_AutoSize_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id][propget] */ HRESULT STDMETHODCALLTYPE IAXCsound_get_AutoSize_Proxy( 
    IAXCsound __RPC_FAR * This,
    /* [retval][out] */ VARIANT_BOOL __RPC_FAR *pbool);


void __RPC_STUB IAXCsound_get_AutoSize_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id][propput] */ HRESULT STDMETHODCALLTYPE IAXCsound_put_Caption_Proxy( 
    IAXCsound __RPC_FAR * This,
    /* [in] */ BSTR strCaption);


void __RPC_STUB IAXCsound_put_Caption_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id][propget] */ HRESULT STDMETHODCALLTYPE IAXCsound_get_Caption_Proxy( 
    IAXCsound __RPC_FAR * This,
    /* [retval][out] */ BSTR __RPC_FAR *pstrCaption);


void __RPC_STUB IAXCsound_get_Caption_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IAXCsound_Play_Proxy( 
    IAXCsound __RPC_FAR * This);


void __RPC_STUB IAXCsound_Play_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IAXCsound_Pause_Proxy( 
    IAXCsound __RPC_FAR * This);


void __RPC_STUB IAXCsound_Pause_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IAXCsound_Resume_Proxy( 
    IAXCsound __RPC_FAR * This);


void __RPC_STUB IAXCsound_Resume_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IAXCsound_Stop_Proxy( 
    IAXCsound __RPC_FAR * This);


void __RPC_STUB IAXCsound_Stop_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IAXCsound_Open_Proxy( 
    IAXCsound __RPC_FAR * This,
    BSTR Filename);


void __RPC_STUB IAXCsound_Open_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IAXCsound_Import_Proxy( 
    IAXCsound __RPC_FAR * This,
    BSTR Filename);


void __RPC_STUB IAXCsound_Import_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IAXCsound_Save_Proxy( 
    IAXCsound __RPC_FAR * This,
    BSTR Filename);


void __RPC_STUB IAXCsound_Save_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IAXCsound_Export_Proxy( 
    IAXCsound __RPC_FAR * This,
    BSTR Filename);


void __RPC_STUB IAXCsound_Export_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IAXCsound_OpenSound_Proxy( 
    IAXCsound __RPC_FAR * This);


void __RPC_STUB IAXCsound_OpenSound_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IAXCsound_get_Filename_Proxy( 
    IAXCsound __RPC_FAR * This,
    /* [retval][out] */ BSTR __RPC_FAR *pVal);


void __RPC_STUB IAXCsound_get_Filename_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE IAXCsound_put_Filename_Proxy( 
    IAXCsound __RPC_FAR * This,
    /* [in] */ BSTR newVal);


void __RPC_STUB IAXCsound_put_Filename_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IAXCsound_get_Command_Proxy( 
    IAXCsound __RPC_FAR * This,
    /* [retval][out] */ BSTR __RPC_FAR *pVal);


void __RPC_STUB IAXCsound_get_Command_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE IAXCsound_put_Command_Proxy( 
    IAXCsound __RPC_FAR * This,
    /* [in] */ BSTR newVal);


void __RPC_STUB IAXCsound_put_Command_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IAXCsound_get_OrcFilename_Proxy( 
    IAXCsound __RPC_FAR * This,
    /* [retval][out] */ BSTR __RPC_FAR *pVal);


void __RPC_STUB IAXCsound_get_OrcFilename_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IAXCsound_get_ScoFilename_Proxy( 
    IAXCsound __RPC_FAR * This,
    /* [retval][out] */ BSTR __RPC_FAR *pVal);


void __RPC_STUB IAXCsound_get_ScoFilename_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IAXCsound_get_MidiFilename_Proxy( 
    IAXCsound __RPC_FAR * This,
    /* [retval][out] */ BSTR __RPC_FAR *pVal);


void __RPC_STUB IAXCsound_get_MidiFilename_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IAXCsound_get_OutputSoundfileName_Proxy( 
    IAXCsound __RPC_FAR * This,
    /* [retval][out] */ BSTR __RPC_FAR *pVal);


void __RPC_STUB IAXCsound_get_OutputSoundfileName_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IAXCsound_get_Score_Proxy( 
    IAXCsound __RPC_FAR * This,
    /* [retval][out] */ BSTR __RPC_FAR *pVal);


void __RPC_STUB IAXCsound_get_Score_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE IAXCsound_put_Score_Proxy( 
    IAXCsound __RPC_FAR * This,
    /* [in] */ BSTR newVal);


void __RPC_STUB IAXCsound_put_Score_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IAXCsound_get_ScoreLine_Proxy( 
    IAXCsound __RPC_FAR * This,
    /* [in] */ long Index,
    /* [retval][out] */ BSTR __RPC_FAR *pVal);


void __RPC_STUB IAXCsound_get_ScoreLine_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE IAXCsound_put_ScoreLine_Proxy( 
    IAXCsound __RPC_FAR * This,
    /* [in] */ long Index,
    /* [in] */ BSTR newVal);


void __RPC_STUB IAXCsound_put_ScoreLine_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IAXCsound_AddScoreLine_Proxy( 
    IAXCsound __RPC_FAR * This,
    BSTR Note);


void __RPC_STUB IAXCsound_AddScoreLine_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IAXCsound_AddNote10_Proxy( 
    IAXCsound __RPC_FAR * This,
    double p1,
    double p2,
    double p3,
    double p4,
    double p5,
    double p6,
    double p7,
    double p8,
    double p9,
    double p10);


void __RPC_STUB IAXCsound_AddNote10_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IAXCsound_AddNote9_Proxy( 
    IAXCsound __RPC_FAR * This,
    double p1,
    double p2,
    double p3,
    double p4,
    double p5,
    double p6,
    double p7,
    double p8,
    double p9);


void __RPC_STUB IAXCsound_AddNote9_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IAXCsound_AddNote8_Proxy( 
    IAXCsound __RPC_FAR * This,
    double p1,
    double p2,
    double p3,
    double p4,
    double p5,
    double p6,
    double p7,
    double p8);


void __RPC_STUB IAXCsound_AddNote8_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IAXCsound_AddNote7_Proxy( 
    IAXCsound __RPC_FAR * This,
    double p1,
    double p2,
    double p3,
    double p4,
    double p5,
    double p6,
    double p7);


void __RPC_STUB IAXCsound_AddNote7_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IAXCsound_AddNote6_Proxy( 
    IAXCsound __RPC_FAR * This,
    double p1,
    double p2,
    double p3,
    double p4,
    double p5,
    double p6);


void __RPC_STUB IAXCsound_AddNote6_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IAXCsound_AddNote5_Proxy( 
    IAXCsound __RPC_FAR * This,
    double p1,
    double p2,
    double p3,
    double p4,
    double p5);


void __RPC_STUB IAXCsound_AddNote5_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IAXCsound_AddNote4_Proxy( 
    IAXCsound __RPC_FAR * This,
    double p1,
    double p2,
    double p3,
    double p4);


void __RPC_STUB IAXCsound_AddNote4_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IAXCsound_AddNote3_Proxy( 
    IAXCsound __RPC_FAR * This,
    double p1,
    double p2,
    double p3);


void __RPC_STUB IAXCsound_AddNote3_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IAXCsound_get_ScoreLineCount_Proxy( 
    IAXCsound __RPC_FAR * This,
    /* [retval][out] */ long __RPC_FAR *pVal);


void __RPC_STUB IAXCsound_get_ScoreLineCount_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE IAXCsound_put_ScoreLineCount_Proxy( 
    IAXCsound __RPC_FAR * This,
    /* [in] */ long newVal);


void __RPC_STUB IAXCsound_put_ScoreLineCount_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IAXCsound_get_Orchestra_Proxy( 
    IAXCsound __RPC_FAR * This,
    /* [retval][out] */ BSTR __RPC_FAR *pVal);


void __RPC_STUB IAXCsound_get_Orchestra_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE IAXCsound_put_Orchestra_Proxy( 
    IAXCsound __RPC_FAR * This,
    /* [in] */ BSTR newVal);


void __RPC_STUB IAXCsound_put_Orchestra_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IAXCsound_RemoveAll_Proxy( 
    IAXCsound __RPC_FAR * This);


void __RPC_STUB IAXCsound_RemoveAll_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IAXCsound_RemoveCommand_Proxy( 
    IAXCsound __RPC_FAR * This);


void __RPC_STUB IAXCsound_RemoveCommand_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IAXCsound_RemoveOrchestra_Proxy( 
    IAXCsound __RPC_FAR * This);


void __RPC_STUB IAXCsound_RemoveOrchestra_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IAXCsound_RemoveScore_Proxy( 
    IAXCsound __RPC_FAR * This);


void __RPC_STUB IAXCsound_RemoveScore_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IAXCsound_RemoveScoreExceptFunctions_Proxy( 
    IAXCsound __RPC_FAR * This);


void __RPC_STUB IAXCsound_RemoveScoreExceptFunctions_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IAXCsound_UpdateView_Proxy( 
    IAXCsound __RPC_FAR * This);


void __RPC_STUB IAXCsound_UpdateView_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);



#endif 	/* __IAXCsound_INTERFACE_DEFINED__ */



#ifndef __AXCSOUNDLib_LIBRARY_DEFINED__
#define __AXCSOUNDLib_LIBRARY_DEFINED__

/* library AXCSOUNDLib */
/* [helpstring][version][uuid] */ 


EXTERN_C const IID LIBID_AXCSOUNDLib;

#ifndef ___IAXCsoundEvents_DISPINTERFACE_DEFINED__
#define ___IAXCsoundEvents_DISPINTERFACE_DEFINED__

/* dispinterface _IAXCsoundEvents */
/* [helpstring][uuid] */ 


EXTERN_C const IID DIID__IAXCsoundEvents;

#if defined(__cplusplus) && !defined(CINTERFACE)

    MIDL_INTERFACE("3DE31672-D1A4-11D2-ACCC-005004052BF7")
    _IAXCsoundEvents : public IDispatch
    {
    };
    
#else 	/* C style interface */

    typedef struct _IAXCsoundEventsVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *QueryInterface )( 
            _IAXCsoundEvents __RPC_FAR * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ void __RPC_FAR *__RPC_FAR *ppvObject);
        
        ULONG ( STDMETHODCALLTYPE __RPC_FAR *AddRef )( 
            _IAXCsoundEvents __RPC_FAR * This);
        
        ULONG ( STDMETHODCALLTYPE __RPC_FAR *Release )( 
            _IAXCsoundEvents __RPC_FAR * This);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetTypeInfoCount )( 
            _IAXCsoundEvents __RPC_FAR * This,
            /* [out] */ UINT __RPC_FAR *pctinfo);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetTypeInfo )( 
            _IAXCsoundEvents __RPC_FAR * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo __RPC_FAR *__RPC_FAR *ppTInfo);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetIDsOfNames )( 
            _IAXCsoundEvents __RPC_FAR * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR __RPC_FAR *rgszNames,
            /* [in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID __RPC_FAR *rgDispId);
        
        /* [local] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *Invoke )( 
            _IAXCsoundEvents __RPC_FAR * This,
            /* [in] */ DISPID dispIdMember,
            /* [in] */ REFIID riid,
            /* [in] */ LCID lcid,
            /* [in] */ WORD wFlags,
            /* [out][in] */ DISPPARAMS __RPC_FAR *pDispParams,
            /* [out] */ VARIANT __RPC_FAR *pVarResult,
            /* [out] */ EXCEPINFO __RPC_FAR *pExcepInfo,
            /* [out] */ UINT __RPC_FAR *puArgErr);
        
        END_INTERFACE
    } _IAXCsoundEventsVtbl;

    interface _IAXCsoundEvents
    {
        CONST_VTBL struct _IAXCsoundEventsVtbl __RPC_FAR *lpVtbl;
    };

    

#ifdef COBJMACROS


#define _IAXCsoundEvents_QueryInterface(This,riid,ppvObject)	\
    (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)

#define _IAXCsoundEvents_AddRef(This)	\
    (This)->lpVtbl -> AddRef(This)

#define _IAXCsoundEvents_Release(This)	\
    (This)->lpVtbl -> Release(This)


#define _IAXCsoundEvents_GetTypeInfoCount(This,pctinfo)	\
    (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo)

#define _IAXCsoundEvents_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo)

#define _IAXCsoundEvents_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)

#define _IAXCsoundEvents_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)

#endif /* COBJMACROS */


#endif 	/* C style interface */


#endif 	/* ___IAXCsoundEvents_DISPINTERFACE_DEFINED__ */


EXTERN_C const CLSID CLSID_AXCsound;

#ifdef __cplusplus

class DECLSPEC_UUID("018CD11D-20DE-11D2-917D-00A0CC30C276")
AXCsound;
#endif
#endif /* __AXCSOUNDLib_LIBRARY_DEFINED__ */

/* Additional Prototypes for ALL interfaces */

unsigned long             __RPC_USER  BSTR_UserSize(     unsigned long __RPC_FAR *, unsigned long            , BSTR __RPC_FAR * ); 
unsigned char __RPC_FAR * __RPC_USER  BSTR_UserMarshal(  unsigned long __RPC_FAR *, unsigned char __RPC_FAR *, BSTR __RPC_FAR * ); 
unsigned char __RPC_FAR * __RPC_USER  BSTR_UserUnmarshal(unsigned long __RPC_FAR *, unsigned char __RPC_FAR *, BSTR __RPC_FAR * ); 
void                      __RPC_USER  BSTR_UserFree(     unsigned long __RPC_FAR *, BSTR __RPC_FAR * ); 

/* end of Additional Prototypes */

#ifdef __cplusplus
}
#endif

#endif
