function vertexize()
{
	vertex_format_begin();
	vertex_format_add_position_3d();
	vertex_format_add_normal();
	vertex_format_add_color();
	vertex_format_add_texcoord();
	return(vertex_format_end());
}

function vertex_add_point(vbuffer,vx,vy,vz,nx,ny,nz,u,v,vcolor,valpha)
{
	vertex_position_3d(vbuffer,vx,vy,vz);
	vertex_normal(vbuffer,nx,ny,nz);
	vertex_color(vbuffer,vcolor,valpha);
	vertex_texcoord(vbuffer,u,v);
}

function vertex_add_face(vbuffer,vpos1,vpos2,vpos3,vpos4,vuv=[0,0,1,1],vcolor=-1,valpha=1,npos=[0,0,1])
{
	vertex_add_point(vbuffer,vpos1[0],vpos1[1],vpos1[2],npos[0],npos[1],npos[2],vuv[0],vuv[1],vcolor,valpha);
	vertex_add_point(vbuffer,vpos2[0],vpos2[1],vpos2[2],npos[0],npos[1],npos[2],vuv[2],vuv[1],vcolor,valpha);
	vertex_add_point(vbuffer,vpos3[0],vpos3[1],vpos3[2],npos[0],npos[1],npos[2],vuv[2],vuv[3],vcolor,valpha);
	
	vertex_add_point(vbuffer,vpos1[0],vpos1[1],vpos1[2],npos[0],npos[1],npos[2],vuv[0],vuv[0],vcolor,valpha);
	vertex_add_point(vbuffer,vpos3[0],vpos3[1],vpos3[2],npos[0],npos[1],npos[2],vuv[2],vuv[3],vcolor,valpha);
	vertex_add_point(vbuffer,vpos4[0],vpos4[1],vpos4[2],npos[0],npos[1],npos[2],vuv[0],vuv[3],vcolor,valpha);
}