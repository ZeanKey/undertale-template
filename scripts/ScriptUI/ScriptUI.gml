#macro UI_CALLBACK_SUBMIT "Submit"
#macro UI_CALLBACK_CANCEL "Cancel"
#macro UI_CALLBACK_RENDER "Render"
#macro UI_CALLBACK_UPDATE "Update"

#macro UI_MENU_KEYBIND_PREV "__keyPrev"
#macro UI_MENU_KEYBIND_NEXT "__keyNext"
#macro UI_MENU_KEYBIND_CONFIRM "__keyConfirm"
#macro UI_MENU_KEYBIND_CANCEL "__keyCancel"

UIHelper = {};
UIHelper.Menu = {};

var MENU = UIHelper.Menu;

MENU.__choiceGenerator = {
    __array  : [],
    __font   : "RegularWorldUI",
    __color  : "White",
    __target : noone,
};
MENU.__choiceGenerator.Start = method(MENU.__choiceGenerator, function (paraUI, paraFont = "RegularWorldUI", paraColor = "White") {
    __array  = [];
    __font   = paraFont;
    __color  = paraColor;
    __target = paraUI;
});
MENU.__choiceGenerator.SetFont = method(MENU.__choiceGenerator, function (paraFont) {
    __font = paraFont;
});
MENU.__choiceGenerator.SetColor = method(MENU.__choiceGenerator, function (paraColor) {
    __color = paraColor;
});
MENU.__choiceGenerator.Add = method(MENU.__choiceGenerator, function (paraX, paraY, paraName) {
    array_push(__array, [paraX, paraY, __target.GenerateText(paraName, __font, __color)]);
});
MENU.__choiceGenerator.End = method(MENU.__choiceGenerator, function () {
    var tmpArray = [];
    array_copy_simplified(tmpArray, __array);
    return tmpArray;
});

MENU.Gen = {
    __menuHelper : MENU,
    __choiceGen  : MENU.__choiceGenerator,
    __context    : noone,
    __target     : noone,
    __callbacks  : {
        Submit : function () {
            return false;
        },
        Cancel : function () {
            return false;
        },
    },
    __defaultCallbacks : {
        Submit : function () {
            if (__menu.IsActivated) {
                __stage.Result = __menu._choiceIndex;
                __stage._parent.Stages.Next();
            }
        },
        Cancel : function () {
            if (__menu.IsActivated) {
                __stage._parent.Stages.Back();
            }
        },
        Render : function () {
            return false;
        },
        Update : function () {
            if (__menu.IsActivated) {
                with (__menu) {
                    if (not _isCooling) {
        				_choiceIndex += input_check_pressed(other.__keyNext) - input_check_pressed(other.__keyPrev);
        				_choiceIndex = clamp_loop(_choiceIndex, 0, array_length(_choices) - 1);
        
        				if (input_check_pressed(other.__keyConfirm)) {
        					if (_choiceIndex < array_length(_choices)) {
        						if (_choices[_choiceIndex]._accessible) {
        							Submit();
        							return DELEGATE_EXIT;
        						}
        					}
        				}
        				else if (input_check_pressed(other.__keyCancel)) {
        					Cancel();
        					return DELEGATE_EXIT;
        				}
                    }
    				_choiceIndex = clamp_loop(_choiceIndex, 0, array_length(_choices) - 1);
                }
            }
        },
    },
};
MENU.Gen.Start = method(MENU.Gen, function (paraStage, paraFont = "RegularWorldUI", paraColor = "White") {
    __context = {
        __stage : paraStage,
        __menu : noone,
        __keyPrev       : INPUT.LEFT,
        __keyNext       : INPUT.RIGHT,
        __keyConfirm    : INPUT.CONFIRM,
        __keyCancel     : INPUT.CANCEL,
    };
    __callbacks.Submit = method(__context, __defaultCallbacks.Submit);
    __callbacks.Cancel = method(__context, __defaultCallbacks.Cancel);
    __callbacks.Update = method(__context, __defaultCallbacks.Update);
    __callbacks.Render = method(__context, __defaultCallbacks.Render);
    __target = paraStage;
    __choiceGen.Start(paraStage._parent, paraFont, paraColor);
});
MENU.Gen.Add = method(MENU.Gen, function (paraX, paraY, paraName) {
    __choiceGen.Add(paraX, paraY, paraName);
});
MENU.Gen.AddEncodedString = method(MENU.Gen, function (paraStr) {
    var iniX = 0;
    var curX = 0;
    var curY = 0;
    var curChoice = "";
    
    var curSpX = 0;
    var curSpY = 0;
    
    var inCmd       = false;
    var inChoice    = false;
    
    var curCmd      = [""];
    var curCmdIndex = 0;
    var curChr;
    for (var i = 0; i < string_length(paraStr); i ++) {
        curChr = string_copy(paraStr, i + 1, 1);
        if (inCmd) {
            // Case - New param
            if (curChr = " ") {
                curCmdIndex += 1;
                while (array_length(curCmd) <= curCmdIndex) {
                    array_push(curCmd, "");
                }
                continue;
            }
            // Case - End
            if (curChr = "}") {
                switch (curCmd[0]) {
                    case "font":
                    __choiceGen.SetFont(curCmd[1]);
                    break;
                    case "x":
                    iniX = real(curCmd[1]);
                    curX = real(curCmd[1]);
                    break;
                    case "y":
                    curY = real(curCmd[1]);
                    break;
                    case "space_x":
                    curSpX = real(curCmd[1]);
                    break;
                    case "space_y":
                    curSpY = real(curCmd[1]);
                    break;
                }
                curCmd = [""];
                curCmdIndex = 0;
                inCmd = false;
                continue;
            }
            // Case - Regular
            curCmd[curCmdIndex] += curChr;
            continue;
        }
        
        if (inChoice) {
            // Case - End
            if (curChr == "]") {
                __choiceGen.Add(curX, curY, curChoice);
                curChoice = "";
                curX += curSpX;
                inChoice = false;
                continue;
            }
            // Case - Regular
            curChoice += curChr;
            continue;
        }
        
        if (curChr == "[") {
            inChoice = true;
            continue;
        }
        
        if (curChr == "{") {
            inCmd = true;
            continue;
        }
        
        if (curChr == "\n") {
            curX = iniX;
            curY += curSpY;
        }
    }
});
MENU.Gen.Override = method(MENU.Gen, function (paraType, paraCallback = METHOD_DEFAULT) {
    __callbacks[$ paraType] = paraCallback;
});
MENU.Gen.Inherit = method(MENU.Gen, function (paraType, paraCallback) {
    var tmpDele;
    var tmpOri = __callbacks[$ paraType];
    tmpDele = new Delegates();
    tmpDele.Add(tmpOri);
    tmpDele.Add(paraCallback)
    __callbacks[$ paraType] = tmpDele.Call;
})
MENU.Gen.Rebind = method(MENU.Gen, function (paraOprt, paraInput) {
    __context[$ paraOprt] = paraInput;
})
MENU.Gen.End = method(MENU.Gen, function () {
    var tmpMenu = __target._parent.Widget.Add.Menu(__choiceGen.End(),
        __callbacks.Submit,
        __callbacks.Cancel,
        __callbacks.Render,
        __callbacks.Update);
    __target.Register(tmpMenu);
    __context.__menu = tmpMenu;
    __context = noone;
    __target = noone;
    return tmpMenu;
});
