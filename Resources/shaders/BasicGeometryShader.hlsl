
#include "BasicShaderHeader.hlsli"


[maxvertexcount(6)]
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
		element.uv = input[i].uv * 2.0f;
		//頂点を一つ出力（出力リストに追加）
		output.Append(element);
	}
	output.RestartStrip();
	//二つ目
	for (uint i = 0; i < 3; i++)
	{
		GSOutput element;
		element.svpos = input[i].svpos + float4(20.0f, 0, 0, 0);
		element.normal = input[i].normal;
		element.uv = input[i].uv * 5.0f;
		//頂点を一つ出力（出力リストに追加）
		output.Append(element);
	}
}