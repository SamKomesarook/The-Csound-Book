/***********************************/
/** midi UGs by Gabriel Maldonado **/
/***********************************/

#include "cs.h"                                       
#include "midiops2.h"
#ifndef TRUE
#define TRUE (1)
#define FALSE (0)
#endif

extern INSDS    *curip;    
#define f7bit	((float)127.0)
#define f14bit	((float)16383.0)
#define f21bit	((float)2097151.0)

#define oneTOf7bit ((float)1./127.)
#define oneTOf14bit  ((float)1/16383.)
#define oneTOf21bit	 ((float)1/2097151.)
#ifdef WIN32
void dieu_gab(char *s, char *title); /* gab */
#endif
/*------------------------------------------------------------------------*/
/* 7 bit midi control UGs */

void imidic7(MIDICTL2 *p)
{
    float value;
    FUNC  *ftp;
    long  ctlno;
    
    if ((ctlno = (long)*p->ictlno) < 0 || ctlno > 127)
      initerror("illegal controller number");
    else {
      value = (float)(curip->m_chnbp->ctl_val[ctlno] * oneTOf7bit);
      if (*p->ifn > 0) {
	if ((ftp = ftfind(p->ifn)) == NULL)
	  return; /* if valid ftable, use value as index   */
	value = *(ftp->ftable + (long)(value*ftp->flen)); /* no interpolation */
      }
      *p->r = value * (*p->imax - *p->imin) + *p->imin;	/* scales the output*/
    }
}


void midic7set(MIDICTL2 *p)
{
    long  ctlno;
    if ((ctlno = (long)*p->ictlno) < 0 || ctlno > 127)
      initerror("illegal controller number");
    else p->ctlno = ctlno;
    if (*p->ifn > 0) {	
      if (((p->ftp = ftfind(p->ifn)) == NULL))
	p->flag = FALSE;  /* invalid ftable */
      else p->flag= TRUE; 
    }
    else p->flag= FALSE;    
}

void midic7(MIDICTL2 *p)
{
    float value;
    INSDS *curip = p->h.insdshead;
    
     value = (float) (curip->m_chnbp->ctl_val[p->ctlno] * oneTOf7bit);
    if (p->flag)  {             /* if valid ftable,use value as index   */    
      value = *(p->ftp->ftable + (long)(value*p->ftp->flen)); /* no interpolation */
    }
    *p->r = value * (*p->imax - *p->imin) + *p->imin;   /* scales the output */
}

/*------------------------------------------------------------------------*/
/* 14 bit midi control UGs */

void imidic14(MIDICTL3 *p)
{
    float value;
    FUNC  *ftp;
    long  ctlno1;
    long  ctlno2;
    
    if ((ctlno1 = (long)*p->ictlno1) < 0 || ctlno1 > 127 || 
        (ctlno2 = (long)*p->ictlno2) < 0 || ctlno2 > 127 )
      initerror("illegal controller number");
    else {
        value =	(float) (
	  (curip->m_chnbp->ctl_val[ctlno1] * 128 +
	   curip->m_chnbp->ctl_val[ctlno2])     
       * oneTOf14bit);
       if (*p->ifn > 0) {
            /* linear interpolation routine */
            float phase;
            float *base_address;
            float *base;
            float *top;
            float diff;
            long length;

            if ((ftp = ftfind(p->ifn)) == NULL)
	      return; /* if valid ftable,use value as index   */
            phase = value * (length = ftp->flen);
            diff = phase - (long) phase;
            base = (base_address = ftp->ftable) + (long)(phase);
            top  = base + 1 ;
            top = (top - base_address > length) ?  base_address : top;
            value = *base + (*top - *base) * diff;
        }
        *p->r = value * (*p->imax - *p->imin) + *p->imin;  /* scales the output*/
    }
}


void midic14set(MIDICTL3 *p)
{
    long   ctlno1;
    long   ctlno2;
    if ((ctlno1 = (long)*p->ictlno1) < 0 || ctlno1 > 127 ||
        (ctlno2 = (long)*p->ictlno2) < 0 || ctlno2 > 127 )
      initerror("illegal controller number");
    else { 
        p->ctlno1 = ctlno1; 
        p->ctlno2 = ctlno2;
    }
    if (*p->ifn > 0) {
        if (((p->ftp = ftfind(p->ifn)) == NULL))
	  p->flag = FALSE;  /* invalid ftable */
        else p->flag= TRUE; 
    }
    else
      p->flag= FALSE;    
}

void midic14(MIDICTL3 *p)
{
    float value;
    INSDS *curip = p->h.insdshead;
    
    value =	(float) (
      (curip->m_chnbp->ctl_val[p->ctlno1] *128  +
       curip->m_chnbp->ctl_val[p->ctlno2] )
       * oneTOf14bit);
    if (p->flag)  { 	/* if valid ftable,use value as index   */	    
       float phase = value * p->ftp->flen; /* gab-A1 */
       float *base = p->ftp->ftable + (long)(phase);
       value = *base + (*(base+1) - *base) * (phase - (long) phase);
       
		/* linear interpolation routine */    
       	/*
		float phase;
       float *base_address;
       float *base;
       float *top;
       float diff;
       long length;

       phase =	value * (length = p->ftp->flen);
       diff = phase - (long) phase;
       base = (base_address = p->ftp->ftable) + (long)(phase);
       top  = base + 1 ;
       top = (top - base_address > length) ?  base_address : top;
       value = *base + (*top - *base) * diff;
	   */
    }
    *p->r = value * (*p->imax - *p->imin) + *p->imin;   /* scales the output */
}

/*-----------------------------------------------------------------------------*/
/* 21 bit midi control UGs */



void imidic21(MIDICTL4 *p)
{
    float value;
    /*FUNC *ftp;*/
    long   ctlno1;
    long   ctlno2;
    long   ctlno3;
    
    if ((ctlno1 = (long)*p->ictlno1) < 0 || ctlno1 > 127 || 
        (ctlno2 = (long)*p->ictlno2) < 0 || ctlno2 > 127 ||
        (ctlno3 = (long)*p->ictlno3) < 0 || ctlno3 > 127)
      initerror("illegal controller number");
    else {
      value = (float) (
	(curip->m_chnbp->ctl_val[ctlno1] * 16384 +
	 curip->m_chnbp->ctl_val[ctlno2] * 128   +
	 curip->m_chnbp->ctl_val[ctlno3])     
     * oneTOf21bit);
        if (*p->ifn > 0) {
            /* linear interpolation routine */
            FUNC *ftp = ftfind(p->ifn); /* gab-A1 */
            float phase = value * ftp->flen;
            float *base = ftp->ftable + (long)(phase);
            value = *base + (*(base+1) - *base) * (phase - (long)phase);
			/*
            float phase;
            float *base_address;
            float *base;
            float *top;
            float diff;
            long length;

            if ((ftp = ftfind(p->ifn)) == NULL)
	      return; * if valid ftable,use value as index   *
            phase = value * (length = ftp->flen);
            diff = phase - (long) phase;
            base = (base_address = ftp->ftable) + (long)(phase);
            top  = base + 1 ;
            top = (top - base_address > length) ?  base_address : top;
            value = *base + (*top - *base) * diff;
			*/
        } 
        *p->r = value * (*p->imax - *p->imin) + *p->imin;  /* scales the output*/
    }
}


void midic21set(MIDICTL4 *p)
{
    long   ctlno1;
    long   ctlno2;
    long   ctlno3;
    if ((ctlno1 = (long)*p->ictlno1) < 0 || ctlno1 > 127 || 
        (ctlno2 = (long)*p->ictlno2) < 0 || ctlno2 > 127 ||
        (ctlno3 = (long)*p->ictlno3) < 0 || ctlno3 > 127)  
                  initerror("illegal controller number");
    else { 
        p->ctlno1 = ctlno1; 
        p->ctlno2 = ctlno2;
        p->ctlno3 = ctlno3;
    }
    if (*p->ifn > 0) {	
        if (((p->ftp = ftfind(p->ifn)) == NULL))
	  p->flag = FALSE;  /* invalid ftable */
        else
	  p->flag= TRUE; 
    }
    else
      p->flag= FALSE;    
}

void midic21(MIDICTL4 *p)
{
    float value;
    INSDS *curip = p->h.insdshead;

    value = (float)((curip->m_chnbp->ctl_val[p->ctlno1] * 16384 +
	     curip->m_chnbp->ctl_val[p->ctlno2] * 128   +
	     curip->m_chnbp->ctl_val[p->ctlno3] )  * oneTOf21bit);
    if (p->flag)  { 	/* if valid ftable,use value as index   */    
        /* linear interpolation routine */
       float phase = value * p->ftp->flen;
       float *base = p->ftp->ftable + (long)(phase);
       value = *base + (*(base+1) - *base) * (phase - (long) phase);

        /*
		float phase;
        float *base_address;
        float *base;
        float *top;
        float diff;
        long length;

        phase = value * (length = p->ftp->flen);
        diff = phase - (long) phase;
        base = (base_address = p->ftp->ftable) + (long)(phase);
        top  = base + 1 ;
        top = (top - base_address > length) ?  base_address : top;
        value = *base + (*top - *base) * diff;
		*/
    }
    *p->r = value * (*p->imax - *p->imin) + *p->imin;   /* scales the output */
}


/*-----------------------------------------------------------------*/
/* GLOBAL MIDI IN CONTROLS activable by score-oriented instruments*/
/*-----------------------------------------------------------------*/

extern MCHNBLK *m_chnbp[16];

void ictrl7(CTRL7 *p)
{
    float value;
    FUNC *ftp;
    long  ctlno;
    
    if ((ctlno = (long)*p->ictlno) < 0 || ctlno > 127)
      initerror("illegal controller number");
    else {
      value = (float)(m_chnbp[(int) *p->ichan-1]->ctl_val[ctlno]* oneTOf7bit);
      if (*p->ifn > 0) {
	if ((ftp = ftfind(p->ifn)) == NULL)
	  return;		/* if valid ftable,use value as index   */
	value = *(ftp->ftable + (long)(value*ftp->flen)); /* no interpolation */
      }
      *p->r = value * (*p->imax - *p->imin) + *p->imin;  /* scales the output*/
    }
}


void ctrl7set(CTRL7 *p)
{
    long  ctlno;
	int chan;
    if ((ctlno = (long) *p->ictlno) < 0 || ctlno > 127) initerror("illegal controller number");
	else if ((chan=(int) *p->ichan-1) < 0 || chan > 15)  initerror("illegal midi channel"); /* gab-A2 (chan number fix)*/
	/*else if (midi_in_p_num < 0) midi_in_error("ctrl7");*/
    else p->ctlno = ctlno;
    if (*p->ifn > 0) {	
        if (((p->ftp = ftfind(p->ifn)) == NULL)) p->flag = FALSE;  /* invalid ftable */
        else p->flag= TRUE; 
    }
    else p->flag= FALSE;    

/*    if ((ctlno = (long)*p->ictlno) < 0 || ctlno > 127)
      initerror("illegal controller number");
    else p->ctlno = ctlno;
    if (*p->ifn > 0) {	
      if (((p->ftp = ftfind(p->ifn)) == NULL))
	p->flag = FALSE;
      else p->flag= TRUE; 
    }
    else p->flag= FALSE;    
	*/
}

void ctrl7(CTRL7 *p)
{
    float value = (float) (m_chnbp[(int) *p->ichan-1]->ctl_val[p->ctlno] * oneTOf7bit);
    if (p->flag)  {             /* if valid ftable,use value as index   */    
      value =
	*(p->ftp->ftable + (long)(value*p->ftp->flen)); /* no interpolation */
    }
    *p->r = value * (*p->imax - *p->imin) + *p->imin;   /* scales the output */
}


/* 14 bit midi control UGs */

void ictrl14(CTRL14 *p)
{
    float value;
    /*FUNC  *ftp;*/
    long  ctlno1;
    long  ctlno2;
	int chan;
    
    if ((ctlno1 = (long)*p->ictlno1) < 0 || ctlno1 > 127 || 
        (ctlno2 = (long)*p->ictlno2) < 0 || ctlno2 > 127 )
      initerror("illegal controller number");
	else if ((chan=(int) *p->ichan-1) < 0 || chan > 15)  initerror("illegal midi channel");
    else {
      value = (float)((m_chnbp[chan]->ctl_val[ctlno1] * 128 +
	           m_chnbp[chan]->ctl_val[ctlno2]) * oneTOf14bit);

        if (*p->ifn > 0) {
            /* linear interpolation routine */
            register FUNC *ftp = ftfind(p->ifn);
            register float phase = value * ftp->flen;
            register float *base = ftp->ftable + (long)(phase);
            value = *base + (*(base+1) - *base) * (phase - (long)phase);
			/*
			float phase;
            float *base_address;
            float *base;
            float *top;
            float diff;
            long length;

            if ((ftp = ftfind(p->ifn)) == NULL)
	      return;
            phase = value * (length = ftp->flen);
            diff = phase - (long) phase;
            base = (base_address = ftp->ftable) + (long)(phase);
            top  = base + 1 ;
            top = (top - base_address > length) ?  base_address : top;
            value = *base + (*top - *base) * diff;
			*/
        }
        *p->r = value * (*p->imax - *p->imin) + *p->imin;  /* scales the output*/
    }
}


void ctrl14set(CTRL14 *p)
{
    long   ctlno1;
    long   ctlno2;
	int chan;
    if ((ctlno1 = (long)*p->ictlno1) < 0 || ctlno1 > 127 ||
        (ctlno2 = (long)*p->ictlno2) < 0 || ctlno2 > 127 )
      initerror("illegal controller number");
	else if ((chan=(int) *p->ichan-1) < 0 || chan > 15)  initerror("illegal midi channel");
    else { 
        p->ctlno1 = ctlno1; 
        p->ctlno2 = ctlno2;
    }
    if (*p->ifn > 0) {
      if (((p->ftp = ftfind(p->ifn)) == NULL))
	p->flag = FALSE;  /* invalid ftable */
      else p->flag= TRUE; 
    }
    else
      p->flag= FALSE;    
}

void ctrl14(CTRL14 *p)
{
    float value;
	int chan;
    
    value = (float)((m_chnbp[chan=(int) *p->ichan-1]->ctl_val[p->ctlno1] * 128 +
	     m_chnbp[chan]->ctl_val[p->ctlno2]) * oneTOf14bit); 

    if (p->flag)  {		/* if valid ftable,use value as index   */
				/* linear interpolation routine */    
       float phase = value * p->ftp->flen;
       float *base = p->ftp->ftable + (long)(phase);
       value = *base + (*(base+1) - *base) * (phase - (long) phase);

       /*float phase;
       float *base_address;
       float *base;
       float *top;
       float diff;
       long length;

       phase =	value * (length = p->ftp->flen);
       diff = phase - (long) phase;
       base = (base_address = p->ftp->ftable) + (long)(phase);
       top  = base + 1 ;
       top = (top - base_address > length) ?  base_address : top;
       value = *base + (*top - *base) * diff;
	   */
    }
    *p->r = value * (*p->imax - *p->imin) + *p->imin;   /* scales the output */
}

/*-----------------------------------------------------------------------------*/
/* 21 bit midi control UGs */



void ictrl21(CTRL21 *p)
{
    float  value;
    /*FUNC   *ftp;*/
    long   ctlno1;
    long   ctlno2;
    long   ctlno3;
	int chan;
    
    if ((ctlno1 = (long)*p->ictlno1) < 0 || ctlno1 > 127 || 
        (ctlno2 = (long)*p->ictlno2) < 0 || ctlno2 > 127 ||
        (ctlno3 = (long)*p->ictlno3) < 0 || ctlno3 > 127)
      initerror("illegal controller number");
	else if ((chan=(int) *p->ichan-1) < 0 || chan > 15)  initerror("illegal midi channel");
    else {
      value = (float)((m_chnbp[chan]->ctl_val[ctlno1] * 16384 +
	       m_chnbp[chan]->ctl_val[ctlno2] * 128   +
	       m_chnbp[chan]->ctl_val[ctlno3]) * oneTOf21bit);

        if (*p->ifn > 0) {
            /* linear interpolation routine */
            register FUNC *ftp = ftfind(p->ifn);
            register float phase = value * ftp->flen;
            register float *base = ftp->ftable + (long)(phase);
            value = *base + (*(base+1) - *base) * (phase - (long)phase);
			/*
			float phase;
            float *base_address;
            float *base;
            float *top;
            float diff;
            long length;

            if ((ftp = ftfind(p->ifn)) == NULL)
	      return;
            phase = value * (length = ftp->flen);
            diff = phase - (long) phase;
            base = (base_address = ftp->ftable) + (long)(phase);
            top  = base + 1 ;
            top = (top - base_address > length) ?  base_address : top;
            value = *base + (*top - *base) * diff;
		*/
        } 
        *p->r = value * (*p->imax - *p->imin) + *p->imin;  /* scales the output*/
    }
}


void ctrl21set(CTRL21 *p)
{
    long   ctlno1;
    long   ctlno2;
    long   ctlno3;
	int chan;
    if ((ctlno1 = (long)*p->ictlno1) < 0 || ctlno1 > 127 || 
        (ctlno2 = (long)*p->ictlno2) < 0 || ctlno2 > 127 ||
        (ctlno3 = (long)*p->ictlno3) < 0 || ctlno3 > 127)  
                  initerror("illegal controller number");
    else if ((chan=(int) *p->ichan-1) < 0 || chan > 15)  initerror("illegal midi channel");
    else { 
        p->ctlno1 = ctlno1; 
        p->ctlno2 = ctlno2;
        p->ctlno3 = ctlno3;
    }
    if (*p->ifn > 0) {	
        if (((p->ftp = ftfind(p->ifn)) == NULL))
	  p->flag = FALSE;  /* invalid ftable */
        else
	  p->flag= TRUE; 
    }
    else  p->flag= FALSE;    
}

void ctrl21(CTRL21 *p)
{
    float value;
	int chan=(int) *p->ichan-1;
    value = (m_chnbp[chan]->ctl_val[p->ctlno1] * 16384 +
	     m_chnbp[chan]->ctl_val[p->ctlno2] * 128   +
	     m_chnbp[chan]->ctl_val[p->ctlno3]) / f21bit; 

    if (p->flag)  { 	/* if valid ftable,use value as index   */    
        /* linear interpolation routine */ 
       float phase = value * p->ftp->flen;
       float *base = p->ftp->ftable + (long)(phase);
       value = *base + (*(base+1) - *base) * (phase - (long) phase);

        /*
		float phase;
        float *base_address;
        float *base;
        float *top;
        float diff;
	long length;

        phase = value * (length = p->ftp->flen);
        diff = phase - (long) phase;
        base = (base_address = p->ftp->ftable) + (long)(phase);
        top  = base + 1 ;
        top = (top - base_address > length) ?  base_address : top;
        value = *base + (*top - *base) * diff;
		*/
    }
    *p->r = value * (*p->imax - *p->imin) + *p->imin;   /* scales the output */
}


void initc7(INITC7 *p)   /* for setting a precise value use the following formula:*/ 
{					/* (value - min) / (max - min) */
	float fvalue;
	int chan;
	if ((fvalue = *p->ivalue) < 0. || fvalue > 1. )
	  initerror("value out of range");
	else if ((chan=(int) *p->ichan-1) < 0 || chan > 15)  initerror("illegal midi channel");
	else m_chnbp[chan]->ctl_val[(int) *p->ictlno] = fvalue * f7bit + 0.5f;
}

void initc14(INITC14 *p) 
{
	float fvalue;
	int value, msb, lsb, chan;
	if ((fvalue = *p->ivalue) < 0.0f || fvalue > 1.0f )
		  initerror("value out of range");
	else if ((chan=(int) *p->ichan-1) < 0 || chan > 15)  initerror("illegal midi channel");
	else { 
		value = (int)(fvalue * f14bit +.5f);
		msb = value >> 7;
		lsb = value & 0x7F;
	
		m_chnbp[chan]->ctl_val[(int) *p->ictlno1] = (float)msb;
		m_chnbp[chan]->ctl_val[(int) *p->ictlno2] = (float)lsb;
	}
}

void initc21(INITC21 *p) 
{
	float fvalue;
	int value, msb, xsb, lsb, chan;
	if ((fvalue = *p->ivalue) < 0.0f || fvalue > 1.0f )
	  initerror("value out of range");
	else if ((chan=(int) *p->ichan-1) < 0 || chan > 15)  initerror("illegal midi channel");
	else {
		value = (int)(fvalue * f21bit +.5f);
		msb = value >> 14;
		xsb = (value >> 7) & 0x7F;
		lsb = value & 0x7F;
	
		m_chnbp[chan]->ctl_val[(int) *p->ictlno1] = (float)msb;
		m_chnbp[chan]->ctl_val[(int) *p->ictlno2] = (float)xsb;
		m_chnbp[chan]->ctl_val[(int) *p->ictlno3] = (float)lsb;
	}
}

#ifdef GAB_RT /* gab-A1 */

typedef union { 
    unsigned long dwData; 
    unsigned char bData[4]; 
} MIDIMESSAGE; 

extern int  MIDIINBUFMAX;   /* see midi_cs_gab.cpp */
extern unsigned long MIDIINbufIndex; /* see midi_cs_gab.cpp */
MIDIMESSAGE  MIDIINbuffer2[100];

void midiin_set (MIDIIN *p)
{
  	p->local_buf_index = MIDIINbufIndex;
}

void midiin(MIDIIN *p)
{
	MIDIMESSAGE temp;
	if 	(p->local_buf_index < MIDIINbufIndex)	 {
    	   	temp = MIDIINbuffer2[(p->local_buf_index)++ % MIDIINBUFMAX];
 			*p->status = (float) (temp.bData[0] & 0xf0);
			*p->chan   = (float) ((temp.bData[0] & 0x0f) + 1);
			*p->data1  = (float) (temp.bData[1]);
			*p->data2  = (float) (temp.bData[2]);
	}
	else *p->status = 0.;
}

#endif