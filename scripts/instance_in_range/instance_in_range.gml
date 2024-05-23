function instance_in_range(paraInst, paraX, paraY, paraW, paraH, paraEdge) {
	if (paraX > paraInst.x + paraEdge) {
		return true;
	}
	if (paraX + paraW < paraInst.x - paraEdge) {
		return true;
	}
	if (paraY > paraInst.y + paraEdge) {
		return true;
	}
	if (paraY + paraH < paraInst.y - paraEdge) {
		return true;
	}
	return false;
}