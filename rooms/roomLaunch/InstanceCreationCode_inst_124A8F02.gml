Interact = function (paraEntity, paraSide) {
	if (paraSide == DIR.DOWN) {
		WORLD_OVERWORLD.Typer.Generate.Dialog("* 这是一块告示牌\n* 上面写着一些文字\f* \"测试文本\nTest Text\"");
	}
	else if (paraSide == DIR.LEFT) {
		WORLD_OVERWORLD.Typer.Generate.Dialog("* 这是一块告示牌\n* 显然从左面来看是看不见上面的文字的");
	}
	else if (paraSide == DIR.RIGHT) {
		WORLD_OVERWORLD.Typer.Generate.Dialog("* 这是一块告示牌\n* 从右面看也看不见上面写的什么");
	}
	else if (paraSide == DIR.UP) {
		WORLD_OVERWORLD.Typer.Generate.Dialog("* 这是一块告示牌\n* 假若从另一面看就能看见上面的文字了");
	}
};
