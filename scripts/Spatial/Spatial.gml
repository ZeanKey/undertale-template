function Model(modelBuffer, transform) constructor {
	Buffer = vertex_create_buffer_from_buffer(modelBuffer, vertexFormat);
	Transform = transform;
}

function Vector3D(posX, posY, posZ) constructor {
	X = posX; Y = posY; Z = posZ;
}

function Vec3(xx, yy, zz) constructor {
	X = xx;
	Y = yy;
	Z = zz;
}

function TransformData(position, rotation, scale) constructor {
	Position = position;
	Rotation = rotation;
	Scale = scale;
}

//Add your model files(*.obj only) into the datafiles folder and load them by their names.
function LoadModel(fileName, vertexFormat) {
	var buffer = buffer_load(fileName);
    var content_string = buffer_read(buffer, buffer_text);
    buffer_delete(buffer);

    static px = buffer_create(10000, buffer_grow, 4);
    static py = buffer_create(10000, buffer_grow, 4);
    static pz = buffer_create(10000, buffer_grow, 4);
    static nx = buffer_create(10000, buffer_grow, 4);
    static ny = buffer_create(10000, buffer_grow, 4);
    static nz = buffer_create(10000, buffer_grow, 4);
    static tx = buffer_create(10000, buffer_grow, 4);
    static ty = buffer_create(10000, buffer_grow, 4);
    buffer_seek(px, buffer_seek_start, 4);
    buffer_seek(py, buffer_seek_start, 4);
    buffer_seek(pz, buffer_seek_start, 4);
    buffer_seek(nx, buffer_seek_start, 4);
    buffer_seek(ny, buffer_seek_start, 4);
    buffer_seek(nz, buffer_seek_start, 4);
    buffer_seek(tx, buffer_seek_start, 4);
    buffer_seek(ty, buffer_seek_start, 4);

    var lines = string_split(content_string, "\n");

    var vBuffer = vertex_create_buffer();
    vertex_begin(vBuffer, vertexFormat);

    var i = 0;
    repeat (array_length(lines)) {
        var this_line = lines[i++];
        if (this_line == "") continue;

        var tokens = string_split(this_line, " ");

        switch (tokens[0]) {
            case "v":
                buffer_write(px, buffer_f32, real(tokens[1]));
                buffer_write(py, buffer_f32, real(tokens[3]));
                buffer_write(pz, buffer_f32, real(tokens[2]));
                break;
            case "vt":
                buffer_write(tx, buffer_f32, real(tokens[1]));
                buffer_write(ty, buffer_f32, 1 - real(tokens[2]));
                break;
            case "vn":
                buffer_write(nx, buffer_f32, real(tokens[1]));
                buffer_write(ny, buffer_f32, real(tokens[3]));
                buffer_write(nz, buffer_f32, real(tokens[2]));
                break;
            case "f":
                var n = array_length(tokens);
                for (var j = 1; j < n; j++) {
                    tokens[j] = string_split(tokens[j], "/");
                }
                for (var j = 2; j < n; j++) {
                    var v1 = tokens[1];
                    var v2 = tokens[j - 1];
                    var v3 = tokens[j];

                    var pi1 = 4 * real(v1[0]);
                    var pi2 = 4 * real(v2[0]);
                    var pi3 = 4 * real(v3[0]);
                    var v1_position_x = buffer_peek(px, pi1, buffer_f32);
                    var v1_position_y = buffer_peek(py, pi1, buffer_f32);
                    var v1_position_z = buffer_peek(pz, pi1, buffer_f32);
                    var v2_position_x = buffer_peek(px, pi2, buffer_f32);
                    var v2_position_y = buffer_peek(py, pi2, buffer_f32);
                    var v2_position_z = buffer_peek(pz, pi2, buffer_f32);
                    var v3_position_x = buffer_peek(px, pi3, buffer_f32);
                    var v3_position_y = buffer_peek(py, pi3, buffer_f32);
                    var v3_position_z = buffer_peek(pz, pi3, buffer_f32);

                    var v1_normal_x = 0, v1_normal_y = 0, v1_normal_z = 0;
                    var v2_normal_x = 0, v2_normal_y = 0, v2_normal_z = 0;
                    var v3_normal_x = 0, v3_normal_y = 0, v3_normal_z = 0;
                    var v1_texcoord_x = 0, v1_texcoord_y = 0;
                    var v2_texcoord_x = 0, v2_texcoord_y = 0;
                    var v3_texcoord_x = 0, v3_texcoord_y = 0;

                    switch (array_length(v1)) {
                        case 2:
                            var ti = 4 * real(v1[1]);
                            v1_texcoord_x = buffer_peek(tx, ti, buffer_f32);
                            v1_texcoord_y = buffer_peek(ty, ti, buffer_f32);
                            break;
                        case 3:
                            if (v1[1] != "") {
                                ti = 4 * real(v1[1]);
                                v1_texcoord_x = buffer_peek(tx, ti, buffer_f32);
                                v1_texcoord_y = buffer_peek(ty, ti, buffer_f32);
                            }
                            var ni = 4 * real(v1[2]);
                            v1_normal_x = buffer_peek(nx, ni, buffer_f32);
                            v1_normal_y = buffer_peek(ny, ni, buffer_f32);
                            v1_normal_z = buffer_peek(nz, ni, buffer_f32);
                            break;
                    }
                    switch (array_length(v2)) {
                        case 2:
                            var ti = 4 * real(v2[1]);
                            v2_texcoord_x = buffer_peek(tx, ti, buffer_f32);
                            v2_texcoord_y = buffer_peek(ty, ti, buffer_f32);
                            break;
                        case 3:
                            if (v2[1] != "") {
                                ti = 4 * real(v2[1]);
                                v2_texcoord_x = buffer_peek(tx, ti, buffer_f32);
                                v2_texcoord_y = buffer_peek(ty, ti, buffer_f32);
                            }
                            var ni = 4 * real(v2[2]);
                            v2_normal_x = buffer_peek(nx, ni, buffer_f32);
                            v2_normal_y = buffer_peek(ny, ni, buffer_f32);
                            v2_normal_z = buffer_peek(nz, ni, buffer_f32);
                            break;
                    }
                    switch (array_length(v3)) {
                        case 2:
                            var ti = 4 * real(v3[1]);
                            v3_texcoord_x = buffer_peek(tx, ti, buffer_f32);
                            v3_texcoord_y = buffer_peek(ty, ti, buffer_f32);
                            break;
                        case 3:
                            if (v3[1] != "") {
                                ti = 4 * real(v3[1]);
                                v3_texcoord_x = buffer_peek(tx, ti, buffer_f32);
                                v3_texcoord_y = buffer_peek(ty, ti, buffer_f32);
                            }
                            var ni = 4 * real(v3[2]);
                            v3_normal_x = buffer_peek(nx, ni, buffer_f32);
                            v3_normal_y = buffer_peek(ny, ni, buffer_f32);
                            v3_normal_z = buffer_peek(nz, ni, buffer_f32);
                            break;
                    }

                    vertex_position_3d(vBuffer, v1_position_x, v1_position_y, v1_position_z);
                    vertex_normal(vBuffer, v1_normal_x, v1_normal_y, v1_normal_z);
                    vertex_texcoord(vBuffer, v1_texcoord_x, v1_texcoord_y);
                    vertex_colour(vBuffer, c_white, 1);

                    vertex_position_3d(vBuffer, v2_position_x, v2_position_y, v2_position_z);
                    vertex_normal(vBuffer, v2_normal_x, v2_normal_y, v2_normal_z);
                    vertex_texcoord(vBuffer, v2_texcoord_x, v2_texcoord_y);
                    vertex_colour(vBuffer, c_white, 1);

                    vertex_position_3d(vBuffer, v3_position_x, v3_position_y, v3_position_z);
                    vertex_normal(vBuffer, v3_normal_x, v3_normal_y, v3_normal_z);
                    vertex_texcoord(vBuffer, v3_texcoord_x, v3_texcoord_y);
                    vertex_colour(vBuffer, c_white, 1);
                }
                break;
        }
    }

    vertex_end(vBuffer);
    vertex_freeze(vBuffer);

	var model = new Model(vBuffer, new TransformData(new Vec3(0, 0, 0), new Vec3(0, 0, 0), new Vec3(1, 1, 1)));
	vertex_delete_buffer(vBuffer);

    return model;
}

function load_obj_without_mtl(filename,vertex_format) {

	// Open the file
	var obj_file = file_text_open_read(filename);

	// Create the vertex buffer
	var model = vertex_create_buffer();
	vertex_begin(model,vertex_format);

	// Create the lists of position/normal/texture data
	var vertex_x = ds_list_create();
	var vertex_y = ds_list_create();
	var vertex_z = ds_list_create();

	var vertex_nx = ds_list_create();
	var vertex_ny = ds_list_create();
	var vertex_nz = ds_list_create();

	var vertex_xtex = ds_list_create();
	var vertex_ytex = ds_list_create();

	// Read each line in the file
	while(not file_text_eof(obj_file)){
		var line = file_text_read_string(obj_file);
		file_text_readln(obj_file);
		// Split each line around the space character
		var terms, index;
		index = 0;
		terms = array_create(string_count(line, " ") + 1, "");
		for (var i = 1; i <= string_length(line); i++){
			if (string_char_at(line, i) == " "){
				index++;
				terms[index] = "";
			} else {
				terms[index] += string_char_at(line, i);
			}
		}
		switch(terms[0]){
			// Add the vertex x, y an z position to their respective lists
			case "v":
				ds_list_add(vertex_x, real(terms[1]));
				ds_list_add(vertex_y, real(terms[2]));
				ds_list_add(vertex_z, real(terms[3]));
				break;
			// Add the vertex x and y texture position (or "u" and "v") to their respective lists
			case "vt":
				ds_list_add(vertex_xtex, real(terms[1]));
				ds_list_add(vertex_ytex, real(terms[2]));
				break;
			// Add the vertex normal's x, y and z components to their respective lists
			case "vn":
				ds_list_add(vertex_nx, real(terms[1]));
				ds_list_add(vertex_ny, real(terms[2]));
				ds_list_add(vertex_nz, real(terms[3]));
				break;
			case "f":
				// Split each term around the slash character
				for (var n = 1; n <= 3; n++){
					var data, index;
					index = 0;
					data = array_create(string_count(terms[n], "/") + 1, "");
					for (var i = 1; i <= string_length(terms[n]); i++){
						if (string_char_at(terms[n], i) == "/"){
							index++;
							data[index] = "";
						} else {
							data[index] += string_char_at(terms[n], i);
						}
					}
					// Look up the x, y, z, normal x, y, z and texture x, y in the already-created lists
					var xx = ds_list_find_value(vertex_x, real(data[0]) - 1);
					var yy = ds_list_find_value(vertex_y, real(data[0]) - 1);
					var zz = ds_list_find_value(vertex_z, real(data[0]) - 1);
					var xtex = ds_list_find_value(vertex_xtex, real(data[1]) - 1);
					var ytex = ds_list_find_value(vertex_ytex, real(data[1]) - 1);
					var nx = ds_list_find_value(vertex_nx, real(data[2]) - 1);
					var ny = ds_list_find_value(vertex_ny, real(data[2]) - 1);
					var nz = ds_list_find_value(vertex_nz, real(data[2]) - 1);
				
					// If the material exists in the materials map(s), set the vertex's color and alpha
					// (and other attributes, if you want to use them) based on the material

					var color = c_white;
					var alpha = 1;
					
					// Optional: swap the y and z positions (useful if you used the default Blender export settings)
					var t = yy;
					yy = zz;
					zz = t;
				
					// Add the data to the vertex buffers
					vertex_position_3d(model, xx, yy, zz);
					vertex_normal(model, nx, ny, nz);
					vertex_texcoord(model, xtex, ytex);
					vertex_color(model, color, alpha);
				}
				break;
			default:
				// There are a few other things you can find in an obj file that I haven't covered here (but may in the future)
				break;
		}
	}

	// End the vertex buffer, destroy the lists, close the text file and return the vertex buffer

	vertex_end(model);

	ds_list_destroy(vertex_x);
	ds_list_destroy(vertex_y);
	ds_list_destroy(vertex_z);
	ds_list_destroy(vertex_nx);
	ds_list_destroy(vertex_ny);
	ds_list_destroy(vertex_nz);
	ds_list_destroy(vertex_xtex);
	ds_list_destroy(vertex_ytex);

	file_text_close(obj_file);

	return model;
}

vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_texcoord();
vertex_format_add_color();
global.format_object = vertex_format_end();

global.boneModel = load_obj_without_mtl("bone_head.obj", global.format_object);
global.cubeModel = load_obj_without_mtl("cube_model.obj", global.format_object);
