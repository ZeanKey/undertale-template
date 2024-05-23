/// @desc Culc Figures
_pAcc = _pC * _pDeltaPos - sign(_pVelocity) * (_pDumping * _pVelocity * _pVelocity);
_pVelocity += _pAcc * 1 / _fps;
_pDeltaPos += _pVelocity * 1 / _fps;

//if (_pVelocity <= 0.0005)
//{
//    _pVelocity = 0;
//}

//if (_pAcc <= 0.0005)
//{
//    _pAcc = 0;
//}








