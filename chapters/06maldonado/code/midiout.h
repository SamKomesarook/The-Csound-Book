/****************************************/
/** midiout UGs by Gabriel Maldonado   **/
/****************************************/

typedef int BOOL;
#ifndef TRUE
#   define TRUE 1
#endif
#ifndef FALSE
#   define FALSE 0;
#endif 

typedef struct {
    OPDS   h;
    float  *r;
} REL;

typedef struct {
    OPDS   h;
    float  *extradur;
} XTRADUR;

typedef struct {
    OPDS   	h;
    float	*freq;
    float	period, clock_tics;
    int 	beginning_flag;

} MCLOCK;

typedef struct {
    OPDS   	h;
    float	*message;
} MRT;


typedef struct {
    OPDS   h;
    float  *ichn,*inum,*ivel;

} OUT_ON;


typedef struct {
    OPDS   h;
    float  *ichn,*inum,*ivel,*idur;
    float  istart_time;
    int    chn, num, vel;
    BOOL   fl_expired, fl_extra_dur;

} OUT_ON_DUR;


typedef struct {
    OPDS   h;
    float  *kchn,*knum,*kvel,*kdur,*kpause;
    float  istart_time;
    int    last_chn, last_num, last_vel;
    float  last_dur, last_pause;
    BOOL   fl_note_expired, fl_first_note, fl_end_note;
} MOSCIL;

typedef struct {
    OPDS   h;
    float  *kchn,*knum,*kvel;
    int	   last_chn, last_num, last_vel;
    BOOL   fl_note_expired, fl_first_note;
} KOUT_ON;

typedef struct {
    OPDS   h;
    float  *chn,*num, *value, *min, *max;
    int    last_value;
} OUT_CONTR;

typedef struct {
    OPDS   h;
    float  *chn, *msb_num, *lsb_num, *value, *min, *max;
    int    last_value;
} OUT_CONTR14;

typedef struct {
    OPDS   h;
    float  *chn, *value, *min, *max;
    int    last_value;
} OUT_PB;

typedef struct {
    OPDS   h;
    float  *chn, *value, *min, *max;
    int    last_value;
} OUT_ATOUCH;

typedef struct {
    OPDS   h;
    float  *chn, *prog_num, *min, *max;
    int    last_prog_num;
} OUT_PCHG;

typedef struct {
    OPDS   h;
    float  *chn, *num, *value, *min, *max;
    int    last_value;
} OUT_POLYATOUCH;

typedef struct {
    OPDS   h;
    float  *kchn,*knum,*kvel,*ktrig;
	int	last_chn, last_num, last_vel;
	BOOL fl_note_expired/*, fl_first_note*/;
} KON2;

/* gab-A1 */
typedef struct {
    OPDS   h;
    float  *in_type, *in_chan, *in_dat1, *in_dat2;
} MIDIOUT;

typedef struct {
    OPDS   h;
    float  *chan, *parm_num, *parm_value;
	int old_chan, old_parm, old_value;
} NRPN;


typedef struct {
	unsigned char status;
	unsigned char dat1;
	unsigned char dat2;
	float	delay;
} DELTAB;

#define DELTAB_LENGTH 1000

typedef struct {
    OPDS   h;
    float  *in_status, *in_chan, *in_dat1, *in_dat2, *kdelay;
	unsigned char status[DELTAB_LENGTH];
	unsigned char chan[DELTAB_LENGTH];
	unsigned char dat1[DELTAB_LENGTH];
	unsigned char dat2[DELTAB_LENGTH];
	float		  time[DELTAB_LENGTH];
	unsigned int  write_index, read_index;
} MDELAY;
/* end gab-A1 */