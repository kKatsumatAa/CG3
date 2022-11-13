
#include "LineShaderHeader.hlsli"

//�l�p�`�̒��_��
static const uint vnum = 2;

//�Z���^�[����̃I�t�Z�b�g
static const float4 offset_array[vnum] =
{
	float4(-0.5f,-1.5f,0,0),//����
	float4(-0.0f,+1.5f,0,0),//����

};

//uv�p
static const float2 uv_array[vnum] =
{
	float2(0,1),//����
	float2(0,0),//����
};

//(32bit(float)���ő�1024��)
[maxvertexcount(vnum)]
void main(
	point VSOutput input[1] : SV_POSITION, //���̓v���~�e�B�u�̎��
	inout LineStream< GSOutput > output//�o�̓X�g���[���^
)
{
	GSOutput element;
	//�l�_��
	for (int i = 0; i < vnum; i++)
	{
		//���S����̃I�t�Z�b�g���X�P�[�����O
		float4 offset = offset_array[i] * input[0].scale;
		//���S����̃I�t�Z�b�g���r���{�[�h��]�i���f�����W�j
		offset = mul(matBillboard, offset);
		//�I�t�Z�b�g�����炷�i���[���h���W�j
		element.svpos = input[0].pos + offset;

		//���[���h���W�x�[�X�ŁA���炷
		//element.svpos = input[0].pos + offset_array[i];
		//�r���[�ˉe�ϊ�
		element.svpos = mul(mat, element.svpos);
		element.uv = uv_array[i];
		element.color = input[0].color;
		output.Append(element);
	}
}