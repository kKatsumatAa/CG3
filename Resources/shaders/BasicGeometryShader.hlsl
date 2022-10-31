
#include "BasicShaderHeader.hlsli"


[maxvertexcount(3)]
void main(
	triangle VSOutput input[3] : SV_POSITION, //���̓v���~�e�B�u�̎��(32bit(float)���ő�1024��)
	inout TriangleStream< GSOutput > output//�o�̓X�g���[���^
)
{
	//��_���Ԃ�
	for (uint i = 0; i < 3; i++)
	{
		GSOutput element;
		element.svpos = input[i].svpos;
		element.normal = input[i].normal;
		element.uv = input[i].uv;
		output.Append(element);
	}
}