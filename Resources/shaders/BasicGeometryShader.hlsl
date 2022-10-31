
#include "BasicShaderHeader.hlsli"

//(32bit(float)���ő�1024��)
[maxvertexcount(3)]
void main(
	point VSOutput input[1] : SV_POSITION, //���̓v���~�e�B�u�̎��
	inout TriangleStream< GSOutput > output//�o�̓X�g���[���^
)
{
	GSOutput element;
	//����
	element.normal = input[0].normal;
	element.uv = input[0].uv;
	//��_��
	element.svpos = input[0].svpos;
	output.Append(element);
	//2�_��
	element.svpos = input[0].svpos + float4(10.0f, 10.0f, 0, 0);
	output.Append(element);
	//3�_��
	element.svpos = input[0].svpos + float4(10.0f, 0.0f, 0, 0);
	output.Append(element);
}