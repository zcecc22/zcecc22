/* See LICENSE file for copyright and license details. */

const unsigned int interval = 1000;
static const char unknown_str[] = "n/a";
#define MAXLEN 2048

static const struct arg args[] = {
	/* function      format       argument */
	{ battery_state, "%s",        "BAT0" },
	{ battery_perc,  "%s%%  ",    "BAT0" },
	{ run_command,   "B:%s  ",    "brightnessctl -m | cut -d, -f4" },
	{ run_command,   "V:%s  ",    "wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf \"%d%%\", $2*100}'" },
	{ datetime,      "%s",        "%a %d %b  %H:%M" },
};
