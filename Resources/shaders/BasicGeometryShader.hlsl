
#include "BasicShaderHeader.hlsli"


[maxvertexcount(3)]
void main(
	triangle VSOutput input[3] : SV_POSITION, //入力プリミティブの種類(32bit(float)を最大1024個)
	inout TriangleStream< GSOutput > output//出力ストリーム型
)
{
	//一点ずつ返す
	for (uint i = 0; i < 3; i++)
	{
		GSOutput element;
		element.svpos = input[i].svpos;
		element.normal = input[i].normal;
		element.uv = input[i].uv;
		output.Append(element);
	}
}