/* See LICENSE file for copyright and license details. */

const unsigned int interval = 1000;
static const char unknown_str[] = "n/a";
#define MAXLEN 2048

#define ICON_SUN "\xef\x86\x85"   /* U+F185  */

static const struct arg args[] = {
	/* function      format                argument */
	{ run_command,   "  %s  ",              "bat-status" },
	{ run_command,   ICON_SUN " %s  ",   "brightnessctl -m | cut -d, -f4" },
	{ run_command,   "%s  ",              "vol-status" },
	{ run_command,   "%s  ",              "net-status" },
	{ datetime,      "%s",                "%a %d %b  %H:%M" },
};
