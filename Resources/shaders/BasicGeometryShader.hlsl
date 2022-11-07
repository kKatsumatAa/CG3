
#include "BasicShaderHeader.hlsli"

//�l�p�`�̒��_��
static const uint vnum = 4;

//�Z���^�[����̃I�t�Z�b�g
static const float4 offset_array[vnum] =
{
	float4(-0.5f,-0.5f,0,0),//����
	float4(-0.5f,+0.5f,0,0),//����
	float4(+0.5f,-0.5f,0,0),//�E��
	float4(+0.5f,+0.5f,0,0),//�E��
};

//uv�p
static const float2 uv_array[vnum] =
{
	float2(0,1),//����
	float2(0,0),//����
	float2(1,1),//�E��
	float2(1,0),//�E��
};

//(32bit(float)���ő�1024��)
[maxvertexcount(vnum)]
void main(
	point VSOutput input[1] : SV_POSITION, //���̓v���~�e�B�u�̎��
	inout TriangleStream< GSOutput > output//�o�̓X�g���[���^
)
{
	GSOutput element;
	//�l�_��
	for (int i = 0; i < vnum; i++)
	{
		//���[���h���W�x�[�X�ŁA���炷
		element.svpos = input[0].pos + offset_array[i];
		//�r���[�ˉe�ϊ�
		element.svpos = mul(mat, element.svpos);
		element.uv = uv_array[i];
		output.Append(element);
	}
}