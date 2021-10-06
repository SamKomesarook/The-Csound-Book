#include <stdio.h>
#include <stdlib.h>
FILE    *fp,*fp2;

/*
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
	while(1);
	{
		putchar(buffer);
		if(buffer & 0x80)
		 	buffer	>>= 8;
		else
			break;
	}
}
*/

long	ReadVarLen()
{
	long	value;
	char	c;

	if((value = getc(fp)) & 0x80)
	{
		value	&= 0x7f;
		do
		{
			value = (value << 7) + ((c = getc(fp)) & 0x7f);
		} while (c & 0x80);
	}
	return(value);
}

struct event {
	float time;
	unsigned char type;
	unsigned char data[2];
} *EventArray,*eventPtr,*evPtr2,*evPtr3;

main(argc,argv)
    int argc;
    char    *argv[];
{
	double	totaltime,dt;
	long	totalticks,dticks,len;
	long	tempo = 1000000;	/* tempo in micro seconds per quarter note */
	unsigned int		nextByte,type;
	unsigned int		ch1,ch2,ch3,ch4;
	unsigned int		format,tracks,ticksperquarter;
    long    i,arraysize,trackcount;

    arraysize = 3500;
    if(argc==4)
        sscanf(argv[3],"%d",&arraysize);
    if(argc!=3 && argc!=4)
    {
        printf("Usage: %s midifile.fil csound.sco [maxeventcount]\n",argv[0]);
        exit(-1);
    }
    printf("This program will read the Midi format file named %s, and\n",argv[1]);
    printf("then write it in C sound format to the file %s.\n\n\n",argv[2]);
	
/* allocate storage array */

    EventArray = (struct event *) calloc(arraysize,sizeof(struct event));
	if(EventArray == NULL)
	{
		printf("Enough storage could not be allocated to run this program.\n");
		exit(-1);
	}
	
    fp = fopen(argv[1],"rb");
	if(fp == NULL)
	{
        printf(" Error : The file %s could not be opened !\n",argv[1]);
		exit(-1);
	}

    printf(" Reading in the Midi file.\n");

	ch1 =getc(fp);	/* get 'MThd' header */
	ch2 =getc(fp);
	ch3 =getc(fp);
	ch4 =getc(fp);
	if(ch1!='M'||ch2!='T'||ch3!='h'||ch4!='d')
	{
		printf("This is not a standard midi file.\n");
		exit(-1);
	}
    for(i=0;i<4;i++) getc(fp);  /* skip length */

	ch1 =getc(fp);
	ch2 =getc(fp);
	format = (ch1 << 8) + ch2;
	ch1 =getc(fp);
	ch2 =getc(fp);
	tracks = (ch1 << 8) + ch2;
	ch1 =getc(fp);
	ch2 =getc(fp);
	ticksperquarter = (ch1 << 8) + ch2;
    printf("The input file has Midi file format %d.\n",format);
    if(format!=0&&format!=1)
	{
        printf("This program only works on format 0 and 1 Midi files.\n");
		exit(-1);
	}

    fp2 = fopen(argv[2],"w");
    if(fp2 == NULL)
	{
        printf(" Error : The file %s could not be opened !\n",argv[2]);
		exit(-1);
	}
	
    printf("\n writing the C Sound file.\n");

    fprintf(fp2,"; The Midi file (in C Sound format) begins here.\n");
    fprintf(fp2,"; p1 = midi channel + 1\n");
    fprintf(fp2,"; p2 = start time in seconds\n");
    fprintf(fp2,"; p3 = duration in seconds\n");
    fprintf(fp2,"; p4 = amplitue (midi velocity)\n");
    fprintf(fp2,"; p5 = pitch (midi note number)\n;\n");

  for(trackcount=0;trackcount<tracks;trackcount++)
  {
    printf("; Track # %ld\n",trackcount);
    fprintf(fp2,"; Track # %ld\n",trackcount);
    ch1 =getc(fp);  /* get 'MTrk' chunk */
	ch2 =getc(fp);
	ch3 =getc(fp);
	ch4 =getc(fp);
	if(ch1!='M'||ch2!='T'||ch3!='r'||ch4!='k')
	{
		printf("This file did not have the proper MTrk code.\n");
		exit(-1);
	}
	for(i=0;i<4;i++) getc(fp);	/* skip length */
	
	totalticks = 0;
	totaltime = 0;
	eventPtr = EventArray;
	type = 0;
	while(type!=0x2F)
	{
      if(eventPtr == &EventArray[arraysize-1])
	  {
		printf("; The file was to large to be completely processed.\n");
		break;
	  }
	  /* first get the time */

	  dticks = ReadVarLen() ;
	  totalticks += dticks ;
	  dt = (double) dticks / (double)ticksperquarter * (double)tempo / 1000000.;
	  totaltime += dt ;
	  eventPtr->time = totaltime;

	  /* now get the type */

	  if ((nextByte = getc(fp)) & 0x80)		/* skip running status */
	  {
	    if (nextByte == 0xFF)  /* meta event  */
	      type = getc(fp);
	    else
	    {
	      type = nextByte;
	      if (type != 0xF0 && type != 0xF7)
	        nextByte = getc(fp);
	    }
	  }

	  /* now process the events */
printf(" type is %x dticks is %f\n",(int) type,(float) dticks);
      if (type < 0x80 || type == 0xF0 || type == 0xF7) /* meta or system exclu. */
	  {
        len = ReadVarLen();
        switch (type)
	    {
	    case 0x58:	/* Time signature */
	      getc(fp);	/* get numerator */
	      getc(fp);	/* get denumerator */
	      getc(fp);	/* get cc */
	      getc(fp);	/* get bb */
	      break;
	    case 0x51:	/* tempo change */
          ch1 = getc(fp);
          ch2 = getc(fp);
	      ch3 = getc(fp);
		  tempo = ((long) ch1 << 16) + ((long) ch2 << 8) + ch3;
                      printf(" tempo change %ld \n",tempo);
	      break;
	    case 0x2F:	/* track end */
          eventPtr->type = type;
          eventPtr++;
          break;
	    default:   /* skip unknown event */
	      for (i=0; i<len; i++)
            getc(fp);
	    }
	  } else	/* its a standard midi event */
	  {
                          printf(" %f",eventPtr->time);
                          printf(" %ld",totalticks);
	    eventPtr->type = type;
                          printf(" %x",(int) eventPtr->type);
	    eventPtr->data[0] = nextByte;
                          printf(" %x",(int) eventPtr->data[0]);
	    if ((type & 0xE0) != 0xC0)
	    {
	      eventPtr->data[1] = getc(fp);
                          printf(" %x",(int) eventPtr->data[1]);
	    }
        eventPtr++;
                          printf("\n");
	  }
	} 	/* end of the file input loop */

	
    if(eventPtr == &EventArray[arraysize-1])
		printf("; The file was to large to be completely processed.\n");

    
/* output the file here  */

    for(evPtr2=EventArray;evPtr2<eventPtr;evPtr2++)
	{
        if( (evPtr2->type|0x0F) == 0x9F && evPtr2->data[1]!=0 )   /* note on */
		{
			for(evPtr3=evPtr2;evPtr3<eventPtr;evPtr3++)
                if(     ( (evPtr3->type | 0x0F) == 0x8F &&  /* note off */
                          (evPtr3->type & 0x0F) == (evPtr2->type & 0x0F) && /* same channel */
                          evPtr3->data[0] == evPtr2->data[0] ) /* same pitch */
                         ||
                        ( evPtr3->type == evPtr2->type &&  /* note on */
                          evPtr3->data[0] == evPtr2->data[0] && /* same pitch */
                          evPtr3->data[1] == 0               )   ) /* vel 0 */
				{
                    fprintf(fp2,"i%d\t%f\t%f\t%d\t%d\n",
                        (format==0 ?(int) (evPtr2->type & 0x0F)+1:(int)trackcount),
						evPtr2->time,
						evPtr3->time-evPtr2->time,
                        (int) evPtr2->data[1],
                        (int) evPtr2->data[0]
						);
					break;
				}
			if(evPtr3==eventPtr)
			{
                printf("; Error : notes without end. (see score)\n");
                fprintf(fp2,"; Error : the next note started but did not end.\n");
                fprintf(fp2,"i%d\t%f\t%f\t%d\t%d\n",
                    (format==0 ?(int) (evPtr2->type & 0x0F)+1:(int)trackcount),
					evPtr2->time,
					(float) 0.0,
                    (int) evPtr2->data[1],
                    (int) evPtr2->data[0]
					);
			}
		}
	}
  }
    fprintf(fp2,"e\n");
    fclose(fp2);
	fclose(fp);
	free(EventArray);
	printf(" done.\n");
}
