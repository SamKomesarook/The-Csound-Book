
CsoundAxps.dll: dlldata.obj CsoundAx_p.obj CsoundAx_i.obj
	link /dll /out:CsoundAxps.dll /def:CsoundAxps.def /entry:DllMain dlldata.obj CsoundAx_p.obj CsoundAx_i.obj \
		kernel32.lib rpcndr.lib rpcns4.lib rpcrt4.lib oleaut32.lib uuid.lib \

.c.obj:
	cl /c /Ox /DWIN32 /D_WIN32_WINNT=0x0400 /DREGISTER_PROXY_DLL \
		$<

clean:
	@del CsoundAxps.dll
	@del CsoundAxps.lib
	@del CsoundAxps.exp
	@del dlldata.obj
	@del CsoundAx_p.obj
	@del CsoundAx_i.obj
