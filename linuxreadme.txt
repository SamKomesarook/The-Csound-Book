Thanks for purchasing The Csound Book. I hope you get some
inspiration from it and start making music with Csound as a
result.

To use these CD-ROMS with the LINUX operating system, they
must be mounted without case sensitivity. To do this, first
unmount the CD (if already mounted), then mount it again
with the following command from the terminal:

	mount -t iso9660 /dev/cdrom /mnt/cdrom -o map=off

Now the files will all run from the CD (or you can copy them
to the hard disk for improved performance).

To play the Csound Book MP3 files from Netscape in X you
will need to add the correct MIME type description to your
preferences. Click on Netscape's Edit menu, select
Preferences/Navigator/Applications, and add this new MIME
type :

        Description: MP3 Audio
        MIMEType: audio/x-mpeg
        Suffixes: mp3,mp2,mpa,abs,mpega
        Application: xmms %s

Of course you can substitute your personal favorite MP3
player for the application setting (e.g., 'freeamp %s').

To play the MP3s from the Lynx text-mode browser you will
need to uncomment and edit these lines in your
$HOME/lynx.cfg file:

        PERSONAL_EXTENSION_MAP:/home/dlphilp/mime.types
        PERSONAL_MAILCAP:/home/dlphilp/.personal_mailcap

Now create and edit those files, taking care not to
overwrite Netscape's own $HOME/.mime.types (note the
different naming) or your $HOME/.mailcap file (which is
automatically updated by Netscape anyway). Add these lines
to your $HOME/mime.types :

        audio/mpg               mp3 mp2 mpa abs mpega
        audio/mpeg              mp3 mp2 mpa abs mpega
        audio/x-mpeg            mp3 mp2 mpa abs mpega

Then add these lines to your $HOME/.personal_mailcap file : 

        audio/mpg;mpg123 %s
        audio/mpeg;mpg123 %s
        audio/x-mpeg;mpg123 %s

You should now be able to play the MP3s included on the
Csound discs simply by selecting them from your Web browser
whether in X or at the console.

XMMS is available from http://www.xmms.org, mpg123 is
available from http://www.mpg123.de. Other Linux MP3
players, encoders, and utilities are listed on Dave
Phillips' Linux Sound & Music Applications site at
http://sound.condorow.net.

For more information on using the CD-ROMS under the Linux
operating system, including a list of known problems and
solutions, go to http://www.csounds.com. And don't forget to
email me your instruments and your compositions !

Dr. Richard Boulanger
rboulanger@csounds.com
