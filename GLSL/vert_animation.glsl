#version 330 core

layout (location = 0) in vec3 position;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec2 texcoord;
layout (location = 3) in uvec4 joint;
layout (location = 4) in vec4 weight;

const int MAX_BONES = 128;
uniform mat4 bone_matrix[MAX_BONES];
uniform mat4 projection;
uniform mat4 view;

out VS_OUT
{
    vec2 texcoord;
} vs_out;

void main()
{
    mat4 bond_transform = bone_matrix[joint[0]] * weight[0];
    bond_transform += bone_matrix[joint[1]] * weight[1];
    bond_transform += bone_matrix[joint[2]] * weight[2];
    bond_transform += bone_matrix[joint[3]] * weight[3];

    vec4 bone_position = bond_transform * vec4(position, 1.0);

    vs_out.texcoord = texcoord;
    gl_Position = projection * view * bone_position;
} 