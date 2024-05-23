

_counter = 0;

var TYPER = instance_create_depth(420, 240, -100, typer);
var PG1 = "{Enter}{Leading 30}{Color Black}{Font RegularBattle}the {Colorful}检查{/Colorful}{Font RagularWorld}first {Font UIWorld}line\n{Color Red}1 {Color Orange}2 {Color Yellow}3 \n4";
var PG2 = "\fNewpage test succeed";
var PG3 = "\f{Color Black}This is the third page\n{Colorful}wow{/Colorful}";
TYPER._text = PG1 + PG2 + PG3;
with (TYPER) {
	Events.PreRender.AddCallback(function () {
		draw_sprite(sprSpeechBubbles, 0, x, y);
	});
	event_user(0)
}

//a
//uniform float iTime
//uniform float iMagnitudePx
//uniform float iPeriodPx
//uniform vec2 iResolution