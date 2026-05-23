/* See LICENSE file for copyright and license details. */
#include <X11/XF86keysym.h>

/* appearance */
static const unsigned int borderpx     = 4;
static const unsigned int snap         = 32;
static const int showbar               = 1;
static const int topbar                = 1;
static const int refreshrate           = 60;
#define FONT       "Inconsolata:size=20"
#define FONT_ICONS "Font Awesome 6 Free:style=Solid:size=20"
static const char *fonts[]             = { FONT, FONT_ICONS };
static const char dmenufont[]          = FONT;
static const char col_gray1[]       = "#002b36";
static const char col_gray2[]       = "#073642";
static const char col_gray3[]       = "#839496";
static const char col_gray4[]       = "#93a1a1";
static const char col_cyan[]        = "#174956";
static const char *colors[][3]      = {
        /*               fg         bg         border   */
        [SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
        [SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4" };

static const Rule rules[] = {
	/* class     instance  title  tags mask  isfloating  monitor */
	{ "",        NULL,       NULL,       0,            0,           -1 },
};

/* layout(s) */
static const float mfact        = 0.6;
static const int nmaster        = 1;
static const int resizehints    = 0;
static const int lockfullscreen = 1;

static const Layout layouts[] = {
	{ "[T]", tile    },
	{ "[M]", monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY, view,       {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY, tag,        {.ui = 1 << TAG} },
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0";
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *termcmd[]  = { "st", NULL };

static const Key keys[] = {
	/* modifier                  key                       function        argument */
	{ MODKEY,                    XK_p,                     spawn,          {.v = dmenucmd } },
	{ MODKEY,                    XK_Return,                spawn,          {.v = termcmd } },
	{ MODKEY,                    XK_Tab,                   cyclemaster,    {0} },
	{ MODKEY,                    XK_q,                     killclient,     {0} },
	{ MODKEY,                    XK_t,                     setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                    XK_m,                     setlayout,      {.v = &layouts[1]} },
	{ MODKEY|ShiftMask,          XK_q,                     quit,           {0} },
	{ 0, XF86XK_MonBrightnessUp,   spawn, SHCMD("brightnessctl set +5%") },
	{ 0, XF86XK_MonBrightnessDown, spawn, SHCMD("brightnessctl set 5%-") },
	{ 0, XF86XK_AudioRaiseVolume,  spawn, SHCMD("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+") },
	{ 0, XF86XK_AudioLowerVolume,  spawn, SHCMD("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-") },
	{ 0, XF86XK_AudioMute,         spawn, SHCMD("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle") },
	TAGKEYS(XK_1, 0)
	TAGKEYS(XK_2, 1)
	TAGKEYS(XK_3, 2)
	TAGKEYS(XK_4, 3)
	TAGKEYS(XK_5, 4)
};

/* button definitions */
static const Button buttons[] = {
	{0},
};
