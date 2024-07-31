TyperHelper = {};
TyperHelper.Command = {};
var COMMAND = TyperHelper.Command;

COMMAND.DecodeTyperArgs = function (paraArg0) {
    return {
        Typer   : paraArg0[0],
        Char    : paraArg0[1],
    };
};
COMMAND.GenCharEffect = function (paraName, paraCallback) {
    WORLD_TYPER.Command.Define(paraName, method({Msd : paraCallback}, function (paraPack) {
    	paraPack[0].Events.PostNewChar.AddCallback(method({Msd : paraCallback}, function (paraTyper, paraChar) {
    		paraChar.Events.CharPreRender.AddCallback(method({Msd : paraCallback}, function (paraChar) {
    			Msd(paraChar.RenderInfo);
    		}));
    	}), paraName);
    }));
    WORLD_TYPER.Command.Define($"/{paraName}", function (paraTyper) {
    	paraTyper.Events.PostNewChar.RemoveCallback(paraName);
    });
};
COMMAND.GenTyperEffect = function (paraName, paraCallback) {
    WORLD_TYPER.Command.Define(paraName, method({Msd : paraCallback}, function (paraTyper) {
        Msd(paraTyper);
    }));
};

TyperHelper.Effect = {};
var EFFECT = TyperHelper.Effect;

EFFECT.AffectTemp = function(paraTyper, paraTmpCallback, paraName) {
    paraTyper.Foreach(method({Msd : paraTmpCallback, Tag : paraName}, function (curChr) {
        curChr.Events.CharPreRender.AddCallback(method({Msd : Msd}, function (paraChar) {
			Msd(paraChar.RenderInfo);
		}), Tag);
    }));
};
EFFECT.Affect = function(paraTyper, paraCallback, paraName) {
    paraTyper.Events.PostNewChar.AddCallback(method({Msd : paraCallback, Tag : paraName}, function (paraTyper, paraChar) {
    	paraChar.Events.CharPreRender.AddCallback(method({Msd : Msd}, function (paraChar) {
    		Msd(paraChar.RenderInfo);
    	}), Tag);
    }), paraName);
};
EFFECT.RemoveTemp = function(paraTyper, paraName) {
    paraTyper.Foreach(method({Tag : paraName}, function (curChr) {
        curChr.Events.CharPreRender.RemoveCallback(Tag);
    }));
};
EFFECT.Remove = function(paraTyper, paraName) {
    paraTyper.Events.PostNewChar.RemoveCallback(paraName);
    paraTyper.Foreach(method({Tag : paraName}, function (curChr) {
        curChr.Events.CharPreRender.RemoveCallback(Tag);
    }));
};

TyperHelper.Typer = {};
var TYPER = TyperHelper.Typer;

TYPER.Foreach = function (paraTyper, paraCallback) {
    var curChr;
    for (var i = 0; i < array_length(paraTyper._textChars); i ++) {
        curChr = paraTyper._textChars[i];
        paraCallback(curChr);
    }
};