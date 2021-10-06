package JCsound;
/**
 *  Provides a low-level Java interface to a native implementation of "public-domain" Csound.
 *  @version Silence 1.0. An extensible system for making music on computers by means of software alone.
 *  @author Copyright (C) 1998 by Michael Gogins. All rights reserved.
 *  <ADDRESS>
 *  gogins@nyc.pipeline.com
 *  </ADDRESS>
 *  This software is licensed under the terms of the GNU General Public License.
 *  It is distributed without charge.
 *  @comment
 *  Run javah -jni JCsound.Csound on the compiled class file to generate
 *  JCsound_Csound.h for building the JCsound_Csound.dll or .so shared library.
 */
public class Csound implements Runnable 
{   
    /**
     *  The name of the Csound shared library.
     */
    static final String libName = "JCsound_Csound";

    /**
     *  A Java thead is used to make the native code platform-neutral.
     */
    static Thread thread = null;
    
    /**
     *  The default constructor tries to load the Csound shared library.
     */
    public Csound() throws UnsatisfiedLinkError, SecurityException
    {
        System.loadLibrary(libName);
    		//{{INIT_CONTROLS
		//}}
    }
    
    /**
     *  Sets the Csound command line.
     */
    public final native void setCommand(String command);
    
    /**
     *  If one does not already exist,
     *  creates a new thread to run Csound.
     */
    public final void start()
    {
        stopRunning();
        if(thread == null)
        {
            thread = new Thread(this);
            thread.start();
            int currentPriority = thread.getPriority();
            int maxPriority = thread.getThreadGroup().getMaxPriority();
            int newPriority = ((maxPriority - currentPriority) / 2) + currentPriority;
            thread.setPriority(newPriority);
        }
    }
    
    /**
     *  Runs Csound with the current command line.
     *  The standard Csound messages are printed to the Java console.
     *  The rendering thread can be suspended, resumed, and stopped,
     *  and a new rendering thread can then be started 
     *  without reloading the Csound shared library.
     *  Note that although Csound runs in a separate thread,
     *  it is not possible for a process to run 
     *  more than one Csound thread at the same time.
     */
    public final native void run();
    
    /**
     *  Suspends the thread, if any, running Csound.
     */
    public final void suspend()
    {
        if(thread != null)
        {
            thread.suspend();
        }
    }
    
    /** 
     *  Resumes the thread, if any, running Csound.
     */     
    public final void resume()
    {
        if(thread != null)
        {
            thread.resume();
        }
    }
    
    /** 
     *  Stops the thread running Csound
     *  and removes the thread object.
     */
    public final void stopRunning()
    {
        stop();
        thread = null;
    }
    
    /**
     *  Causes any thread running Csound 
     *  to return after rendering its current event.
     */
    protected native void stop();
	//{{DECLARE_CONTROLS
	//}}
}
