/*  this program reads a csound score and writes a midi file.
    The Csound instr. # become midi chan #, the start time and duration
    should be in seconds, p4 should = midi amp i.e.between 0 and 127 and p5
    should be the midi note number 0 to 127. */

#include <stdio.h>
#include <malloc.h>

FILE	*fp;

WriteVarLen(value)
	long value;
{
	long	buffer;
	buffer	= value & 0x7f;
	while((value>>=7) > 0)
	{
		buffer	<<= 8;
		buffer	|= 0x80;
		buffer	+= (value & 0x7f);
	}
	while(1)
	{
		putc((int) (buffer & 0xFF),fp);
		if(buffer & 0x80)
		 	buffer	>>= 8;
		else
			break;
	}
}
int CountWriteVarLen(value)
	long value;
{
	long	buffer;
	int		count;
	count = 0;
	buffer	= value & 0x7f;
	while((value>>=7) > 0)
	{
		buffer	<<= 8;
		buffer	|= 0x80;
		buffer	+= (value & 0x7f);
	}
	while(1)
	{
		count++;
		if(buffer & 0x80)
		 	buffer	>>= 8;
		else
			break;
	}
	return count;
}



float	*setimes;
unsigned short   *voice,*notenum,*amp;
float	tempf;
unsigned short	tempb;
int	i;
/* recursive sort algorithm. see p.87 "The C Programming Language" */
/*  by Kerningham and Ritchie */
QuickSort(left,right)
	int left,right;
{
	int	last;
	if(left>=right)
		return;
	tempf = setimes[left] ;
	setimes[left] = setimes[(left+right)/2] ;
	setimes[(left+right)/2] = tempf ;

	tempb = voice[left] ;
	voice[left] = voice[(left+right)/2] ;
	voice[(left+right)/2] = tempb ;

	tempb = notenum[left] ;
	notenum[left] = notenum[(left+right)/2] ;
	notenum[(left+right)/2] = tempb ;

	tempb = amp[left] ;
	amp[left] = amp[(left+right)/2] ;
	amp[(left+right)/2] = tempb ;
	
	last = left;
	for(i=left+1; i<=right ; i++)
		if(setimes[i] < setimes[left])
			if(i != (++last))
			{
				tempf = setimes[i] ;
				setimes[i] = setimes[last] ;
				setimes[last] = tempf ;

				tempb = voice[i] ;
				voice[i] = voice[last] ;
				voice[last] = tempb ;

				tempb = notenum[i] ;
				notenum[i] = notenum[last] ;
				notenum[last] = tempb ;

				tempb = amp[i] ;
				amp[i] = amp[last] ;
				amp[last] = tempb ;
			}
	
	tempf = setimes[left] ;
	setimes[left] = setimes[last] ;
	setimes[last] = tempf ;

	tempb = voice[left] ;
	voice[left] = voice[last] ;
	voice[last] = tempb ;

	tempb = notenum[left] ;
	notenum[left] = notenum[last] ;
	notenum[last] = tempb ;

	tempb = amp[left] ;
	amp[left] = amp[last] ;
	amp[last] = tempb ;
	QuickSort(left,last-1);
	QuickSort(last+1,right);
}

main(argc,argv)
    int argc;
    char    *argv[];
{
	char	ch;
	float	p1,p2,p3,p4,p5;
    unsigned short	tempb;
	int		noteCount=0,i,j;
	long	byteCount;
    long    totalticks,templ;
	long	tempo = 1000000;	/* tempo in micro seconds per quarter note */
    long    arraysize;

    arraysize = 3500;
    if(argc==4)
        sscanf(argv[3],"%d",&arraysize);
    if(argc!=3 && argc!=4)
    {
        printf("Usage: %s csound.sco midifile.fil [maxeventcount]\n",argv[0]);
        exit(-1);
    }
    printf("This program will read the C Sound format file named %s, and\n",argv[1]);
    printf("then write it in Midi file format to the file %s.\n\n\n",argv[2]);
    
/* allocate storage arrays */
    setimes = (float *) calloc(arraysize,sizeof(float));
    voice = (unsigned short *) calloc(arraysize,sizeof(unsigned short));
    notenum = (unsigned short *) calloc(arraysize,sizeof(unsigned short));
    amp = (unsigned short *) calloc(arraysize,sizeof(unsigned short));
	if(setimes==NULL||voice==NULL||notenum==NULL||amp==NULL)
	{
		printf("Enough storage could not be allocated to run this program.\n");
		exit(-1);
	}

    fp = fopen(argv[1],"r");
	if(fp == NULL)
	{
        printf(" Error : The file %s could not be opened !\n",argv[1]);
		exit(-1);
	}


/* read in the Cscore */
    printf(" Reading in the C Sound score. i cards only.\n");
	while(fscanf(fp,"%c",&ch)!=EOF)
	{
		if(ch==';')
			while(fscanf(fp,"%c",&ch)!=EOF && ch!='\n')
				{}
		else if(ch=='i'||ch=='I')
		{
			fscanf(fp,"%f %f %f %f %f",&p1,&p2,&p3,&p4,&p5);
			 setimes[noteCount] = p2;
			 voice[noteCount] = p1;
			 notenum[noteCount] = p5;
			 amp[noteCount] = p4;
			noteCount++ ;
			 setimes[noteCount] = p3+p2;
			 voice[noteCount] = 100+p1;
			 notenum[noteCount] = p5;
			 amp[noteCount] = 0;
			noteCount++ ;
            if(noteCount>arraysize-2)
 			{
			  printf(" Error : too many notes so, not all of the notes could be processed !\n");
			  break;
			}
		}
	}
	fclose(fp);
    printf(" A total of %d events were read.\n",noteCount);

/* sort the score by setimes */
	printf("\n Sorting the Csound score.\n");
/* recursive sort */
	QuickSort(0,noteCount-1);
/* bubble sort */
/*    for(i=0;i<noteCount;i++)
    {
	printf("\n Sorting the Csound score.\n");
      for(j=1;j<noteCount;j++)
	    if(setimes[j-1]>setimes[j])
	    {
		tempf = setimes[j-1] ;
		setimes[j-1] = setimes[j] ;
		setimes[j] = tempf ;

		tempb = voice[j-1] ;
		voice[j-1] = voice[j] ;
		voice[j] = tempb ;

		tempb = notenum[j-1] ;
		notenum[j-1] = notenum[j] ;
		notenum[j] = tempb ;

		tempb = amp[j-1] ;
		amp[j-1] = amp[j] ;
		amp[j] = tempb ;
	    }
	}
*/
/* print the score */
    fp = fopen(argv[2],"wb");
	if(fp == NULL)
	{
        printf("\n Error : The file %s could not be opened !\n",argv[2]);
		exit(-1);
	}
	
	printf("\n writing the Midi file.\n");
	putc('M',fp);	/* put 'MThd' header */
	putc('T',fp);
	putc('h',fp);
	putc('d',fp);
	putc(0,fp);		/* put length */
	putc(0,fp);
	putc(0,fp);
	putc(6,fp);
	putc(0,fp);		/* format 0 */
	putc(0,fp);
	putc(0,fp);		/* one track */
	putc(1,fp);
	putc(1,fp);		/* 480 ticks per quarter */
	putc(0xE0,fp);
	putc('M',fp);	/* put 'MTrk' header */
	putc('T',fp);
	putc('r',fp);
	putc('k',fp);
	
    printf(" calculating track length = ");
    /* calc track length */
	byteCount = 0;
	totalticks = 0;
	for(i=0;i<noteCount;i++)
	{
		templ = (double) setimes[i] * 480. ;
		byteCount += CountWriteVarLen(templ-totalticks);
		totalticks = templ;
		byteCount+=3;
	}
	byteCount+=4;	/* for end of track mark */
    printf("%ld bytes\n",byteCount);
	
	putc((int)(byteCount>>24),fp);		/* put length of track */
	putc((int)(byteCount>>16),fp);
	putc((int)(byteCount>>8),fp);
	putc((int)(byteCount),fp);

	/* calc and put track */
    printf(" writing track data.\n");
	totalticks = 0;
	for(i=0;i<noteCount;i++)
	{
		templ = (double) setimes[i] * 480. ;
		WriteVarLen(templ-totalticks);
		if(voice[i]<101) putc((int)0x90+((voice[i]-1) & 0x0F),fp); /*note no/off */
		else			 putc((int)0x80+((voice[i]-101) & 0x0F),fp);
		putc((int)notenum[i],fp);								/* note number */
		putc((int)amp[i],fp);									/* velocity */

		totalticks = templ;
	}

	putc(0,fp);		/* put end of track */
	putc(0xFF,fp);
	putc(0x2F,fp);
	putc(0,fp);

	fclose(fp);
	free(setimes);
	free(voice);
	free(notenum);
	free(amp);

	printf(" done.\n");

}
