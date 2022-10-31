
#include "BasicShaderHeader.hlsli"

//(32bit(float)を最大1024個)
[maxvertexcount(3)]
void main(
	point VSOutput input[1] : SV_POSITION, //入力プリミティブの種類
	inout TriangleStream< GSOutput > output//出力ストリーム型
)
{
	GSOutput element;
	//共通
	element.normal = input[0].normal;
	element.uv = input[0].uv;
	//一点目
	element.svpos = input[0].svpos;
	output.Append(element);
	//2点目
	element.svpos = input[0].svpos + float4(10.0f, 10.0f, 0, 0);
	output.Append(element);
	//3点目
	element.svpos = input[0].svpos + float4(10.0f, 0.0f, 0, 0);
	output.Append(element);
}