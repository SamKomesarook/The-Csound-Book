#include <Csound.h>

void main(int argc, const char* argv[])
{
	Csound csound;
	csound.command(argc, argv);
	csound.play();
}

