package GoginsChapters.ScoreManager;
import java.io.*;
/**
Pulls stderr and stdout out of a process without an independent console.
Useful for running "DOS" processes on Windows.
@author Copyright (C) 1999 by Michael Gogins. All rights reserved.
<ADDRESS>
gogins@nyc.pipeline.com
</ADDRESS>
*/
public class ProcessConsole
{
	public class OutputThread extends Thread
	{
		BufferedReader reader = null;
		OutputThread(BufferedReader reader)
		{
			this.reader = reader;
		}
		public void run()
		{
			try
			{
				String line = null;
				for(;;)
				{
					line = reader.readLine();
					if(line != null)
					{
						System.out.println(line);
					}
					yield();
				}
			}
			catch(IOException e)
			{
				e.printStackTrace();
			}
		}
	}
	OutputThread stdoutThread = null;
	OutputThread stderrThread = null;
	BufferedReader bufferedReaderStdout = null;
	BufferedReader bufferedReaderStderr = null;
	public Process process = null;
	String commandLine = null;
	public void execWait(String commandLine)
	{
		try
		{
			exec(commandLine);
			process.waitFor();
			destroy();
		}
		catch(InterruptedException e)
		{
			e.printStackTrace();
		}
	}
	public void exec(String commandLine)
	{
		try
		{
			destroy();
			System.out.println("Began exec(" + commandLine + ").");
			this.commandLine = commandLine;
			process = Runtime.getRuntime().exec(this.commandLine);
			bufferedReaderStderr = new BufferedReader(new InputStreamReader(process.getErrorStream()));
			stderrThread = new OutputThread(bufferedReaderStderr);
			bufferedReaderStdout = new BufferedReader(new InputStreamReader(process.getInputStream()));
			stdoutThread = new OutputThread(bufferedReaderStdout);
			stderrThread.start();
			stdoutThread.start();
		}
		catch(IOException e)
		{
			e.printStackTrace();
		}
	}
	public void destroy()
	{
		if(stderrThread != null)
		{
			stderrThread.stop();
			stderrThread = null;
		}
		if(stdoutThread != null)
		{
			stdoutThread.stop();
			stdoutThread = null;
		}
		if(process != null)
		{
			process.destroy();
		}
		if(commandLine != null)
		{
			System.out.println("Ended exec(" + commandLine + ").");
		}
	}
}

